import 'package:flutter/material.dart';
import 'package:infixedu/app/data/constants/app_colors.dart';
import 'package:infixedu/app/data/constants/app_text.dart';
import 'package:infixedu/app/data/constants/app_text_style.dart';
import 'package:infixedu/app/data/constants/image_path.dart';
import 'package:infixedu/app/modules/fees/views/widget/credit_card.dart';
import 'package:infixedu/app/modules/fees/views/widget/fees_tile.dart';
import 'package:infixedu/app/modules/home/controllers/home_controller.dart';
import 'package:infixedu/app/modules/student_wallet/controllers/student_wallet_controller.dart';
import 'package:infixedu/app/utilities/api_urls.dart';
import 'package:infixedu/app/utilities/extensions/widget.extensions.dart';
import 'package:infixedu/app/utilities/message/snack_bars.dart';
import 'package:infixedu/app/utilities/widgets/appbar/back_button_widget.dart';
import 'package:infixedu/app/utilities/widgets/customised_loading_widget/customised_loading_widget.dart';
import 'package:infixedu/config/global_variable/global_variable_controller.dart';
import 'package:infixedu/config/global_variable/payment/pay_stack_controller.dart';
import 'package:infixedu/config/global_variable/payment/paypal_controller.dart';
import 'package:infixedu/config/global_variable/payment/stripe_controller.dart';
import 'package:infixedu/domain/base_client/base_client.dart';
import 'package:infixedu/domain/core/model/student_fees_response_model/fees_invoice_response_model/fees_invoice_details_response_model.dart';
import 'package:infixedu/domain/core/model/student_fees_response_model/fees_invoice_response_model/fees_invoice_response_model.dart';
import 'package:infixedu/domain/core/model/student_fees_response_model/student_fees_response_model.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class FeesController extends GetxController {
  PayStackController payStackController = Get.put(PayStackController());
  PaypalController paypalController = Get.put(PaypalController());
  StripeController stripeController = Get.put(StripeController());
  GlobalRxVariableController globalRxVariableController = Get.find();
  StudentWalletController studentWalletController =
      Get.put(StudentWalletController());

  TextEditingController noteTextController = TextEditingController();

  // LoadingController loadingController = Get.find();
  RxBool feesLoader = false.obs;
  RxBool invoiceLoader = false.obs;
  HomeController homeController = Get.find();

  RxInt recordId = 0.obs;
  final selectIndex = RxInt(0);

  List<FeesInvoice> feesInvoiceList = [];

  /// New Fees
  List<PaymentMethods> paymentMethods = <PaymentMethods>[];
  List<BankAccounts> bankAccountsList = <BankAccounts>[];
  FeesInvoiceInfo? paymentFeesInvoiceInfo;
  List<FeesInvoiceDetails> paymentInvoiceDetails = <FeesInvoiceDetails>[];

  Rx<PaymentMethods> methodInitValue =
      PaymentMethods(id: -1, name: "Payment Method").obs;
  RxString paymentMethodName = "".obs;
  RxInt paymentMethodId = (-1).obs;

  Rx<BankAccounts> bankInitValue = BankAccounts(name: "Payment Method").obs;
  RxInt bankId = (-1).obs;
  RxString bankName = "".obs;

  InvoiceInfo? feesInvoiceInfo;
  RxList<InvoiceDetails> invoiceDetails = <InvoiceDetails>[].obs;
  RxList<Banks> banks = <Banks>[].obs;

  RxBool feesInvoiceLoader = false.obs;
  RxString status = "".obs;

  Future<StudentFeesInvoiceResponseModel?> getAllFeesList(
      {required int studentId, required int recordId}) async {
    feesInvoiceList.clear();
    try {
      feesLoader.value = true;

      final response = await BaseClient().getData(
        url: InfixApi.getStudentFeesList(
            studentId: studentId, recordId: recordId),
        header: GlobalVariable.header,
      );

      StudentFeesInvoiceResponseModel studentFeesInvoiceResponseModel =
          StudentFeesInvoiceResponseModel.fromJson(response);
      if (studentFeesInvoiceResponseModel.success == true) {
        feesLoader.value = false;
        if (studentFeesInvoiceResponseModel.data!.feesInvoice!.isNotEmpty) {
          for (int i = 0;
              i < studentFeesInvoiceResponseModel.data!.feesInvoice!.length;
              i++) {
            feesInvoiceList
                .add(studentFeesInvoiceResponseModel.data!.feesInvoice![i]);
          }
        }
      } else {
        feesLoader.value = false;
        showBasicFailedSnackBar(
          message: studentFeesInvoiceResponseModel.message ??
              AppText.somethingWentWrong.tr,
        );
      }
    } catch (e, t) {
      feesLoader.value = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      feesLoader.value = false;
    }
    return StudentFeesInvoiceResponseModel();
  }

  Future<FeesInvoiceResponseModel?> getFeesInvoice(
      {required int invoiceId}) async {
    try {
      feesInvoiceLoader.value = true;
      invoiceDetails.clear();
      banks.clear();
      final response = await BaseClient().getData(
        url: InfixApi.getStudentFeesDetails(invoiceId: invoiceId),
        header: GlobalVariable.header,
      );

      FeesInvoiceResponseModel feesInvoiceResponseModel =
          FeesInvoiceResponseModel.fromJson(response);
      if (feesInvoiceResponseModel.success == true) {
        feesInvoiceLoader.value = false;

        feesInvoiceInfo = feesInvoiceResponseModel.data?.invoiceInfo;

        if (feesInvoiceResponseModel.data!.invoiceDetails!.isNotEmpty) {
          for (int i = 0;
              i < feesInvoiceResponseModel.data!.invoiceDetails!.length;
              i++) {
            invoiceDetails
                .add(feesInvoiceResponseModel.data!.invoiceDetails![i]);
          }
        }
        if (feesInvoiceResponseModel.data!.banks!.isNotEmpty) {
          for (int i = 0;
              i < feesInvoiceResponseModel.data!.banks!.length;
              i++) {
            banks.add(feesInvoiceResponseModel.data!.banks![i]);
          }
        }
      } else {
        feesInvoiceLoader.value = false;
        showBasicFailedSnackBar(
          message:
              feesInvoiceResponseModel.message ?? AppText.somethingWentWrong.tr,
        );
      }
    } catch (e, t) {
      feesInvoiceLoader.value = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      feesInvoiceLoader.value = false;
    }
    return FeesInvoiceResponseModel();
  }

  void showInvoice({required int index}) {
    Get.dialog(
      Material(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Obx(
            () => SingleChildScrollView(
              child: Column(
                children: [
                  20.verticalSpacing,
                  Row(
                    children: [
                      BackButtonWidget(
                        color: Colors.black,
                      ),
                      20.horizontalSpacing,
                      Text(
                        "Invoice".tr,
                        style: AppTextStyle.fontSize16lightBlackW500,
                      ),
                    ],
                  ),
                  20.verticalSpacing,
                  feesInvoiceLoader.value
                      ? const SecondaryLoadingWidget()
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset(
                              ImagePath.appLogo,
                              height: Get.height * 0.2,
                              width: Get.width * 0.3,
                              color: AppColors.primaryColor,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "${"Invoice".tr}: ${feesInvoiceInfo?.invoiceId}",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppTextStyle.fontSize13BlackW400,
                                  ),
                                  5.verticalSpacing,
                                  Text(
                                    "${"Created Date".tr}: ${feesInvoiceInfo?.createDate}",
                                    style: AppTextStyle.fontSize13BlackW400,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  5.verticalSpacing,
                                  Text(
                                    "${"Due Date".tr}: ${feesInvoiceInfo?.dueDate}",
                                    style: AppTextStyle.fontSize13BlackW400,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                  30.verticalSpacing,
                  feesInvoiceLoader.value
                      ? const SecondaryLoadingWidget()
                      : ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: invoiceDetails.length,
                          itemBuilder: (context, index) {
                            return FeesTile(
                              amount: invoiceDetails[index].amount,
                              paid: invoiceDetails[index].paidAmount,
                              fine: invoiceDetails[index].fine,
                              waiver: invoiceDetails[index].weaver,
                              subTotal: invoiceDetails[index].subTotal,
                              isInvoice: true,
                              totalAmount: invoiceDetails[index].totalAmount,
                              totalWaiver: invoiceDetails[index].weaver,
                              totalFine: invoiceDetails[index].fine,
                              totalPaid: invoiceDetails[index].paidAmount,
                              grandTotal: invoiceDetails[index].grandTotal,
                              dueBalance: invoiceDetails[index].dueBalance,
                            );
                          }),
                  feesInvoiceLoader.value
                      ? const SecondaryLoadingWidget()
                      : ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: banks.length,
                          itemBuilder: (context, index) {
                            return CreditCard(
                              bankName: banks[index].bankName ?? "",
                              accountNumber: banks[index].accountNumber ?? "",
                              accountName: banks[index].accountName ?? "",
                              type: banks[index].accountType ?? "",
                            );
                          }),
                  30.verticalSpacing,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> showInvoiceDetails({required int invoiceId}) async {
    AlertDialog alert = AlertDialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      iconColor: Colors.transparent,
      content: Center(child: Lottie.asset('assets/images/loader.json')),
    );

    showDialog(
      barrierDismissible: false,
      context: Get.context!,
      barrierColor: AppColors.secondaryColor.withOpacity(0.15),
      builder: (BuildContext context) {
        return alert;
      },
    );

    bankAccountsList.clear();
    paymentMethods.clear();
    paymentInvoiceDetails.clear();

    invoiceLoader.value = true;

    try {
      final response = await BaseClient().getData(
          url: InfixApi.getFeesInvoiceDetails(invoiceId: invoiceId),
          header: GlobalVariable.header);
      FeesInvoiceDetailsResponseModel responseModel =
          FeesInvoiceDetailsResponseModel.fromJson(response);

      if (responseModel.success == true) {
        // showAddPayment(index: 1);
        Get.back();
        if (responseModel.data!.bankAccounts!.isNotEmpty) {
          for (int i = 0; i < responseModel.data!.bankAccounts!.length; i++) {
            bankAccountsList.add(responseModel.data!.bankAccounts![i]);
          }
        }

        if (responseModel.data!.paymentMethods!.isNotEmpty) {
          for (int i = 0; i < responseModel.data!.paymentMethods!.length; i++) {
            paymentMethods.add(responseModel.data!.paymentMethods![i]);
          }
        }

        if (responseModel.data!.invoiceDetails!.isNotEmpty) {
          for (int i = 0; i < responseModel.data!.invoiceDetails!.length; i++) {
            paymentInvoiceDetails.add(responseModel.data!.invoiceDetails![i]);
          }
        }

        paymentFeesInvoiceInfo = responseModel.data?.invoiceInfo;
        methodInitValue.value = paymentMethods.first;
        paymentMethodName.value = paymentMethods.first.name!;
        paymentMethodId.value = paymentMethods.first.id!;
        if (bankAccountsList.isNotEmpty) {
          bankInitValue.value = bankAccountsList.first;
          bankId.value = bankAccountsList.first.id ?? (-1);
        }
      } else {
        Get.back();
        showBasicFailedSnackBar(
            message: responseModel.message ?? AppText.somethingWentWrong.tr);
      }
    } catch (e, t) {
      Get.back();
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      Get.back();
    }
  }

  // void showAddPayment({required int index}) {
  //   Get.dialog(
  //     Material(
  //       child: Obx(
  //         () => SingleChildScrollView(
  //           child: Padding(
  //             padding: const EdgeInsets.symmetric(horizontal: 15.0),
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 20.verticalSpacing,
  //                 Row(
  //                   children: [
  //                     InkWell(
  //                       onTap: () => Get.back(),
  //                       child: Image.asset(
  //                         ImagePath.back,
  //                         scale: 4,
  //                         color: Colors.black,
  //                       ),
  //                     ),
  //                     20.horizontalSpacing,
  //                     Text(
  //                       "Add Payment".tr,
  //                       style: AppTextStyle.fontSize16lightBlackW500,
  //                     ),
  //                   ],
  //                 ),
  //                 30.verticalSpacing,
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   children: [
  //                     Image.asset(
  //                       ImagePath.appLogo,
  //                       height: Get.height * 0.2,
  //                       width: Get.width * 0.3,
  //                       color: AppColors.primaryColor,
  //                     ),
  //                     Column(
  //                       crossAxisAlignment: CrossAxisAlignment.end,
  //                       children: [
  //                         Text(
  //                           "${"Invoice".tr}: ",
  //                           style: AppTextStyle.fontSize13BlackW400,
  //                         ),
  //                         Text(
  //                           "${"Due Date".tr}: ",
  //                           style: AppTextStyle.fontSize13BlackW400,
  //                         ),
  //                         Text(
  //                           "${"Wallet Balance".tr}: ${paymentFeesInvoiceInfo?.walletBalance}",
  //                           style: AppTextStyle.blackFontSize14W400,
  //                         ),
  //                         Text(
  //                           "${"Add In wallet".tr}: ",
  //                           style: AppTextStyle.blackFontSize14W400,
  //                         ),
  //                       ],
  //                     )
  //                   ],
  //                 ),
  //                 ListView.builder(
  //                     physics: const NeverScrollableScrollPhysics(),
  //                     shrinkWrap: true,
  //                     itemCount: paymentInvoiceDetails.length,
  //                     itemBuilder: (context, index) {
  //                       return Text(paymentInvoiceDetails[index]
  //                           .feesType!
  //                           .name
  //                           .toString());
  //                     }),
  //                 30.verticalSpacing,
  //                 Text(
  //                   "${"Select Payment".tr}:",
  //                   style: AppTextStyle.blackFontSize14W400,
  //                 ),
  //                 20.verticalSpacing,
  //                 DuplicateDropdown(
  //                   // dropdownValue: studentWalletController.initValue.value,
  //                   // dropdownList: studentWalletController.paymentMethodList,
  //
  //                   dropdownValue: methodInitValue.value,
  //                   dropdownList: paymentMethods,
  //
  //                   changeDropdownValue: (value) {
  //                     methodInitValue.value = value!;
  //                     // studentWalletController.paymentMethodId.value = value.id;
  //                     paymentMethodName.value = value.name;
  //                   },
  //                 ),
  //                 10.verticalSpacing,
  //                 paymentMethodName.value == "Bank"
  //                     ? Padding(
  //                         padding: const EdgeInsets.only(top: 10.0),
  //                         child: studentWalletController.bankListLoader.value
  //                             ? const SecondaryLoadingWidget()
  //                             : DuplicateDropdown(
  //                                 // dropdownValue: studentWalletController.initBankValue.value,
  //                                 // dropdownList: studentWalletController.bankList,
  //
  //                                 dropdownValue: bankInitValue.value,
  //                                 dropdownList: bankAccounts,
  //
  //                                 changeDropdownValue: (value) {
  //                                   bankInitValue.value = value!;
  //                                   bankId.value = value.id;
  //                                 },
  //                               ),
  //                       )
  //                     : const SizedBox(),
  //                 paymentMethodName.value == "Bank"
  //                     ? 10.verticalSpacing
  //                     : const SizedBox(),
  //                 paymentMethodName.value == "Bank" ||
  //                         paymentMethodName.value == "Cheque"
  //                     ? CustomTextFormField(
  //                         controller: noteTextController,
  //                         enableBorderActive: true,
  //                         focusBorderActive: true,
  //                         hintText: "Note".tr,
  //                         textInputType: TextInputType.number,
  //                         hintTextStyle: AppTextStyle.fontSize14lightBlackW400,
  //                         fillColor: Colors.white,
  //                       )
  //                     : const SizedBox(),
  //                 paymentMethodName.value == "Bank" ||
  //                         paymentMethodName.value == "Cheque"
  //                     ? 10.verticalSpacing
  //                     : const SizedBox(),
  //                 paymentMethodName.value == "Bank" ||
  //                         paymentMethodName.value == "Cheque"
  //                     ? CustomTextFormField(
  //                         enableBorderActive: true,
  //                         focusBorderActive: true,
  //                         hintText:
  //                             "${studentWalletController.file.value.path.isNotEmpty ? studentWalletController.file : 'Select File'}",
  //                         fillColor: Colors.white,
  //                         suffixIcon: Padding(
  //                           padding:
  //                               const EdgeInsets.symmetric(horizontal: 10.0),
  //                           child: Column(
  //                             mainAxisAlignment: MainAxisAlignment.center,
  //                             children: [
  //                               Text(
  //                                 "Browse".tr,
  //                                 style:
  //                                     AppTextStyle.fontSize12lightViolateW400,
  //                               ),
  //                               const CustomDivider(
  //                                 width: 42,
  //                                 height: 1,
  //                                 color: AppColors.profileValueColor,
  //                               ),
  //                             ],
  //                           ),
  //                         ),
  //                         iconOnTap: () {
  //                           studentWalletController.pickFile();
  //                           debugPrint(
  //                               "Browser ::: ${studentWalletController..file}");
  //                         },
  //                         hintTextStyle: AppTextStyle.fontSize14lightBlackW400,
  //                       )
  //                     : const SizedBox(),
  //                 30.verticalSpacing,
  //                 PrimaryButton(
  //                   text: 'Pay'.tr,
  //                   onTap: () {
  //                     if (paymentMethodName.value != '') {
  //                       _selectedPaymentGateway(paymentMethodName.value, index);
  //                     }
  //                   },
  //                   padding: const EdgeInsets.all(10),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  @override
  void onInit() {
    if (homeController.studentRecordList.isNotEmpty) {
      getAllFeesList(
        studentId: globalRxVariableController.studentId.value!,
        recordId: globalRxVariableController.studentRecordId.value!,
      );
    }

    super.onInit();
  }
}
