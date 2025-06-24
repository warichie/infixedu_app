import 'package:get/get.dart';

import '../../../data/constants/image_path.dart';
import '../../../data/module_data/home_data/home_dummy_data.dart';

class OnlineExamController extends GetxController {

  final selectIndex = RxInt(-1);



  List<HomeTileModelClass> onlineExamTileList = [
    HomeTileModelClass(icon: ImagePath.onlineActiveExam, title: 'Active Exam', value: 'Active Exam'),
    HomeTileModelClass(icon: ImagePath.onlineExamResult, title: 'Exam Result', value: 'Exam Result'),
  ];

}
