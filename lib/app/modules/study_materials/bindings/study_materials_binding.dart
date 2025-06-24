import 'package:get/get.dart';

import '../controllers/study_materials_controller.dart';

class StudyMaterialsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StudyMaterialsController>(
      () => StudyMaterialsController(),
    );
  }
}
