import 'package:infixedu/app/modules/fees/controllers/fees_controller.dart';
import 'package:get/get.dart';

class AdminFeesInvoiceController extends GetxController {
  FeesController feesController = Get.put(FeesController());

  RxInt invoiceId = 0.obs;

  @override
  void onInit() {
    invoiceId.value = Get.arguments["invoice_id"];
    feesController.getFeesInvoice(invoiceId: invoiceId.value);
    super.onInit();
  }
}
