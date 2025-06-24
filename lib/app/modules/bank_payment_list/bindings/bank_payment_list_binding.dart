import 'package:get/get.dart';

import '../controllers/bank_payment_list_controller.dart';

class BankPaymentListBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<BankPaymentListController>(
         BankPaymentListController(),
    );

  }
}
