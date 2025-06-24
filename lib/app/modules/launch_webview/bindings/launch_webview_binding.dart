import 'package:get/get.dart';

import '../controllers/launch_webview_controller.dart';

class LaunchWebviewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LaunchWebviewController>(
      () => LaunchWebviewController(),
    );
  }
}
