import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:infixedu/app/modules/student_search_attendance/views/widget/display_dot.dart';
import 'package:infixedu/app/utilities/message/snack_bars.dart';
import 'package:get/get.dart';

import '../../../../config/global_variable/global_variable_controller.dart';
import '../../../../domain/base_client/base_client.dart';
import '../../../../domain/core/model/attendance_response_model/student_attendance_response_model.dart';
import '../../../utilities/api_urls.dart';
import '../../../utilities/widgets/loader/loading.controller.dart';
import '../../home/controllers/home_controller.dart';

class StudentSearchAttendanceController extends GetxController {
  GlobalRxVariableController globalRxVariableController = Get.find();
  LoadingController loadingController = Get.find();
  HomeController homeController = Get.find();

  static const halfDayEvent = DisplayDot(color: Color(0xFF5057FC));
  static const presentEvent = DisplayDot(color: Color(0xFF00C106));
  static const lateEvent = DisplayDot(color: Color(0xFFFF6F00));
  static const absentEvent = DisplayDot(color: Color(0xFFF32E21));
  static const holidayEvent = DisplayDot(color: Color(0xFF462564));

  RxInt present = 0.obs;
  RxInt halfDay = 0.obs;
  RxInt late = 0.obs;
  RxInt absent = 0.obs;
  RxInt holiday = 0.obs;
  RxInt recordId = 0.obs;
  RxBool fromStatus = false.obs;

  DateTime currentDate = DateTime.now();
  final selectIndex = RxInt(0);

  Map<DateTime, List<Event>> customEventList = {};
  EventList<Event>? eventList;
  RxList<Attendances> attendanceList = <Attendances>[].obs;

  int? subjectId;

  void setEventData() {
    if (attendanceList.isNotEmpty) {
      customEventList[DateTime(
          attendanceList[0].attendanceDate!.year,
          attendanceList[0].attendanceDate!.month,
          attendanceList[0].attendanceDate!.day)] = [
        Event(
          date: DateTime(
              attendanceList[0].attendanceDate!.year,
              attendanceList[0].attendanceDate!.month,
              attendanceList[0].attendanceDate!.day),
          dot: GlobalVariable.getAttendanceStatus(
              attendanceList[0].attendanceType?.toUpperCase() ?? ""),
        )
      ];
    }

    eventList = EventList<Event>(events: customEventList);

    update();
  }

  Future<StudentAttendanceResponseModel?> getAttendanceList({
    required int recordId,
    required int studentId,
  }) async {
    try {
      loadingController.isLoading = true;

      final response = await BaseClient().getData(
        url: InfixApi.getStudentAttendance(
            recordId: recordId, studentId: studentId),
        header: GlobalVariable.header,
      );

      StudentAttendanceResponseModel attendanceResponseModel =
          StudentAttendanceResponseModel.fromJson(response);
      if (attendanceResponseModel.success == true) {
        // loadingController.isLoading = false;

        present.value = attendanceResponseModel.data?.present ?? 0;
        halfDay.value = attendanceResponseModel.data?.halfDay ?? 0;
        late.value = attendanceResponseModel.data?.late ?? 0;
        absent.value = attendanceResponseModel.data?.absent ?? 0;
        holiday.value = attendanceResponseModel.data?.holidayDay ?? 0;

        // currentDate = DateTime.tryParse(attendanceResponseModel.data!.currentDay!) ?? DateTime.now();

        if (attendanceResponseModel.data!.attendances!.isNotEmpty) {
          for (int i = 0;
              i < attendanceResponseModel.data!.attendances!.length;
              i++) {
            attendanceList.add(attendanceResponseModel.data!.attendances![i]);
            customEventList[DateTime(
                attendanceList[i].attendanceDate!.year,
                attendanceList[i].attendanceDate!.month,
                attendanceList[i].attendanceDate!.day)] = [
              Event(
                date: DateTime(
                    attendanceList[i].attendanceDate!.year,
                    attendanceList[i].attendanceDate!.month,
                    attendanceList[i].attendanceDate!.day),
                dot: GlobalVariable.getAttendanceStatus(
                    attendanceList[i].attendanceType?.toUpperCase() ?? ""),
              ),
            ];
          }
        }
      }
    } catch (e, t) {
      // loadingController.isLoading = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      loadingController.isLoading = false;
    }
    return StudentAttendanceResponseModel();
  }

