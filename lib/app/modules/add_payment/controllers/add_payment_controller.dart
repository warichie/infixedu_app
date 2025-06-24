import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infixedu/app/data/constants/app_colors.dart';
import 'package:infixedu/app/data/constants/app_text_style.dart';
import 'package:infixedu/app/modules/add_payment/views/widgets/text_field_with_tile.dart';
import 'package:infixedu/app/modules/fees/controllers/fees_controller.dart';
import 'package:infixedu/app/style/bottom_sheet/bottom_sheet_shpe.dart';
import 'package:infixedu/app/utilities/api_urls.dart';
import 'package:infixedu/app/utilities/extensions/widget.extensions.dart';
import 'package:infixedu/app/utilities/message/snack_bars.dart';
import 'package:infixedu/app/utilities/widgets/bottom_sheet_tile/bottom_sheet_tile.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_divider.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/primary_button.dart';
import 'package:infixedu/app/utilities/widgets/customised_loading_widget/customised_loading_widget.dart';
import 'package:infixedu/config/app_config.dart';
import 'package:infixedu/config/global_variable/global_variable_controller.dart';
import 'package:infixedu/config/global_variable/payment/pay_stack_controller.dart';
import 'package:infixedu/config/global_variable/payment/paypal_controller.dart';
import 'package:infixedu/config/global_variable/payment/stripe_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AddPaymentController extends GetxController {
  PayStackController payStackController = Get.put(PayStackController());
  PaypalController paypalController = Get.put(PaypalController());
  StripeController stripeController = Get.put(StripeController());

  TextEditingController paidTextController = TextEditingController();
  TextEditingController waiverTextController = TextEditingController();
  TextEditingController fineTextController = TextEditingController();
  TextEditingController noteTextController = TextEditingController();
  TextEditingController paymentNoteTextController = TextEditingController();

  Rxn<num> addInWallet = Rxn<num>(0);
  int? invoiceId;
  num totalPaidAmount = 0;
  RxBool paymentLoader = false.obs;

  RxList<num> feesTypeList = <num>[].obs;
  RxList<String> feesTypeNameList = <String>[].obs;
  RxList<num> amountList = <num>[].obs;
  RxList<num> dueList = <num>[].obs;
  RxList<num> extraAmountList = <num>[].obs;
  RxList<num> paidAmountList = <num>[].obs;
  RxList<String> noteList = <String>[].obs;

  FeesController feesController = Get.find();

  num getTotalPaidAmount() {
    num calculatedTotalPaidAmount = 0;
    for (var paidAmount in paidAmountList) {
      calculatedTotalPaidAmount += paidAmount;
    }

    var total = calculatedTotalPaidAmount;
    return total;
  }

  void _selectedPaymentGateway(value, index) {
    switch (value) {
      case 'Cash':
        _makeBankPayment();
        break;
      case 'Cheque':
        _makeBankPayment();
        break;
      case 'Bank':
        _makeBankPayment();
        break;
      case 'PayPal':
        Get.back();

        feesController.paypalController.makePayment(
          amount: jsonEncode(getTotalPaidAmount()),
          currency: AppConfig.stripeCurrency,
          type: 'feesInvoice',
          paymentMethod: feesController.paymentMethodId.value,
          invoiceId: invoiceId,
          from: 'feesInvoice',
          onPaymentSuccess: () {
            _makeAutoPayment();
          },
        );
        break;
      case 'Stripe':
        // stripeController.makePayment(feesInvoiceList[index].amount.toString(), AppConfig.stripeCurrency);
        stripeController.makePayment(
          amount: jsonEncode(getTotalPaidAmount()),
          currency: AppConfig.stripeCurrency,
          type: 'feesInvoice',
          paymentMethod: feesController.paymentMethodId.value,
          invoiceId: invoiceId,
          from: 'feesInvoice',
          onPaymentSuccess: () {
            _makeAutoPayment();
          },
        );
        Get.back();
        break;

      case 'Paystack':
        payStackController.makePayment(
          amount: jsonEncode(getTotalPaidAmount()),
          currency: AppConfig.stripeCurrency,
          type: 'feesInvoice',
          paymentMethod: feesController.paymentMethodId.value,
          invoiceId: invoiceId,
          from: 'feesInvoice',
          onPaymentSuccess: () {
            _makeAutoPayment();
          },
        );
        Get.back();
        break;
      case 'Xendit':
        break;

      case 'Khalti':
        break;
    }
  }

  void _clearData() {
    feesTypeList.clear();
    amountList.clear();
    dueList.clear();
    extraAmountList.clear();
    paidAmountList.clear();
    feesTypeNameList.clear();
    noteList.clear();
    feesController.studentWalletController.file.value = File('');
    noteTextController.clear();
    totalPaidAmount = 0;
  }

  Future<void> _makeAutoPayment() async {
    try {
      paymentLoader.value = true;
      var headers = GlobalVariable.header;
      var request = http.MultipartRequest(
          'POST', Uri.parse(InfixApi.studentFeesAddPaymentStore));

      request.fields.addAll({
        'payment_method': feesController.paymentMethodName.value,
        'payment_note': paymentNoteTextController.text,
        'invoice_id': invoiceId.toString(),
        'student_id':
            feesController.paymentFeesInvoiceInfo!.studentId.toString(),
        'weaver': waiverTextController.text,
        'total_paid_amount': getTotalPaidAmount().toStringAsFixed(1),
      });

      // Add array fields without jsonEncode, using a loop
      for (int i = 0; i < feesTypeList.length; i++) {
        request.fields['fees_type[$i]'] = feesTypeList[i].toString();
        request.fields['amount[$i]'] = amountList[i].toString();
        request.fields['due[$i]'] = dueList[i].toString();
        request.fields['extraAmount[$i]'] = extraAmountList[i].toString();
        request.fields['paid_amount[$i]'] = paidAmountList[i].toString();
        request.fields['note[$i]'] = noteList[i].toString();
      }

      // Add headers
      request.headers.addAll(headers);

      // Send the request and handle the response
      http.StreamedResponse response = await request.send();
      final responseBody = await response.stream.bytesToString();
      final decodedResponse = json.decode(responseBody);
      debugPrint(decodedResponse.toString());

      if (response.statusCode == 200) {
        paymentLoader.value = false;
        _clearData();
        Get.back();
        showBasicSuccessSnackBar(message: decodedResponse['message']);
        GlobalRxVariableController globalRxVariableController = Get.find();

        feesController.getAllFeesList(
          studentId: globalRxVariableController.studentId.value!,
          recordId: globalRxVariableController.studentRecordId.value!,
        );
      } else {
        paymentLoader.value = false;
        showBasicFailedSnackBar(message: decodedResponse['message']);
      }
    } catch (e, t) {
      paymentLoader.value = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      paymentLoader.value = false;
    }
  }

  Future<void> _makeBankPayment() async {
    try {
      paymentLoader.value = true;
      var headers = GlobalVariable.header;
      var request = http.MultipartRequest(
          'POST', Uri.parse(InfixApi.studentFeesAddPaymentStore));

      // Add non-array fields
      request.fields.addAll({
        'wallet_balance':
            feesController.paymentFeesInvoiceInfo?.walletBalance.toString() ??
                '',
        'add_wallet': addInWallet.value.toString(),
        'payment_method': feesController.paymentMethodName.value,
        'bank': feesController.bankId.value.toString(),
        'payment_note': paymentNoteTextController.text,
        'invoice_id': invoiceId.toString(),
        'student_id':
            feesController.paymentFeesInvoiceInfo!.studentId.toString(),
        'weaver': waiverTextController.text,
        'total_paid_amount': getTotalPaidAmount().toStringAsFixed(1),
      });

      // Add array fields without jsonEncode, using a loop
      for (int i = 0; i < feesTypeList.length; i++) {
        request.fields['fees_type[$i]'] = feesTypeList[i].toString();
        request.fields['amount[$i]'] = amountList[i].toString();
        request.fields['due[$i]'] = dueList[i].toString();
        request.fields['extraAmount[$i]'] = extraAmountList[i].toString();
        request.fields['paid_amount[$i]'] = paidAmountList[i].toString();
        request.fields['note[$i]'] = noteList[i].toString();
      }

      // Add file if present
      if (feesController.studentWalletController.file.value.path.isNotEmpty) {
        request.files.add(await http.MultipartFile.fromPath(
            'file', feesController.studentWalletController.file.value.path));
      }

      // Add headers
      request.headers.addAll(headers);

      // Send the request and handle the response
      http.StreamedResponse response = await request.send();
      final responseBody = await response.stream.bytesToString();
      final decodedResponse = json.decode(responseBody);
      debugPrint(decodedResponse.toString());

      if (response.statusCode == 200) {
        paymentLoader.value = false;
        _clearData();
        Get.back();
        showBasicSuccessSnackBar(message: decodedResponse['message']);
        GlobalRxVariableController globalRxVariableController = Get.find();

        feesController.getAllFeesList(
          studentId: globalRxVariableController.studentId.value!,
          recordId: globalRxVariableController.studentRecordId.value!,
        );
      } else {
        paymentLoader.value = false;
        showBasicFailedSnackBar(message: decodedResponse['message']);
      }
    } catch (e, t) {
      paymentLoader.value = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      paymentLoader.value = false;
    }
  }

  void showAddPaymentBottomSheet({required int index}) {
    Get.bottomSheet(
      SizedBox(
        height: Get.height * 0.7,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            10.h.verticalSpacing,
            Padding(
              padding: EdgeInsets.all(17.0),
              child: Text(
                'Add Payment'.tr,
                style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Inter',
                    color: Color(0xFF635976)),
              ),
            ),
            BottomSheetTile(
              title: "Fees Type".tr,
              value: feesController.paymentInvoiceDetails[index].feesType?.name
                  .toString(),
              color: AppColors.homeworkWidgetColor,
              width: 141.w,
            ),
            BottomSheetTile(
              title: "Amount".tr,
              value:
                  feesController.paymentInvoiceDetails[index].amount.toString(),
              color: Colors.white,
              width: 141.w,
            ),
            BottomSheetTile(
              title: "Due".tr,
              value: feesController.paymentInvoiceDetails[index].dueAmount
                  .toString(),
              color: AppColors.homeworkWidgetColor,
              width: 141.w,
            ),
            CustomTextFieldWithTile(
              title: 'Pay Amount'.tr,
              controller: paidTextController,
              hintTex: '${"Pay Amount".tr}...',
              color: Colors.white,
              keyboardType: TextInputType.number,
            ),
            CustomTextFieldWithTile(
                title: 'Waiver'.tr,
                controller: waiverTextController,
                hintTex: '${"Waiver".tr}...',
                readOnly:
                    Get.find<GlobalRxVariableController>().roleId.value == 4
                        ? false
                        : true,
                color: AppColors.homeworkWidgetColor),
            CustomTextFieldWithTile(
              title: 'Fine'.tr,
              controller: fineTextController,
              hintTex: '${"Fine".tr}...',
              readOnly: Get.find<GlobalRxVariableController>().roleId.value == 4
                  ? false
                  : true,
              color: Colors.white,
            ),
            CustomTextFieldWithTile(
              title: 'Note'.tr,
              controller: noteTextController,
              hintTex: '${"Note".tr}...',
              color: AppColors.homeworkWidgetColor,
            ),
            const Spacer(),
            Center(
              child: PrimaryButton(
                onTap: () {
                  num extraAmount = 0;
                  int? paidAmount = int.tryParse(paidTextController.text);
                  if (paidAmount != null) {
                    num? dueAmount =
                        feesController.paymentInvoiceDetails[index].dueAmount;
                    extraAmount = (paidAmount - dueAmount!);
                    if (extraAmount > 0) {
                      addInWallet.value = addInWallet.value! + extraAmount;
                      extraAmountList
                          .add(num.tryParse(extraAmount.toString())!);
                      extraAmount = 0;
                    } else {
                      extraAmountList.add(0);
                    }
                  }

                  feesTypeList.add(feesController
                          .paymentInvoiceDetails[index].feesType?.id ??
                      0);
                  feesTypeNameList.add(feesController
                          .paymentInvoiceDetails[index].feesType?.name ??
                      '');
                  amountList.add(
                      feesController.paymentInvoiceDetails[index].amount ?? 0);
                  dueList.add(
                      feesController.paymentInvoiceDetails[index].dueAmount ??
                          0);
                  paidAmountList
                      .add(num.tryParse(paidTextController.text) ?? 0);
                  noteList.add(noteTextController.text);

                  paidTextController.clear();
                  noteTextController.clear();
                  Get.back();
                },
                width: 152.w,
                height: 28,
                text: 'Add Payment'.tr,
                borderRadius: 2.w,
                textStyle: AppTextStyle.fontSize13WhiteWight500,
              ),
            ),
            31.h.verticalSpacing,
          ],
        ),
      ),
      backgroundColor: Colors.white,
      shape: defaultBottomSheetShape(),
      isScrollControlled: true,
    );
  }

  void showInvoiceListBottomSheet({required int index}) {
    // Calculate total paid amount dynamically
    num calculatedTotalPaidAmount = 0;
    for (var paidAmount in paidAmountList) {
      calculatedTotalPaidAmount += paidAmount;
    }

    var total = calculatedTotalPaidAmount.toString();

    Get.bottomSheet(
      SizedBox(
        height: Get.height * 0.7,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            10.h.verticalSpacing,
            Padding(
              padding: const EdgeInsets.all(17.0),
              child: Text(
                'Payment Summery'.tr,
                style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Inter',
                    color: Color(0xFF635976)),
              ),
            ),
            paidAmountList.isNotEmpty
                ? ListView.builder(
                    shrinkWrap: true,
                    itemCount: feesTypeNameList.length,
                    itemBuilder: (context, index) => BottomSheetTile(
                      width: Get.width / 1.4,
                      title: feesTypeNameList[index],
                      value: paidAmountList[index].toString(),
                      color: index.isEven
                          ? AppColors.homeworkWidgetColor
                          : Colors.white,
                    ),
                  )
                : const SizedBox(),
            BottomSheetTile(
              title: 'Total'.tr,
              value: total,
              width: Get.width / 1.4,
              titleTextStyle: AppTextStyle.fontSize12GreyW600,
              valueTextStyle: AppTextStyle.fontSize12GreyW600,
            ),
            const CustomDivider(),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                PrimaryButton(
                  onTap: () {
                    paymentLoader.value ? null : Get.back();
                  },
                  text: 'Cancel'.tr,
                  color: const Color(0xFFF35D5D),
                  borderRadius: 2,
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  height: 26,
                ),
                10.horizontalSpacing,
                Obx(
                  () => paymentLoader.value
                      ? const SecondaryLoadingWidget()
                      : PrimaryButton(
                          onTap: () {
                            _selectedPaymentGateway(
                                feesController.paymentMethodName.value, 0);
                          },
                          text: 'Confirm Payment'.tr,
                          color: AppColors.primaryColor,
                          borderRadius: 2,
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          height: 26,
                        ),
                ),
              ],
            ),
            31.h.verticalSpacing,
          ],
        ),
      ),
      backgroundColor: Colors.white,
      shape: defaultBottomSheetShape(),
      isScrollControlled: true,
    );
  }

  @override
  void onInit() {
    invoiceId = Get.arguments['invoiceId'];
    super.onInit();
  }
}
