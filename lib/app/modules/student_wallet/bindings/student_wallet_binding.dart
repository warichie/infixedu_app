import 'package:get/get.dart';

import '../controllers/student_wallet_controller.dart';

class StudentWalletBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StudentWalletController>(
      () => StudentWalletController(),
    );
  }
}
