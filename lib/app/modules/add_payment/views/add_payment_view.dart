import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infixedu/app/data/constants/app_colors.dart';
import 'package:infixedu/app/data/constants/image_path.dart';
import 'package:infixedu/app/modules/add_payment/views/widgets/invoice_card.dart';
import 'package:infixedu/app/modules/fees/views/widget/text_card.dart';
import 'package:infixedu/app/utilities/extensions/widget.extensions.dart';
import 'package:infixedu/app/utilities/message/snack_bars.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_divider.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/duplicate_dropdown.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/primary_button.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/text_field.dart';
import 'package:infixedu/config/global_variable/global_variable_controller.dart';

import 'package:get/get.dart';

import '../../../data/constants/app_text_style.dart';
import '../controllers/add_payment_controller.dart';

class AddPaymentView extends GetView<AddPaymentController> {
  const AddPaymentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => InfixEduScaffold(
          title: "Add Payment".tr,
          body: RefreshIndicator(
            onRefresh: () async {},
            child: CustomBackground(
              customWidget: Padding(
                padding: const EdgeInsets.all(17.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: controller.feesController.paymentInvoiceDetails
                                    .length <
                                3
                            ? 250.h
                            : Get.height / 2.55.h,
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: controller
                              .feesController.paymentInvoiceDetails.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 21.0),
                              child: InvoiceCard(
                                feesType: controller
                                    .feesController
                                    .paymentInvoiceDetails[index]
                                    .feesType
                                    ?.name,
                                amount: controller.feesController
                                    .paymentInvoiceDetails[index].amount
                                    .toString(),
                                due: controller.feesController
                                    .paymentInvoiceDetails[index].dueAmount
                                    .toString(),
                                onTap: () {
                                  controller.waiverTextController.text =
                                      controller
                                                  .feesController
                                                  .paymentInvoiceDetails[index]
                                                  .weaver !=
                                              null
                                          ? controller
                                              .feesController
                                              .paymentInvoiceDetails[index]
                                              .weaver
                                              .toString()
                                          : '-';
                                  controller.fineTextController.text =
                                      controller
                                                  .feesController
                                                  .paymentInvoiceDetails[index]
                                                  .weaver !=
                                              null
                                          ? controller
                                              .feesController
                                              .paymentInvoiceDetails[index]
                                              .weaver
                                              .toString()
                                          : '-';
                                  controller.showAddPaymentBottomSheet(
                                      index: index);
                                },
                              ),
                            );
                          },
                        ),
                      ),

                      21.h.verticalSpacing,
                      const CustomDivider(
                        height: 1,
                        color: Color(0xFFEAE7F0),
                      ),
                      23.h.verticalSpacing,

