import 'package:infixedu/app/data/constants/image_path.dart';
import 'package:infixedu/app/data/module_data/home_data/home_dummy_data.dart';
import 'package:get/get.dart';

class AdminDormitoryController extends GetxController {
  final selectIndex = RxInt(-1);

  List<HomeTileModelClass> dormitoryTileList = [
    HomeTileModelClass(
        icon: ImagePath.add, title: 'Add Dormitory', value: 'Add Dormitory'),
    HomeTileModelClass(
        icon: ImagePath.add, title: 'Add Room', value: 'Add Room'),
    HomeTileModelClass(
        icon: ImagePath.studentDormitory,
        title: 'Room List',
        value: 'Room List'),
  ];
}
