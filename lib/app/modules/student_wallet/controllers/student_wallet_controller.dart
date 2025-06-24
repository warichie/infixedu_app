import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:infixedu/app/data/constants/app_text_style.dart';
import 'package:infixedu/app/style/bottom_sheet/bottom_sheet_shpe.dart';
import 'package:infixedu/app/utilities/api_urls.dart';
import 'package:infixedu/app/utilities/extensions/widget.extensions.dart';
import 'package:infixedu/app/utilities/message/snack_bars.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_browse_icon.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/duplicate_dropdown.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/primary_button.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/text_field.dart';
import 'package:infixedu/app/utilities/widgets/customised_loading_widget/customised_loading_widget.dart';
import 'package:infixedu/config/app_config.dart';
import 'package:infixedu/config/global_variable/global_variable_controller.dart';
import 'package:infixedu/config/global_variable/payment/pay_stack_controller.dart';
import 'package:infixedu/config/global_variable/payment/paypal_controller.dart';
import 'package:infixedu/config/global_variable/payment/stripe_controller.dart';
import 'package:infixedu/domain/base_client/base_client.dart';
import 'package:infixedu/domain/core/model/student/wallet/bank_list/bank_list.dart';
import 'package:infixedu/domain/core/model/student/wallet/my_wallet/my_wallet.dart';
import 'package:infixedu/domain/core/model/student/wallet/payment_method_list/payment_method_list_response_model.dart';
import 'package:get/get.dart';

class StudentWalletController extends GetxController {
  PayStackController payStackController = Get.put(PayStackController());
  PaypalController paypalController = Get.put(PaypalController());
  StripeController stripeController = Get.put(StripeController());

  RxBool paymentMethodLoader = false.obs;
  RxBool bankListLoader = false.obs;
  RxBool isLoading = false.obs;
  RxBool paymentLoader = false.obs;

  TextEditingController amountTextController = TextEditingController();
  TextEditingController noteTextController = TextEditingController();
  TextEditingController browseFileTextController = TextEditingController();

  Rx<File> file = File('').obs;

  RxList<PaymentMethodList> paymentMethodList = <PaymentMethodList>[].obs;
  Rx<PaymentMethodList> initValue =
      PaymentMethodList(id: -1, name: "Payment Method").obs;
  RxInt paymentMethodId = (-1).obs;
  RxString paymentMethodName = "".obs;

  RxList<BankList> bankList = <BankList>[].obs;
  Rx<BankList> initBankValue = BankList(id: -1, name: "Bank Name").obs;
  RxInt bankId = (-1).obs;

  RxList<WalletTransactions> paymentList = <WalletTransactions>[].obs;
  RxString balance = ''.obs;

  Future<MyWalletModel> getPaymentDetails() async {
    try {
      paymentList.clear();
      isLoading.value = true;

      final response = await BaseClient()
          .getData(url: InfixApi.getPaymentList, header: GlobalVariable.header);

      MyWalletModel myWalletModel = MyWalletModel.fromJson(response);

      if (myWalletModel.success == true) {
        isLoading.value = false;
        balance.value =
            '${myWalletModel.data!.first.currencySymbol}${myWalletModel.data!.first.myBalance}';
        for (int i = 0;
            i < myWalletModel.data!.first.walletTransactions!.length;
            i++) {
          paymentList.add(myWalletModel.data!.first.walletTransactions![i]);
        }
      }
    } catch (e, t) {
      isLoading.value = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      isLoading.value = false;
    }

    return MyWalletModel();
  }

  Future<PaymentMethodListResponseModel> getPaymentMethod() async {
    try {
      paymentMethodLoader.value = true;

      final response = await BaseClient().getData(
          url: InfixApi.getPaymentMethodList, header: GlobalVariable.header);

      PaymentMethodListResponseModel paymentMethodListResponseModel =
          PaymentMethodListResponseModel.fromJson(response);

      if (paymentMethodListResponseModel.success == true) {
        for (int i = 0; i < paymentMethodListResponseModel.data!.length; i++) {
          paymentMethodList.add(paymentMethodListResponseModel.data![i]);
        }
        initValue.value = paymentMethodList.first;
        paymentMethodId.value = paymentMethodList.first.id!;
        paymentMethodName.value = paymentMethodList.first.name!;
        paymentMethodLoader.value = false;
      }
    } catch (e, t) {
      paymentMethodLoader.value = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      paymentMethodLoader.value = false;
    }

    return PaymentMethodListResponseModel();
  }

