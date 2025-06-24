import 'package:infixedu/app/data/constants/image_path.dart';
import 'package:infixedu/app/data/module_data/home_data/home_dummy_data.dart';
import 'package:get/get.dart';

class AdminContentController extends GetxController {
  final selectIndex = RxInt(-1);

  List<HomeTileModelClass> contentTileList = [
    HomeTileModelClass(
      icon: ImagePath.add,
      title: 'Add Content',
      value: 'Add Content',
    ),
    HomeTileModelClass(
      icon: ImagePath.list,
      title: 'Content List',
      value: 'Content List',
    ),
  ];
}
