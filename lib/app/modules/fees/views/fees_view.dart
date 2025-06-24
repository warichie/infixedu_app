import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infixedu/app/modules/fees/controllers/fees_controller.dart';
import 'package:infixedu/app/modules/fees/views/widget/fees_tile.dart';
import 'package:infixedu/app/routes/app_pages.dart';
import 'package:infixedu/app/utilities/extensions/widget.extensions.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:infixedu/app/utilities/widgets/customised_loading_widget/customised_loading_widget.dart';
import 'package:infixedu/app/utilities/widgets/loader/loading.widget.dart';
import 'package:infixedu/app/utilities/widgets/no_data_available/no_data_available_widget.dart';
import 'package:infixedu/app/utilities/widgets/study_button/study_button.dart';

import 'package:get/get.dart';

class FeesView extends GetView<FeesController> {
  const FeesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => InfixEduScaffold(
        title: "Fees".tr,
        leadingIcon: const SizedBox(),
        body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              CustomBackground(
                customWidget: RefreshIndicator(
                  onRefresh: () async {
                    controller.getAllFeesList(
                      studentId: controller
                          .globalRxVariableController.studentId.value!,
                      recordId: controller
                          .globalRxVariableController.studentRecordId.value!,
                    );
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      controller.homeController.loadingController.isLoading
                          ? const LoadingWidget()
                          : Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15.0, vertical: 20),
                              child: SizedBox(
                                height: 50.h,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: controller
                                      .homeController.studentRecordList.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: StudyButton(
                                          title:
                                              "${"Class".tr} ${controller.homeController.studentRecordList[index].studentRecordClass}(${controller.homeController.studentRecordList[index].section})",
                                          onItemTap: () {
                                            controller.selectIndex.value =
                                                index;
                                            controller.recordId.value =
                                                controller
                                                    .homeController
                                                    .studentRecordList[index]
                                                    .id;

                                            controller.getAllFeesList(
                                                studentId: controller
                                                    .globalRxVariableController
                                                    .studentId
                                                    .value!,
                                                recordId: controller.recordId
                                                    .toInt());
                                          },
                                          isSelected:
                                              controller.selectIndex.value ==
                                                  index,
                                        ));
                                  },
                                ),
                              ),
                            ),
                      Expanded(
                        child: controller.feesInvoiceList.isEmpty &&
                                controller.feesLoader.value == false
                            ? const Center(
                                child: NoDataAvailableWidget(),
                              )
                            : controller.feesLoader.value
                                ? const SecondaryLoadingWidget()
                                : ListView.builder(
                                    physics: const BouncingScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount:
                                        controller.feesInvoiceList.length,
                                    itemBuilder: (context, index) {
                                      String colorCode = '';
                                      if (controller
                                              .feesInvoiceList[index].status
                                              ?.toUpperCase() ==
                                          'UNPAID') {
                                        colorCode = '0xFFE3342F';
                                      } else if (controller
                                              .feesInvoiceList[index].status
                                              ?.toUpperCase() ==
                                          'PAID') {
                                        colorCode = '0xFF3AC172';
                                      } else if (controller
                                              .feesInvoiceList[index].status
                                              ?.toUpperCase() ==
                                          'PARTIAL') {
                                        colorCode = '0xFFFFBE00';
                                      }
                                      return FeesTile(
                                        statusText: controller
                                            .feesInvoiceList[index].status,
                                        statusColor:
                                            Color(int.tryParse(colorCode)!),
                                        dueDate: controller
                                            .feesInvoiceList[index].createDate,
                                        duration: "Monthly".tr,
                                        amount: controller
                                            .feesInvoiceList[index].amount
                                            .toString(),
                                        paid: controller
                                            .feesInvoiceList[index].paidAmount
                                            .toString(),
                                        balance: controller
                                            .feesInvoiceList[index].balance
                                            .toString(),
                                        status: controller
                                            .feesInvoiceList[index].status!,
                                        onAddPaymentTap: () {
                                          // controller.isLoading.value = true;
                                          // Get.toNamed(Routes.ADD_PAYMENT);
                                          controller
                                              .showInvoiceDetails(
                                                  invoiceId: controller
                                                      .feesInvoiceList[index]
                                                      .id!)
                                              .then((value) => Get.toNamed(
                                                      Routes.ADD_PAYMENT,
                                                      arguments: {
                                                        'invoiceId': controller
                                                            .feesInvoiceList[
                                                                index]
                                                            .id!
                                                      }));

                                          // controller.showInvoiceDetails(invoiceId: controller.feesInvoiceList[index].id!).then((value) => controller.showAddPayment(index: index));
                                          // controller.showAddPayment(index: index);
                                        },
                                        onViewInvoiceTap: () {
                                          controller.getFeesInvoice(
                                              invoiceId: controller
                                                  .feesInvoiceList[index].id!);
                                          controller.showInvoice(index: index);
                                        },
                                      );
                                    },
                                  ),
                      ),
                      200.verticalSpacing,
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