  Future<PaymentMethodListResponseModel> getBankList() async {
    try {
      bankListLoader.value = true;

      final response = await BaseClient()
          .getData(url: InfixApi.getBankList, header: GlobalVariable.header);

      BankListResponseModel bankListResponseModel =
          BankListResponseModel.fromJson(response);

      if (bankListResponseModel.success == true) {
        bankListLoader.value = false;

        if (bankListResponseModel.data!.isNotEmpty) {
          for (int i = 0; i < bankListResponseModel.data!.length; i++) {
            bankList.add(bankListResponseModel.data![i]);
          }
          initBankValue.value = bankList.first;
          bankId.value = bankList.first.id!;
        }
      }
    } catch (e, t) {
      bankListLoader.value = false;
      debugPrint('$e');
      debugPrint('$t');
    }

    return PaymentMethodListResponseModel();
  }

  void pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx', 'jpg', 'jpeg', 'png', 'txt'],
    );

    if (result != null) {
      file.value = File(result.files.single.path!);
    } else {
      showBasicFailedSnackBar(message: 'Canceled file selection'.tr);
      debugPrint("User canceled file selection");
    }
  }

  void showAddBalanceBottomSheet({
    required Color color,
    required TextEditingController amountController,
    required TextEditingController noteController,
    required TextEditingController browseFileTextController,
  }) {
    Get.bottomSheet(
      Obx(
        () => Container(
          color: color,
          height: Get.height * 0.5,
          padding: const EdgeInsets.all(15),
          width: Get.width,
          child: SingleChildScrollView(
            child: Column(
              children: [
                10.h.verticalSpacing,
                Text(
                  "Add Balance".tr,
                  style: AppTextStyle.fontSize14BlackW500,
                ),
                10.h.verticalSpacing,
                CustomTextFormField(
                  controller: amountController,
                  enableBorderActive: true,
                  focusBorderActive: true,
                  hintText: "${"Amount".tr} *",
                  textInputType: TextInputType.number,
                  hintTextStyle: AppTextStyle.fontSize14lightBlackW400,
                  fillColor: Colors.white,
                ),
                10.h.verticalSpacing,

                /// Payment Method
                DuplicateDropdown(
                  hint: '${"Select payment method".tr} *',
                  dropdownValue: initValue.value,
                  dropdownList: paymentMethodList,
                  changeDropdownValue: (value) {
                    initValue.value = value!;
                    paymentMethodId.value = value.id;
                    paymentMethodName.value = value.name;
                  },
                ),
                paymentMethodName.value == "Bank"
                    ? Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: bankListLoader.value
                            ? const SecondaryLoadingWidget()
                            : DuplicateDropdown(
                                dropdownValue: initBankValue.value,
                                dropdownList: bankList,
                                changeDropdownValue: (value) {
                                  initBankValue.value = value!;
                                  bankId.value = value.id;
                                },
                              ),
                      )
                    : const SizedBox(),
                10.h.verticalSpacing,
                paymentMethodName.value == "Bank" ||
                        paymentMethodName.value == "Cheque"
                    ? CustomTextFormField(
                        controller: noteController,
                        enableBorderActive: true,
                        focusBorderActive: true,
                        hintText: "Note".tr,
                        textInputType: TextInputType.text,
                        hintTextStyle: AppTextStyle.fontSize14lightBlackW400,
                        fillColor: Colors.white,
                      )
                    : const SizedBox(),
                10.h.verticalSpacing,
                paymentMethodName.value == "Bank" ||
                        paymentMethodName.value == "Cheque"
                    ? CustomTextFormField(
                        enableBorderActive: true,
                        focusBorderActive: true,
                        readOnly: true,
                        hintText: file.value.path.isNotEmpty
                            ? file.value.toString().split('/').last
                            : 'Select File'.tr,
                        fillColor: Colors.white,
                        suffixIcon: const CustomBrowseIcon(),
                        iconOnTap: () {
                          pickFile();
                          debugPrint("Browser ::: $file");
                        },
                        hintTextStyle: AppTextStyle.fontSize14lightBlackW400,
                      )
                    : const SizedBox(),
                30.h.verticalSpacing,
                paymentLoader.value
                    ? const Center(child: CircularProgressIndicator())
                    : PrimaryButton(
                        text: 'Submit'.tr,
                        onTap: () {
                          if (validation()) {
                            _selectedPaymentGateway(paymentMethodName.value);
                          }
                        },
                        padding: const EdgeInsets.all(10),
                      ),
              ],
            ),
          ),
        ),
      ),
      shape: defaultBottomSheetShape(),
    );
  }

  bool validation() {
    if (amountTextController.text.isEmpty) {
      showBasicFailedSnackBar(message: 'Enter an amount'.tr);
      return false;
    } else if (paymentMethodName.value == '') {
      showBasicFailedSnackBar(message: 'Select Payment Method'.tr);
      return false;
    }

    return true;
  }

  void _selectedPaymentGateway(value) {
    switch (value) {
      case 'Cash':
        _makeBankChequePayment();
        break;
      case 'Cheque':
        _makeBankChequePayment();
        break;
      case 'Bank':
        _makeBankChequePayment();
        break;
      case 'PayPal':
        paypalController.makePayment(
          amount: amountTextController.text,
          currency: AppConfig.stripeCurrency,
          type: 'walletAddBallence',
          paymentMethod: paymentMethodId.value,
          from: 'walletAddBallence',
        );
        break;
      case 'Stripe':
        // stripeController.makePayment(feesInvoiceList[index].amount.toString(), AppConfig.stripeCurrency);
        stripeController.makePayment(
          amount: amountTextController.text,
          currency: AppConfig.stripeCurrency,
          type: 'walletAddBallence',
          paymentMethod: paymentMethodId.value,
          from: 'walletAddBallence',
        );
        break;

      case 'Paystack':
        payStackController.makePayment(
          amount: amountTextController.text,
          currency: AppConfig.stripeCurrency,
          type: 'walletAddBallence',
          paymentMethod: paymentMethodId.value,
          from: 'walletAddBallence',
        );
        Get.back();

        break;
      case 'Xendit':
        showBasicFailedSnackBar(message: 'Service not available'.tr);
        break;

      case 'Khalti':
        showBasicFailedSnackBar(message: 'Service not available'.tr);
        break;
    }
  }

  Future<void> _makeBankChequePayment() async {
    try {
      if (kDebugMode) {
        print({
          'amount': amountTextController.text,
          'payment_method': paymentMethodId.value.toString(),
          'bank': bankId.value.toString(),
          'note': noteTextController.text,
        });
      }
      paymentLoader.value = true;
      var headers = GlobalVariable.header;
      var request =
          http.MultipartRequest('POST', Uri.parse(InfixApi.studentAddWallet));
      request.fields.addAll({
        'amount': amountTextController.text,
        'payment_method': paymentMethodId.value.toString(),
        'bank': bankId.value.toString(),
        'note': noteTextController.text,
      });

      if (file.value.path.isNotEmpty) {
        request.files
            .add(await http.MultipartFile.fromPath('file', file.value.path));
      }

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      final responseBody = await response.stream.bytesToString();
      final decodedResponse = json.decode(responseBody);
      debugPrint(decodedResponse.toString());

      if (response.statusCode == 200) {
        paymentLoader.value = false;
        _clearData();
        getPaymentDetails();
        Get.back();
        showBasicSuccessSnackBar(message: decodedResponse['message']);
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

  void _clearData() {
    amountTextController.clear();
    noteTextController.clear();
    paymentMethodId.value = -1;
    bankId.value = -1;
  }

  @override
  void onInit() {
    if ((Get.find<GlobalRxVariableController>().token.value ?? "").isNotEmpty) {
      getPaymentDetails();
    }
    if (Get.find<GlobalRxVariableController>().roleId.value == 2) {
      getPaymentMethod();
      getBankList();
    }

    super.onInit();
  }
}
