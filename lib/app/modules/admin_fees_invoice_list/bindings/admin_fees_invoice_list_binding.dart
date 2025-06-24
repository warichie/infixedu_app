import 'package:get/get.dart';

import '../controllers/admin_fees_invoice_list_controller.dart';

class AdminFeesInvoiceListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminFeesInvoiceListController>(
      () => AdminFeesInvoiceListController(),
    );
  }
}
