import 'package:get/get.dart';

import '../../../data/constants/image_path.dart';
import '../../../data/module_data/home_data/home_dummy_data.dart';

class StudyMaterialsController extends GetxController {

  final selectIndex = RxInt(-1);

  List<HomeTileModelClass> studyMaterialTileList = [

    HomeTileModelClass(icon: ImagePath.studyMaterialAssignment, title: 'Assignment', value: 'Assignment'),
    HomeTileModelClass(icon: ImagePath.studyMaterialSyllabus, title: 'Syllabus', value: 'Syllabus'),
    HomeTileModelClass(icon: ImagePath.studyMaterialOtherDownload, title: 'Other Downloads', value: 'Other Downloads'),
  ];

}
