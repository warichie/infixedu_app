// import 'package:flutter_paystack/flutter_paystack.dart';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_paystack_max/flutter_paystack_max.dart';
import 'package:infixedu/app/utilities/message/snack_bars.dart';
import 'package:infixedu/config/app_config.dart';
import 'package:infixedu/config/global_variable/global_variable_controller.dart';
import 'package:infixedu/config/global_variable/payment/payment_handler.dart';
import 'package:get/get.dart';

class PayStackController extends GetxController {
  PaymentHandlerController paymentHandlerController =
      Get.put(PaymentHandlerController());
  RxBool initializingPayment = false.obs;

  // final plugin = PaystackPlugin();
  //
  // Future<void> makePayment({
  //   required String amount,
  //   required String currency,
  //   required String type,
  //   required int paymentMethod,
  //   int? invoiceId,
  //   required String from,
  // }) async {
  //   final finalAmount = (double.parse(amount) * 100).toInt();
  //   Charge charge = Charge()
  //     ..amount = finalAmount
  //     ..currency = AppConfig.payStackCurrency
  //     ..reference = '${DateTime.now().microsecondsSinceEpoch}'
  //     ..email = Get.find<GlobalRxVariableController>().email.value;
  //
  //   CheckoutResponse response = await plugin.checkout(
  //     Get.context!,
  //     method: CheckoutMethod.card,
  //     charge: charge,
  //   );
  //
  //   if (response.status == true) {
  //     paymentHandlerController.paymentSuccessHandler(
  //       type: 'feesInvoice',
  //       amount: double.tryParse(amount)!,
  //       paymentMethod: paymentMethod,
  //       invoiceId: invoiceId,
  //       from: from,
  //     );
  //   } else {
  //     showBasicFailedSnackBar(
  //       message: response.message.toString(),
  //     );
  //   }
  // }

  void makePayment(
      {required String amount,
      required String currency,
      required String type,
      required int paymentMethod,
      int? invoiceId,
      required String from,
      VoidCallback? onPaymentSuccess}) async {
    final finalAmount = (double.parse(amount) * 100).toInt().toDouble();

    final request = PaystackTransactionRequest(
      reference: 'ps_${DateTime.now().microsecondsSinceEpoch}',
      secretKey: AppConfig.payStackSecretKey,
      email:
          Get.find<GlobalRxVariableController>().email.value ?? 'test@mail.com',
      amount: finalAmount,
      currency: PaystackCurrency.zar,
      channel: [
        PaystackPaymentChannel.mobileMoney,
        PaystackPaymentChannel.card,
        PaystackPaymentChannel.ussd,
        PaystackPaymentChannel.bankTransfer,
        PaystackPaymentChannel.bank,
        PaystackPaymentChannel.qr,
        PaystackPaymentChannel.eft,
      ],
    );

    initializingPayment.value = true;
    final initializedTransaction =
        await PaymentService.initializeTransaction(request);

    // if (!mounted) return;
    initializingPayment.value = false;

    if (!initializedTransaction.status) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        content: Text(initializedTransaction.message),
      ));

      return;
    }

    await PaymentService.showPaymentModal(
      Get.context!,
      transaction: initializedTransaction,
      // Callback URL must match the one specified on your paystack dashboard,
      callbackUrl:
          '${AppConfig.domainName}/payment_gateway_success_callback/Paystack',
    );

    final response = await PaymentService.verifyTransaction(
      paystackSecretKey: AppConfig.payStackSecretKey,
      initializedTransaction.data?.reference ?? request.reference,
    );

    // if (kDebugMode) Logger().i(response.toMap());
    log("paystack payment result : ${response.toString()}");

    if (response.data.status == PaystackTransactionStatus.success) {
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
    } else {
      showBasicFailedSnackBar(
        message: response.data.status.toString(),
      );
    }
  }

  @override
  void onInit() {
    // plugin.initialize(publicKey: AppConfig.payStackPublicKey);
    super.onInit();
  }
}