  Future<StudentAttendanceResponseModel?> getAttendanceListWithDate({
    required int recordId,
    required int studentId,
    required int year,
    required int month,
  }) async {
    try {
      loadingController.isLoading = true;

      eventList?.clear();
      attendanceList.clear();
      final response = await BaseClient().getData(
        url: InfixApi.getStudentAttendanceWithDate(
          recordId: recordId,
          studentId: studentId,
          year: year,
          month: month,
        ),
        header: GlobalVariable.header,
      );

      StudentAttendanceResponseModel attendanceResponseModel =
          StudentAttendanceResponseModel.fromJson(response);
      if (attendanceResponseModel.success == true) {
        loadingController.isLoading = false;

        present.value = attendanceResponseModel.data?.present ?? 0;
        halfDay.value = attendanceResponseModel.data?.halfDay ?? 0;
        late.value = attendanceResponseModel.data?.late ?? 0;
        absent.value = attendanceResponseModel.data?.absent ?? 0;
        holiday.value = attendanceResponseModel.data?.holidayDay ?? 0;

        /// current date changed
        currentDate =
            DateTime.tryParse(attendanceResponseModel.data!.currentDay!) ??
                DateTime.now();

        if (attendanceResponseModel.data!.attendances!.isNotEmpty) {
          for (int i = 0;
              i < attendanceResponseModel.data!.attendances!.length;
              i++) {
            attendanceList.add(attendanceResponseModel.data!.attendances![i]);
            customEventList[DateTime(
                attendanceList[i].attendanceDate!.year,
                attendanceList[i].attendanceDate!.month,
                attendanceList[i].attendanceDate!.day)] = [
              Event(
                date: DateTime(
                    attendanceList[i].attendanceDate!.year,
                    attendanceList[i].attendanceDate!.month,
                    attendanceList[i].attendanceDate!.day),
                dot: GlobalVariable.getAttendanceStatus(
                    attendanceList[i].attendanceType?.toUpperCase() ?? ""),
              )
            ];
          }
        }
      }
    } catch (e, t) {
      loadingController.isLoading = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      loadingController.isLoading = false;
    }
    return StudentAttendanceResponseModel();
  }

  Future<StudentAttendanceResponseModel?> getSearchSubjectAttendanceList({
    required int recordId,
    required int studentId,
    required int subjectId,
  }) async {
    try {
      final response = await BaseClient().getData(
        url: InfixApi.getStudentSubjectSearchAttendance(
          recordId: recordId,
          studentId: studentId,
          subjectId: subjectId,
        ),
        header: GlobalVariable.header,
      );

      StudentAttendanceResponseModel attendanceResponseModel =
          StudentAttendanceResponseModel.fromJson(response);
      if (attendanceResponseModel.success == true) {
        loadingController.isLoading = false;

        present.value = attendanceResponseModel.data?.present ?? 0;
        halfDay.value = attendanceResponseModel.data?.halfDay ?? 0;
        late.value = attendanceResponseModel.data?.late ?? 0;
        absent.value = attendanceResponseModel.data?.absent ?? 0;
        holiday.value = attendanceResponseModel.data?.holidayDay ?? 0;

        currentDate =
            DateTime.tryParse(attendanceResponseModel.data!.currentDay!) ??
                DateTime.now();
        if (attendanceResponseModel.data!.attendances!.isNotEmpty) {
          for (int i = 0;
              i < attendanceResponseModel.data!.attendances!.length;
              i++) {
            attendanceList.add(attendanceResponseModel.data!.attendances![i]);
            customEventList[DateTime(
                attendanceList[i].attendanceDate!.year,
                attendanceList[i].attendanceDate!.month,
                attendanceList[i].attendanceDate!.day)] = [
              Event(
                date: DateTime(
                    attendanceList[i].attendanceDate!.year,
                    attendanceList[i].attendanceDate!.month,
                    attendanceList[i].attendanceDate!.day),
                dot: GlobalVariable.getAttendanceStatus(
                    attendanceList[i].attendanceType?.toUpperCase() ?? ""),
              )
            ];
          }
        }
      } else {
        showBasicFailedSnackBar(
            message:
                attendanceResponseModel.message ?? 'Something went wrong'.tr);
      }
    } catch (e, t) {
      debugPrint('$e');
      debugPrint('$t');
      t.printInfo();
    } finally {
      loadingController.isLoading = false;
    }
    return StudentAttendanceResponseModel();
  }