                      /// Text card
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomTextCard(
                            title: 'Wallet Balance'.tr,
                            subTitle:
                                '${Get.find<GlobalRxVariableController>().currencySymbol.value != null ? Get.find<GlobalRxVariableController>().currencySymbol : '\$'} ${controller.feesController.paymentFeesInvoiceInfo!.walletBalance.toString() != 'null' ? controller.feesController.paymentFeesInvoiceInfo?.walletBalance : '0'}',
                            width: Get.width / 2.55,
                          ),
                          10.horizontalSpacing,
                          CustomTextCard(
                            title: 'Add In Wallet'.tr,
                            subTitle:
                                '${Get.find<GlobalRxVariableController>().currencySymbol.value != null ? Get.find<GlobalRxVariableController>().currencySymbol : '\$'} ${controller.addInWallet}',
                            width: Get.width / 2.55,
                          ),
                        ],
                      ),
                      10.h.verticalSpacing,
                      Text(
                        'Select Payment Method'.tr,
                        style: AppTextStyle.fontSize13BlackWight700,
                      ),
                      15.h.verticalSpacing,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          /// Payment Method Dropdown
                          SizedBox(
                            width: 163.w,
                            height: 38.h,
                            child: DuplicateDropdown(
                              dropdownValue: controller
                                  .feesController.methodInitValue.value,
                              dropdownList: controller
                                  .feesController.paymentMethods
                                  .where((method) => method.name != "Wallet")
                                  .toList(),
                              borderRadius: 2,
                              changeDropdownValue: (value) {
                                controller.feesController.methodInitValue
                                    .value = value!;
                                controller.feesController.paymentMethodName
                                    .value = value.name;
                                controller.feesController.paymentMethodId
                                    .value = value.id;
                              },
                            ),
                          ),

                          /// Select Bank Method
                          controller.feesController.paymentMethodName.value ==
                                  "Bank"
                              ? Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 10.0),
                                    child: SizedBox(
                                      width: 163.w,
                                      height: 38.h,
                                      child: DuplicateDropdown(
                                        dropdownValue: controller
                                            .feesController.bankInitValue.value,
                                        dropdownList: controller
                                            .feesController.bankAccountsList,
                                        borderRadius: 2,
                                        changeDropdownValue: (value) {
                                          controller.feesController
                                              .bankInitValue.value = value!;
                                          controller.feesController.bankId
                                              .value = value.id;
                                        },
                                      ),
                                    ),
                                  ),
                                )
                              : const SizedBox(),
                        ],
                      ),
                      12.h.verticalSpacing,
                      controller.feesController.paymentMethodName.value ==
                                  "Bank" ||
                              controller
                                      .feesController.paymentMethodName.value ==
                                  "Cheque"
                          ? CustomTextFormField(
                              enableBorderActive: true,
                              focusBorderActive: true,
                              borderRadius: 2,
                              readOnly: true,
                              hintText: controller
                                      .feesController
                                      .studentWalletController
                                      .file
                                      .value
                                      .path
                                      .isNotEmpty
                                  ? controller.feesController
                                      .studentWalletController.file.value
                                      .toString()
                                      .split('/')
                                      .last
                                  : 'Select File'.tr,
                              fillColor: Colors.white,
                              suffixIcon: Container(
                                padding: const EdgeInsets.all(5),
                                margin: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                    color: AppColors.primaryColor,
                                    borderRadius: BorderRadius.circular(2)),
                                width: Get.width / 2.8,
                                height: 26.h,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    // Image.asset(
                                    //   ImagePath.upload,
                                    //   color: Colors.white,
                                    //   height: 12,
                                    // ),
                                    Expanded(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(top: 3.0),
                                        child: Transform.flip(
                                          flipY: true,
                                          child: Image.asset(
                                            ImagePath.download,
                                            scale: 4,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    4.8.horizontalSpacing,
                                    Expanded(
                                      child: Text(
                                        "Upload Document".tr,
                                        overflow: TextOverflow.ellipsis,
                                        style: AppTextStyle
                                            .fontSize12WhiteWight500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              iconOnTap: () {
                                controller
                                    .feesController.studentWalletController
                                    .pickFile();
                              },
                              hintTextStyle: AppTextStyle.hintTextStyle,
                            )
                          : const SizedBox(),
                      controller.feesController.paymentMethodName.value ==
                                  "Bank" ||
                              controller
                                      .feesController.paymentMethodName.value ==
                                  "Cheque"
                          ? 12.h.verticalSpacing
                          : const SizedBox(),
                      controller.feesController.paymentMethodName.value ==
                                  "Bank" ||
                              controller
                                      .feesController.paymentMethodName.value ==
                                  "Cheque"
                          ? Container(
                              height: 88.h,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              // Adjust padding as needed
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2),
                                // Radius of the border
                                border: Border.all(
                                  color:
                                      const Color(0xFFEAE7F0), // Border color
                                  width: 1, // Border width
                                ),
                              ),
                              child: TextField(
                                maxLines: 2,
                                controller:
                                    controller.paymentNoteTextController,
                                decoration: InputDecoration(
                                  border:
                                      InputBorder.none, // Remove default border
                                  hintText: "Note".tr,
                                  hintStyle: AppTextStyle.hintTextStyle,
                                ),
                              ),
                            )
                          : const SizedBox(),

                      47.h.verticalSpacing,

                      Center(
                        child: PrimaryButton(
                          onTap: () {
                            if (controller.paidAmountList.isNotEmpty) {
                              for (int i = 0;
                                  i < controller.paidAmountList.length;
                                  i++) {
                                controller.totalPaidAmount +=
                                    controller.paidAmountList[i];
                              }
                              controller.showInvoiceListBottomSheet(index: 0);
                            } else {
                              showBasicFailedSnackBar(
                                  message: 'Payment List is empty'.tr);
                            }
                          },
                          height: 36,
                          width: 152.w,
                          borderRadius: 2.w,
                          text: 'Pay Now'.tr,
                          textStyle: AppTextStyle.fontSize13WhiteWight500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
