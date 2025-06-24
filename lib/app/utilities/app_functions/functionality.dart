import 'package:flutter/material.dart';
import 'package:infixedu/config/global_variable/global_variable_controller.dart';
import 'package:get/get.dart';
import '../../data/module_data/home_data/home_dummy_data.dart';
import '../../routes/app_pages.dart';

class AppFunctions {
  void getFunctions(int role) {
    switch (role) {
      case 1:
        GlobalVariable.homeTileList = adminList;
        Get.offAndToNamed(Routes.HOME, arguments: {
          'homeListTile': GlobalVariable.homeTileList,
        });
        break;
      case 2:
        GlobalVariable.homeTileList = studentList;
        Get.offAndToNamed(Routes.DASHBOARD, arguments: {
          'homeListTile': GlobalVariable.homeTileList,
        });
        break;
      case 3:
        GlobalVariable.homeTileList = parentList;
        Get.offAndToNamed(Routes.HOME, arguments: {
          'homeListTile': GlobalVariable.homeTileList,
        });
        break;
      case 4:
        GlobalVariable.homeTileList = teacherList;
        Get.offAndToNamed(Routes.DASHBOARD, arguments: {
          'homeListTile': GlobalVariable.homeTileList,
        });
        break;
      case 5:
        GlobalVariable.homeTileList = adminList;
        Get.offAndToNamed(Routes.HOME, arguments: {
          'homeListTile': GlobalVariable.homeTileList,
        });
        break;
      case 9:
        GlobalVariable.homeTileList = adminList;
        Get.offAndToNamed(Routes.HOME, arguments: {
          'homeListTile': GlobalVariable.homeTileList,
        });
        break;
    }
  }

  /// Student List Tile Navigation
  static void getStudentDashboardNavigation({required String title}) {
    debugPrint(title);
    switch (title) {
      case 'Wallet':
        Get.toNamed(Routes.STUDENT_WALLET);
        break;
      case 'Homework':
        Get.toNamed(Routes.STUDENT_HOMEWORK);
        break;
      case 'Study Materials':
        Get.toNamed(Routes.STUDY_MATERIALS);
        break;
      case 'Leave':
        Get.toNamed(Routes.LEAVE);
        break;
      case 'Dormitory':
        Get.toNamed(Routes.DORMITORY);
        break;
      case 'Transport':
        Get.toNamed(Routes.TRANSPORT);
        break;
      case 'Subjects':
        Get.toNamed(Routes.SUBJECTS);
        break;
      case 'Teacher':
        Get.toNamed(Routes.TEACHER);
        break;
      case 'Library':
        Get.toNamed(Routes.LIBRARY);
        break;
      case 'Notice':
        Get.toNamed(Routes.NOTICE);
        break;
      case 'Examination':
        Get.toNamed(Routes.EXAMINATION);
        break;
      case 'Online Exam':
        Get.toNamed(Routes.ONLINE_EXAM);
        break;
      case 'Attendance':
        Get.toNamed(Routes.ATTENDANCE);
        break;
      case 'Settings':
        Get.toNamed(Routes.SETTINGS);
        break;
      case 'Lesson':
        Get.toNamed(Routes.STUDENT_LESSON_PLAN);
        break;
      case 'Class':
        Get.toNamed(Routes.STUDENT_CLASS);
        break;
      case 'Assignment':
        Get.toNamed(Routes.ASSIGNMENT);
        break;
      case 'Syllabus':
        Get.toNamed(Routes.SYLLABUS);
        break;
      case 'Schedule':
        Get.toNamed(Routes.SCHEDULE);
        break;
      case 'Result':
        Get.toNamed(Routes.RESULT);
        break;
      case 'Active Exam':
        Get.toNamed(Routes.ACTIVE_EXAM);
        break;
      case 'Exam Result':
        Get.toNamed(Routes.EXAM_RESULT);
        break;
      case 'Other Downloads':
        Get.toNamed(Routes.OTHER_DOWNLOADS);
        break;
      case 'Apply Leave':
        Get.toNamed(Routes.APPLY_LEAVE);
        break;
      case 'Leave List':
        Get.toNamed(Routes.LEAVE_LIST);
        break;
      case 'Book List':
        Get.toNamed(Routes.BOOK_LIST);
        break;
      case 'Book Issued':
        Get.toNamed(Routes.BOOK_ISSUED);
        break;
      case 'Search Attendance':
        Get.toNamed(Routes.STUDENT_SEARCH_ATTENDANCE,
            arguments: {"from": false});
        break;
      case 'Search Sub Attendance':
        Get.toNamed(Routes.STUDENT_SEARCH_SUBJECT_ATTENDANCE);
        break;
    }
  }

