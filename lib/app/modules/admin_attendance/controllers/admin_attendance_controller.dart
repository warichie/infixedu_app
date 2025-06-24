import 'package:infixedu/app/data/constants/image_path.dart';
import 'package:infixedu/app/data/module_data/home_data/home_dummy_data.dart';
import 'package:infixedu/config/global_variable/global_variable_controller.dart';
import 'package:get/get.dart';

class AdminAttendanceController extends GetxController {
  GlobalRxVariableController globalRxVariableController = Get.find();

  final selectIndex = RxInt(-1);

  List<HomeTileModelClass> adminAttendanceTileList = [
    HomeTileModelClass(
        icon: ImagePath.adminClassAttendance,
        title: 'Class Atten',
        value: 'Class Attendance Search'),
    HomeTileModelClass(
        icon: ImagePath.adminClassAttendance,
        title: 'Subject Atten',
        value: 'Subject Attendance Search'),
    HomeTileModelClass(
        icon: ImagePath.adminClassAttendance,
        title: 'Search Class Atten',
        value: 'Class Attendance Search Individual'),
    HomeTileModelClass(
        icon: ImagePath.adminClassAttendance,
        title: 'Search Sub Atten',
        value: 'Subject Attendance Search Individual'),
  ];
}
