import 'package:get/get.dart';

import '../controllers/other_downloads_controller.dart';

class OtherDownloadsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<OtherDownloadsController>(
      OtherDownloadsController(),
    );
  }
}
