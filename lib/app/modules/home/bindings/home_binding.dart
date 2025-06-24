import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {

    // Get.put<HomeController>(
    //   HomeController(
    //     LoginController: Get.find(),
    //   ),
    // );

    Get.lazyPut<HomeController>(
      () => HomeController(
      ),
    );
  }
}
