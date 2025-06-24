import 'package:flutter/material.dart';
import 'package:infixedu/app/data/constants/app_colors.dart';
import 'package:infixedu/app/data/constants/app_text_style.dart';
import 'package:infixedu/app/data/constants/image_path.dart';
import 'package:infixedu/app/modules/fees/views/widget/credit_card.dart';
import 'package:infixedu/app/modules/fees/views/widget/fees_tile.dart';
import 'package:infixedu/app/utilities/extensions/widget.extensions.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:infixedu/app/utilities/widgets/customised_loading_widget/customised_loading_widget.dart';

import 'package:get/get.dart';

import '../controllers/admin_fees_invoice_controller.dart';

class AdminFeesInvoiceView extends GetView<AdminFeesInvoiceController> {
  const AdminFeesInvoiceView({super.key});

  @override
  Widget build(BuildContext context) {
    return InfixEduScaffold(
      title: "Fees Invoice".tr,
      body: CustomBackground(
        customWidget: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Obx(
            () => SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 25,
                        width: 75,
                        child: Image.asset(
                          ImagePath.appLogo,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "${"Invoice No".tr}: ${controller.feesController.feesInvoiceInfo?.invoiceId}",
                            style: AppTextStyle.homeworkElements,
                          ),
                          Text(
                            "${"Created Date".tr}: ${controller.feesController.feesInvoiceInfo?.createDate}",
                            style: AppTextStyle.homeworkElements,
                          ),
                          Text(
                            "${"Due Date".tr}: ${controller.feesController.feesInvoiceInfo?.dueDate}",
                            style: AppTextStyle.homeworkElements,
                          ),
                        ],
                      ),
                    ],
                  ),
                  10.verticalSpacing,
                  Text(
                    "Annual Exam Fee".tr,
                    style: AppTextStyle.fontSize14BlackW500,
                  ),
                  30.verticalSpacing,
                  controller.feesController.feesInvoiceLoader.value
                      ? const SecondaryLoadingWidget()
                      : ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount:
                              controller.feesController.invoiceDetails.length,
                          itemBuilder: (context, index) {
                            return FeesTile(
                              amount: controller
                                  .feesController.invoiceDetails[index].amount,
                              paid: controller.feesController
                                  .invoiceDetails[index].paidAmount,
                              fine: controller
                                  .feesController.invoiceDetails[index].fine,
                              waiver: controller
                                  .feesController.invoiceDetails[index].weaver,
                              subTotal: controller.feesController
                                  .invoiceDetails[index].subTotal,
                              isInvoice: true,
                              totalAmount: controller.feesController
                                  .invoiceDetails[index].totalAmount,
                              totalWaiver: controller
                                  .feesController.invoiceDetails[index].weaver,
                              totalFine: controller
                                  .feesController.invoiceDetails[index].fine,
                              totalPaid: controller.feesController
                                  .invoiceDetails[index].paidAmount,
                              grandTotal: controller.feesController
                                  .invoiceDetails[index].grandTotal,
                              dueBalance: controller.feesController
                                  .invoiceDetails[index].dueBalance,
                            );
                          }),
                  controller.feesController.feesInvoiceLoader.value
                      ? const SecondaryLoadingWidget()
                      : ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: controller.feesController.banks.length,
                          itemBuilder: (context, index) {
                            return CreditCard(
                              bankName: controller
                                      .feesController.banks[index].bankName ??
                                  "",
                              accountNumber: controller.feesController
                                      .banks[index].accountNumber ??
                                  "",
                              accountName: controller.feesController
                                      .banks[index].accountName ??
                                  "",
                              type: controller.feesController.banks[index]
                                      .accountType ??
                                  "",
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
}
