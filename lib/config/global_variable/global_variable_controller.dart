import 'package:flutter/material.dart';
import 'package:infixedu/app/modules/student_search_attendance/views/widget/display_dot.dart';
import 'package:get/get.dart';

import '../../app/data/module_data/home_data/home_dummy_data.dart';

class GlobalVariable {
  static List<HomeTileModelClass> homeTileList = [];

  static const halfDayEvent = DisplayDot(color: Color(0xFF5057FC));
  static const presentEvent = DisplayDot(color: Color(0xFF00C106));
  static const lateEvent = DisplayDot(color: Color(0xFFFF6F00));
  static const absentEvent = DisplayDot(color: Color(0xFFF32E21));
  static const holidayEvent = DisplayDot(color: Color(0xFF462564));
  static const nullEvent = DisplayDot(color: Colors.transparent);

  static Map<String, String> header = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': Get.find<GlobalRxVariableController>().token.value!,
  };

  static getAttendanceStatus(String attendanceStatus) {
    if (attendanceStatus == "P") {
      return presentEvent;
    } else if (attendanceStatus == "A") {
      return absentEvent;
    } else if (attendanceStatus == "F") {
      return halfDayEvent;
    } else if (attendanceStatus == "L") {
      return lateEvent;
    } else if (attendanceStatus == "H") {
      return holidayEvent;
    } else if (attendanceStatus == "") {
      return nullEvent;
    }
  }
}

class GlobalRxVariableController extends GetxController {
  final notificationCount = Rxn<int>();
  final studentRecordId = Rxn<int>();
  final roleId = Rxn<int>();
  final roleName = Rxn<String>('');
  final fullName = Rxn<String>('');
  final classId = Rxn<int>();
  final sectionId = Rxn<int>();
  final token = Rxn<String>();
  final email = Rxn<String>();
  final currencySymbol = Rxn<String>();
  final studentId = Rxn<int>();
  final parentId = Rxn<int>();
  final staffId = Rxn<int>();
  final userId = Rxn<int>();
  RxBool isStudent = false.obs;
  RxBool isRtl = false.obs;

  final pusherApiKey = Rxn<String>();
  final pusherClusterKey = Rxn<String>();
}
