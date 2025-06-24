import 'package:flutter/cupertino.dart';
import 'package:flutter_paypal_checkout/flutter_paypal_checkout.dart';
import 'package:infixedu/config/app_config.dart';
import 'package:infixedu/config/global_variable/payment/payment_handler.dart';
import 'package:get/get.dart';

class PaypalController extends GetxController {
  PaymentHandlerController paymentHandlerController =
      Get.put(PaymentHandlerController());

  void makePayment(
      {required String amount,
      required String currency,
      required String type,
      required int paymentMethod,
      int? invoiceId,
      required String from,
      VoidCallback? onPaymentSuccess}) async {
    Get.to(() => PaypalCheckout(
          sandboxMode: AppConfig.sandboxMood,
          clientId: AppConfig.paypalClientId,
          secretKey: AppConfig.paypalClientSecret,
          returnURL: "success.snippetcoder.com",
          cancelURL: "cancel.snippetcoder.com",
          transactions: [
            {
              "amount": {
                "total": amount,
                "currency": AppConfig.stripeCurrency,
                "details": {
                  "subtotal": amount,
                  "shipping": '0',
                  "shipping_discount": 0
                }
              },
              "description": "The payment transaction description.",
            }
          ],
          note: "Contact us for any questions on your order.",
          onSuccess: (Map params) async {
            if (invoiceId == null) {
              paymentHandlerController.paymentSuccessHandler(
                type: type,
                amount: double.tryParse(amount)!,
                paymentMethod: paymentMethod,
                invoiceId: invoiceId,
                from: from,
              );
            } else {
              onPaymentSuccess!();
            }

            debugPrint("onSuccess: $params");
          },
          onError: (error) {
            debugPrint("onError: $error");
            Get.back();
          },
          onCancel: () {
            debugPrint('cancelled:');
          },
        ));
  }
}
