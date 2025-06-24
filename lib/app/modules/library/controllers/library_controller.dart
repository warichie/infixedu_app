import 'package:get/get.dart';

import '../../../data/constants/image_path.dart';
import '../../../data/module_data/home_data/home_dummy_data.dart';

class LibraryController extends GetxController {

  final selectIndex = RxInt(-1);
  List<HomeTileModelClass> libraryTileList = [
    HomeTileModelClass(icon: ImagePath.applyLeave, title: 'Book List', value: 'Book List'),
    HomeTileModelClass(icon: ImagePath.list, title: 'Book Issued', value: 'Book Issued'),
  ];

}
