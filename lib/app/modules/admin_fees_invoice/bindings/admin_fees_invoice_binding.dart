import 'package:get/get.dart';

import '../controllers/admin_fees_invoice_controller.dart';

class AdminFeesInvoiceBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AdminFeesInvoiceController>(
      AdminFeesInvoiceController(),
    );
  }
}
