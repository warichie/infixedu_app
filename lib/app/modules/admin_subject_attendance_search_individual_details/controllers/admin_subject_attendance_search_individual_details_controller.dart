import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:infixedu/app/modules/student_search_attendance/views/widget/display_dot.dart';
import 'package:infixedu/app/utilities/api_urls.dart';
import 'package:infixedu/config/global_variable/global_variable_controller.dart';
import 'package:infixedu/domain/base_client/base_client.dart';
import 'package:infixedu/domain/core/model/admin/admin_attendance_model/admin_atten_sub_search_individual_details_response_model.dart';
import 'package:get/get.dart';

class AdminSubjectAttendanceSearchIndividualDetailsController
    extends GetxController {
  GlobalRxVariableController globalRxVariableController = Get.find();

  final selectIndex = RxInt(0);
  DateTime currentDate = DateTime.now();
  Map<DateTime, List<Event>> customEventList = {};
  EventList<Event>? eventList;

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

  RxString classSection = ''.obs;

  RxInt recordId = 0.obs;
  RxInt subjectNameId = 0.obs;
  RxBool isLoading = false.obs;

  RxList<AdminAttendances> attendanceList = <AdminAttendances>[].obs;

  Future<AdminAttenSubSearchIndividualDetailsResponseModel>
      getAdminAttendanceSubDetailsList({
    required int recordId,
    required int subjectNameId,
    required int month,
    required int year,
  }) async {
    try {
      attendanceList.clear();
      eventList?.clear();
      isLoading.value = true;

      final response = await BaseClient().getData(
        url: globalRxVariableController.roleId.value == 1
            ? InfixApi.getAdminSubAttenSearchDetailsList(
                recordId: recordId,
                subjectNameId: subjectNameId,
              )
            : InfixApi.getTeacherSubAttenSearchDetailsList(
                recordId: recordId,
                subjectNameId: subjectNameId,
              ),
        header: GlobalVariable.header,
      );

      AdminAttenSubSearchIndividualDetailsResponseModel
          adminAttenSubSearchIndividualDetailsResponseModel =
          AdminAttenSubSearchIndividualDetailsResponseModel.fromJson(response);
      if (adminAttenSubSearchIndividualDetailsResponseModel.success == true) {
        isLoading.value = false;

        classSection.value =
            '${adminAttenSubSearchIndividualDetailsResponseModel.data!.className} (${adminAttenSubSearchIndividualDetailsResponseModel.data!.sectionName})';
        present.value = adminAttenSubSearchIndividualDetailsResponseModel
                .data?.totalPresent ??
            0;
        halfDay.value = adminAttenSubSearchIndividualDetailsResponseModel
                .data?.totalHalfDay ??
            0;
        late.value =
            adminAttenSubSearchIndividualDetailsResponseModel.data?.totalLate ??
                0;
        absent.value = adminAttenSubSearchIndividualDetailsResponseModel
                .data?.totalAbsent ??
            0;
        holiday.value = adminAttenSubSearchIndividualDetailsResponseModel
                .data?.totalHolyDay ??
            0;

        currentDate = DateTime.tryParse(
                adminAttenSubSearchIndividualDetailsResponseModel
                    .data!.currentDay!) ??
            DateTime.now();
        if (adminAttenSubSearchIndividualDetailsResponseModel
            .data!.attendances!.isNotEmpty) {
          for (int i = 0;
              i <
                  adminAttenSubSearchIndividualDetailsResponseModel
                      .data!.attendances!.length;
              i++) {
            attendanceList.add(adminAttenSubSearchIndividualDetailsResponseModel
                .data!.attendances![i]);
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
                    attendanceList[i].attendanceType ?? ""),
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
    return AdminAttenSubSearchIndividualDetailsResponseModel();
  }

  Future<AdminAttenSubSearchIndividualDetailsResponseModel?>
      getAdminAttendanceSubDetailsListWithDate({
    required int recordId,
    required int subjectNameId,
    required int month,
    required int year,
  }) async {
    try {
      isLoading.value = true;
      attendanceList.clear();
      eventList?.clear();
      final response = await BaseClient().getData(
        url: globalRxVariableController.roleId.value == 1
            ? InfixApi.getAdminSubAttenSearchDetailsWithDateList(
                recordId: recordId,
                subjectNameId: subjectNameId,
                month: month,
                year: year)
            : InfixApi.getTeacherSubAttenSearchDetailsWithDateList(
                recordId: recordId,
                subjectNameId: subjectNameId,
                month: month,
                year: year),
        header: GlobalVariable.header,
      );

      AdminAttenSubSearchIndividualDetailsResponseModel
          attenSubSearchIndividualDetailsResponseModel =
          AdminAttenSubSearchIndividualDetailsResponseModel.fromJson(response);
      if (attenSubSearchIndividualDetailsResponseModel.success == true) {
        isLoading.value = false;

        present.value =
            attenSubSearchIndividualDetailsResponseModel.data?.totalPresent ??
                0;
        halfDay.value =
            attenSubSearchIndividualDetailsResponseModel.data?.totalHalfDay ??
                0;
        late.value =
            attenSubSearchIndividualDetailsResponseModel.data?.totalLate ?? 0;
        absent.value =
            attenSubSearchIndividualDetailsResponseModel.data?.totalAbsent ?? 0;
        holiday.value =
            attenSubSearchIndividualDetailsResponseModel.data?.totalHolyDay ??
                0;

        currentDate = DateTime.tryParse(
                attenSubSearchIndividualDetailsResponseModel
                    .data!.currentDay!) ??
            DateTime.now();
        if (attenSubSearchIndividualDetailsResponseModel
            .data!.attendances!.isNotEmpty) {
          for (int i = 0;
              i <
                  attenSubSearchIndividualDetailsResponseModel
                      .data!.attendances!.length;
              i++) {
            attendanceList.add(attenSubSearchIndividualDetailsResponseModel
                .data!.attendances![i]);
            customEventList[DateTime(
                attendanceList[i].attendanceDate!.year,
                attendanceList[i].attendanceDate!.month,
                attendanceList[i].attendanceDate!.day)] = [
              Event(
                date: DateTime(
                  attendanceList[i].attendanceDate!.year,
                  attendanceList[i].attendanceDate!.month,
                  attendanceList[i].attendanceDate!.day,
                ),
                dot: GlobalVariable.getAttendanceStatus(
                    attendanceList[i].attendanceType ?? ""),
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
    return AdminAttenSubSearchIndividualDetailsResponseModel();
  }

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
          dot: presentEvent,
        )
      ];
    }

    eventList = EventList<Event>(events: customEventList);

    update();
  }

  @override
  void onInit() async {
    recordId.value = Get.arguments['record_id'];
    subjectNameId.value = Get.arguments['subject_name_id'];

    await getAdminAttendanceSubDetailsList(
            recordId: recordId.value,
            subjectNameId: subjectNameId.value,
            month: DateTime.now().month,
            year: DateTime.now().year)
        .then((value) => setEventData());

    super.onInit();
  }
}
