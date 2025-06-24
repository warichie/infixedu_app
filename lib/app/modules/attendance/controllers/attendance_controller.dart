
import 'package:get/get.dart';

import '../../../data/constants/image_path.dart';
import '../../../data/module_data/home_data/home_dummy_data.dart';

class AttendanceController extends GetxController {

  final selectIndex = RxInt(-1);

  List<HomeTileModelClass> attendanceTileList = [
    HomeTileModelClass(icon: ImagePath.studentAttendance, title: 'Search Atten', value: 'Search Attendance'),
    HomeTileModelClass(icon: ImagePath.studentAttendance, title: 'Search Sub Atten', value: 'Search Sub Attendance'),
  ];

}