  Future<StudentAttendanceResponseModel?>
      getSearchSubjectAttendanceListWithDate({
    required int recordId,
    required int studentId,
    required int subjectId,
    required int year,
    required int month,
  }) async {
    try {
      loadingController.isLoading = true;

      eventList?.clear();
      attendanceList.clear();

      final response = await BaseClient().getData(
        url: InfixApi.getStudentSubjectSearchAttendanceWithDate(
          recordId: recordId,
          studentId: studentId,
          year: year,
          month: month,
          subjectId: subjectId,
        ),
        header: GlobalVariable.header,
      );

      StudentAttendanceResponseModel attendanceResponseModel =
          StudentAttendanceResponseModel.fromJson(response);
      if (attendanceResponseModel.success == true) {
        loadingController.isLoading = false;

        present.value = attendanceResponseModel.data?.present ?? 0;
        halfDay.value = attendanceResponseModel.data?.halfDay ?? 0;
        late.value = attendanceResponseModel.data?.late ?? 0;
        absent.value = attendanceResponseModel.data?.absent ?? 0;
        holiday.value = attendanceResponseModel.data?.holidayDay ?? 0;

        currentDate =
            DateTime.tryParse(attendanceResponseModel.data!.currentDay!) ??
                DateTime.now();
        if (attendanceResponseModel.data!.attendances!.isNotEmpty) {
          for (int i = 0;
              i < attendanceResponseModel.data!.attendances!.length;
              i++) {
            attendanceList.add(attendanceResponseModel.data!.attendances![i]);
            customEventList[DateTime(
                attendanceList[i].attendanceDate!.year,
                attendanceList[i].attendanceDate!.month,
                attendanceList[i].attendanceDate!.day)] = [
              Event(
                date: DateTime(
                    attendanceList[i].attendanceDate!.year,
                    attendanceList[i].attendanceDate!.month,
                    attendanceList[i].attendanceDate!.day),
                dot: GlobalVariable.getAttendanceStatus(
                    attendanceList[i].attendanceType?.toUpperCase() ?? ""),
              )
            ];
          }
        }
      }
    } catch (e, t) {
      loadingController.isLoading = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      loadingController.isLoading = false;
    }
    return StudentAttendanceResponseModel();
  }

  @override
  void onInit() {
    fromStatus.value = Get.arguments["from"];

    if (homeController.studentRecordList.isNotEmpty) {
      recordId.value = homeController.studentRecordList[0].id;
    }

    if (fromStatus.value) {
      subjectId = Get.arguments["subjectID"];

      WidgetsBinding.instance.addPostFrameCallback((_) {
        getSearchSubjectAttendanceList(
                recordId: recordId.toInt(),
                studentId: globalRxVariableController.studentId.value!,
                subjectId: subjectId!)
            .then((value) => setEventData());
      });
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        getAttendanceList(
          recordId: recordId.toInt(),
          studentId: globalRxVariableController.studentId.value!,
        ).then((value) => setEventData());
      });
    }

    super.onInit();
  }
}
