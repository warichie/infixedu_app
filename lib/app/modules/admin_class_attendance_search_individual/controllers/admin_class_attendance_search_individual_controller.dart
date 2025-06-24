import 'package:flutter/material.dart';
import 'package:infixedu/app/modules/admin_students_search/controllers/admin_students_search_controller.dart';
import 'package:infixedu/app/utilities/widgets/loader/loading.controller.dart';
import 'package:get/get.dart';

class AdminClassAttendanceSearchIndividualController extends GetxController {
  TextEditingController nameTextController = TextEditingController();
  TextEditingController rollTextController = TextEditingController();

  LoadingController loadingController = Get.find();
  AdminStudentsSearchController adminStudentsSearchController =
      Get.put(AdminStudentsSearchController());
}