  static void getAdminHomeNavigation({required String title}) {
    debugPrint(title);
    switch (title) {
      case 'Students':
        Get.toNamed(Routes.ADMIN_STUDENTS_SEARCH);
        break;
      case 'Staff':
        Get.toNamed(Routes.STAFF);
        break;
      case 'Leave':
        Get.toNamed(Routes.ADMIN_LEAVE);
        break;
      case 'Dormitory':
        Get.toNamed(Routes.ADMIN_DORMITORY);
        break;
      case 'Add Dormitory':
        Get.toNamed(Routes.ADMIN_ADD_DORMITORY);
        break;
      case 'Add Room':
        Get.toNamed(Routes.ADMIN_ADD_ROOM);
        break;
      case 'Room List':
        Get.toNamed(Routes.ADMIN_ROOM_LIST);
        break;
      case 'Fees':
        Get.toNamed(Routes.ADMIN_FEES);
        break;
      case 'Fees Group':
        Get.toNamed(Routes.ADMIN_FEES_GROUP);
        break;
      case 'Fees Type':
        Get.toNamed(Routes.ADMIN_FEES_TYPE);
        break;
      case 'Fees Invoice List':
        Get.toNamed(Routes.ADMIN_FEES_INVOICE_LIST);
        break;
      case 'Attendance':
        Get.toNamed(Routes.ADMIN_ATTENDANCE);
        break;
      case 'Class Attendance Search':
        Get.toNamed(Routes.ADMIN_CLASS_ATTENDANCE_SEARCH);
        break;
      case 'Subject Attendance Search':
        Get.toNamed(Routes.ADMIN_SUBJECT_ATTENDANCE_SEARCH);
        break;
      case 'Class Attendance Search Individual':
        Get.toNamed(Routes.ADMIN_CLASS_ATTENDANCE_SEARCH_INDIVIDUAL);
        break;
      case 'Subject Attendance Search Individual':
        Get.toNamed(Routes.ADMIN_SUBJECT_ATTENDANCE_SEARCH_INDIVIDUAL);
        break;
      case 'Content':
        Get.toNamed(Routes.ADMIN_CONTENT);
        break;
      case 'Add Content':
        Get.toNamed(Routes.ADMIN_ADD_CONTENT);
        break;
      case 'Content List':
        Get.toNamed(Routes.ADMIN_CONTENT_LIST);
        break;
      case 'Notice':
        Get.toNamed(Routes.ADMIN_NOTICE);
        break;
      case 'Library':
        Get.toNamed(Routes.ADMIN_LIBRARY);
        break;
      case 'Add Book':
        Get.toNamed(Routes.ADMIN_ADD_BOOK);
        break;
      case 'Book List':
        Get.toNamed(Routes.ADMIN_BOOK_LIST);
        break;
      case 'Add Member':
        Get.toNamed(Routes.ADMIN_ADD_MEMBER);
        break;
      case 'Transport':
        Get.toNamed(Routes.ADMIN_TRANSPORT);
        break;
      case 'Route':
        Get.toNamed(Routes.ADMIN_ROUTE);
        break;
      case 'Vehicle':
        Get.toNamed(Routes.ADMIN_VEHICLE);
        break;
      case 'Assign Vehicle':
        Get.toNamed(Routes.ADMIN_ASSIGN_VEHICLE);
        break;
      case 'Transport Details':
        Get.toNamed(Routes.ADMIN_TRANSPORT_DETAILS);
        break;
      case 'Settings':
        Get.toNamed(Routes.SETTINGS);
        break;
      case 'Class':
        Get.toNamed(Routes.STUDENT_CLASS);
        break;
      case 'Bank Payment':
        Get.toNamed(Routes.BANK_PAYMENT_LIST);
        break;
    }
  }

  static void getParentHomeNavigation({required String title}) {
    debugPrint(title);
    switch (title) {
      case 'Child':
        Get.toNamed(Routes.PARENT_CHILD);
        break;
      case 'About':
        Get.toNamed(Routes.ABOUT);
        break;
      case 'Settings':
        Get.toNamed(Routes.SETTINGS);
        break;
    }
  }

  static void getTeacherHomeNavigation({required String title}) {
    debugPrint(title);
    switch (title) {
      case 'HomeWork':
        Get.toNamed(Routes.TE_HOMEWORK);
        break;
      case 'Add Homework':
        Get.toNamed(Routes.TE_ADD_HOMEWORK);
        break;
      case 'Homework List':
        Get.toNamed(Routes.TE_HOMEWORK_LIST);
        break;
      case 'Library':
        Get.toNamed(Routes.ADMIN_BOOK_LIST);
        break;
      case 'Notice':
        Get.toNamed(Routes.ADMIN_NOTICE);
        break;
      case 'Content':
        Get.toNamed(Routes.ADMIN_CONTENT);
        break;
      case 'Add Content':
        Get.toNamed(Routes.ADMIN_ADD_CONTENT);
        break;
      case 'Content List':
        Get.toNamed(Routes.ADMIN_CONTENT_LIST);
        break;
      case 'Leave':
        Get.toNamed(Routes.TE_LEAVE);
        break;
      case 'Apply Leave':
        Get.toNamed(Routes.TE_APPLY_LEAVE);
        break;
      case 'Leave List':
        Get.toNamed(Routes.LEAVE_LIST);
        break;
      case 'Attendance':
        Get.toNamed(Routes.TE_ATTENDANCE);
        break;
      case 'My Routine':
        Get.toNamed(Routes.ROUTINE);
        break;
      case 'Class Routine':
        Get.toNamed(Routes.TE_SEARCH_CLASS_ROUTINE);
        break;
      case 'Subjects':
        Get.toNamed(Routes.TE_SUBJECTS);
        break;
      case 'Class Routine List':
        Get.toNamed(Routes.TE_SEARCH_CLASS_ROUTINE_LIST);
        break;
      case 'Students':
        Get.toNamed(Routes.ADMIN_STUDENTS_SEARCH);
        break;
      case 'Settings':
        Get.toNamed(Routes.SETTINGS);
        break;
      case 'About':
        Get.toNamed(Routes.ABOUT);
        break;
      case 'Class':
        Get.toNamed(Routes.STUDENT_CLASS);
        break;
    }
  }

  static void routingDecisionForRoleId(
      {required int roleId, required String title}) {
    switch (roleId) {
      case 1:
        getAdminHomeNavigation(title: title);
        break;
      case 2:
        getStudentDashboardNavigation(title: title);
        break;
      case 3:
        getParentHomeNavigation(title: title);
        break;
      case 4:
        getTeacherHomeNavigation(title: title);
        break;
      case 5:
        getAdminHomeNavigation(title: title);
        break;
    }
  }
}
