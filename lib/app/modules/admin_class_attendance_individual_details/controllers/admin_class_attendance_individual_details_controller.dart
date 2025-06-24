import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:infixedu/app/modules/student_search_attendance/views/widget/display_dot.dart';
import 'package:infixedu/app/utilities/api_urls.dart';
import 'package:infixedu/config/global_variable/global_variable_controller.dart';
import 'package:infixedu/domain/base_client/base_client.dart';
import 'package:infixedu/domain/core/model/admin/admin_attendance_model/admin_student_search_atten_response_model.dart';
import 'package:get/get.dart';

class AdminClassAttendanceIndividualDetailsController extends GetxController {
  GlobalRxVariableController globalRxVariableController = Get.find();

  static const halfDayEvent = DisplayDot(color: Color(0xFF5057FC));
  static const presentEvent = DisplayDot(color: Color(0xFF00C106));
  static const lateEvent = DisplayDot(color: Color(0xFFFF6F00));
  static const absentEvent = DisplayDot(color: Color(0xFFF32E21));
  static const holidayEvent = DisplayDot(color: Color(0xFF462564));

  final selectIndex = RxInt(0);
  DateTime currentDate = DateTime.now();
  Map<DateTime, List<Event>> customEventList = {};
  EventList<Event>? eventList;

  RxInt present = 0.obs;
  RxInt halfDay = 0.obs;
  RxInt late = 0.obs;
  RxInt absent = 0.obs;
  RxInt holiday = 0.obs;

  RxString classSection = ''.obs;

  /// Receive Arguments
  RxInt studentAttendanceId = 0.obs;
  RxBool isLoading = false.obs;

  RxList<AdminStudentAttendanceSingleData> adminStudentAttendanceList =
      <AdminStudentAttendanceSingleData>[].obs;

  Future<AdminStudentSearchAttenResponseModel?>
      getAdminStudentSearchAttendanceDetailsList({
    required int studentAttendanceId,
  }) async {
    try {
      adminStudentAttendanceList.clear();
      eventList?.clear();
      isLoading.value = true;

      final response = await BaseClient().getData(
        url: globalRxVariableController.roleId.value == 1
            ? InfixApi.getAdminStudentSearchDetailsList(
                studentAttendanceId: studentAttendanceId)
            : InfixApi.getTeacherStudentSearchDetailsList(
                studentAttendanceId: studentAttendanceId),
        header: GlobalVariable.header,
      );

      AdminStudentSearchAttenResponseModel
          adminStudentSearchAttenResponseModel =
          AdminStudentSearchAttenResponseModel.fromJson(response);
      if (adminStudentSearchAttenResponseModel.success == true) {
        isLoading.value = false;

        present.value = adminStudentSearchAttenResponseModel.data?.p ?? 0;
        halfDay.value = adminStudentSearchAttenResponseModel.data?.f ?? 0;
        late.value = adminStudentSearchAttenResponseModel.data?.l ?? 0;
        absent.value = adminStudentSearchAttenResponseModel.data?.a ?? 0;
        holiday.value = adminStudentSearchAttenResponseModel.data?.h ?? 0;

        classSection.value =
            '${"Class".tr} ${adminStudentSearchAttenResponseModel.data!.className} (${adminStudentSearchAttenResponseModel.data!.section})';

        currentDate = DateTime.tryParse(
                adminStudentSearchAttenResponseModel.data!.currentDay!) ??
            DateTime.now();
        if (adminStudentSearchAttenResponseModel
            .data!.attendances!.isNotEmpty) {
          for (int i = 0;
              i <
                  adminStudentSearchAttenResponseModel
                      .data!.attendances!.length;
              i++) {
            adminStudentAttendanceList.add(
                adminStudentSearchAttenResponseModel.data!.attendances![i]);
            customEventList[DateTime(
                adminStudentAttendanceList[i].attendanceDate!.year,
                adminStudentAttendanceList[i].attendanceDate!.month,
                adminStudentAttendanceList[i].attendanceDate!.day)] = [
              Event(
                date: DateTime(
                    adminStudentAttendanceList[i].attendanceDate!.year,
                    adminStudentAttendanceList[i].attendanceDate!.month,
                    adminStudentAttendanceList[i].attendanceDate!.day),
                dot: GlobalVariable.getAttendanceStatus(
                  adminStudentAttendanceList[i].attendanceType ?? "",
                ),
              ),
            ];
          }
        }
      }
    } catch (e, t) {
      isLoading.value = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      isLoading.value = false;
    }
    return AdminStudentSearchAttenResponseModel();
  }

  Future<AdminStudentSearchAttenResponseModel?>
      getAdminStudentSearchAttendanceDetailsListWithDate({
    required int studentAttendanceId,
    required int month,
    required int year,
  }) async {
    try {
      adminStudentAttendanceList.clear();
      eventList?.clear();
      isLoading.value = true;

      final response = await BaseClient().getData(
        url: globalRxVariableController.roleId.value == 1
            ? InfixApi.getAdminStudentSearchDetailsListWithDate(
                studentAttendanceId: studentAttendanceId,
                month: month,
                year: year)
            : InfixApi.getTeacherStudentSearchDetailsListWithDate(
                studentAttendanceId: studentAttendanceId,
                month: month,
                year: year),
        header: GlobalVariable.header,
      );

      AdminStudentSearchAttenResponseModel
          adminStudentSearchAttenResponseModel =
          AdminStudentSearchAttenResponseModel.fromJson(response);
      if (adminStudentSearchAttenResponseModel.success == true) {
        isLoading.value = false;

        present.value = adminStudentSearchAttenResponseModel.data?.p ?? 0;
        halfDay.value = adminStudentSearchAttenResponseModel.data?.f ?? 0;
        late.value = adminStudentSearchAttenResponseModel.data?.l ?? 0;
        absent.value = adminStudentSearchAttenResponseModel.data?.a ?? 0;
        holiday.value = adminStudentSearchAttenResponseModel.data?.h ?? 0;

        currentDate = DateTime.tryParse(
                adminStudentSearchAttenResponseModel.data!.currentDay!) ??
            DateTime.now();
        if (adminStudentSearchAttenResponseModel
            .data!.attendances!.isNotEmpty) {
          for (int i = 0;
              i <
                  adminStudentSearchAttenResponseModel
                      .data!.attendances!.length;
              i++) {
            adminStudentAttendanceList.add(
                adminStudentSearchAttenResponseModel.data!.attendances![i]);
            customEventList[DateTime(
                adminStudentAttendanceList[i].attendanceDate!.year,
                adminStudentAttendanceList[i].attendanceDate!.month,
                adminStudentAttendanceList[i].attendanceDate!.day)] = [
              Event(
                date: DateTime(
                  adminStudentAttendanceList[i].attendanceDate!.year,
                  adminStudentAttendanceList[i].attendanceDate!.month,
                  adminStudentAttendanceList[i].attendanceDate!.day,
                ),
                dot: GlobalVariable.getAttendanceStatus(
                    adminStudentAttendanceList[i].attendanceType ?? "l"),
              ),
            ];
          }
        }
      }
    } catch (e, t) {
      isLoading.value = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      isLoading.value = false;
    }
    return AdminStudentSearchAttenResponseModel();
  }

  void setEventData() {
    if (adminStudentAttendanceList.isNotEmpty) {
      customEventList[DateTime(
          adminStudentAttendanceList[0].attendanceDate!.year,
          adminStudentAttendanceList[0].attendanceDate!.month,
          adminStudentAttendanceList[0].attendanceDate!.day)] = [
        Event(
          date: DateTime(
              adminStudentAttendanceList[0].attendanceDate!.year,
              adminStudentAttendanceList[0].attendanceDate!.month,
              adminStudentAttendanceList[0].attendanceDate!.day),
          dot: GlobalVariable.getAttendanceStatus(
              adminStudentAttendanceList[0].attendanceType ?? ""),
        )
      ];
    }

    eventList = EventList<Event>(events: customEventList);

    update();
  }

  @override
  void onInit() {
    studentAttendanceId.value = Get.arguments['student_attendance_id'];

    getAdminStudentSearchAttendanceDetailsList(
            studentAttendanceId: studentAttendanceId.value)
        .then((value) => setEventData());

    super.onInit();
  }
}
