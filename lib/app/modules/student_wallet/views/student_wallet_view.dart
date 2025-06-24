import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infixedu/app/data/constants/app_colors.dart';
import 'package:infixedu/app/utilities/extensions/widget.extensions.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/primary_button.dart';
import 'package:infixedu/app/utilities/widgets/customised_loading_widget/customised_loading_widget.dart';
import 'package:infixedu/app/utilities/widgets/no_data_available/no_data_available_widget.dart';
import 'package:infixedu/app/utilities/widgets/show_status_tile/show_status_tile.dart';

import 'package:get/get.dart';

import '../../../../config/global_variable/global_variable_controller.dart';
import '../controllers/student_wallet_controller.dart';

class StudentWalletView extends GetView<StudentWalletController> {
  const StudentWalletView({super.key});

  @override
  Widget build(BuildContext context) {
    return InfixEduScaffold(
      title: "My Wallet".tr,
      body: CustomBackground(
        customWidget: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0.w, vertical: 15.w),
          child: Column(
            children: [
              Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    PrimaryButton(
                      text: "${"Balance".tr} : ${controller.balance}",
                      height: 28,
                      borderRadius: 6,
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                    ),
                    if (Get.find<GlobalRxVariableController>().roleId.value ==
                        2)
                      PrimaryButton(
                        text: "Add Balance".tr,
                        height: 28,
                        borderRadius: 6,
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        onTap: () => controller.showAddBalanceBottomSheet(
                          color: Colors.white,
                          amountController: controller.amountTextController,
                          noteController: controller.noteTextController,
                          browseFileTextController:
                              controller.browseFileTextController,
                        ),
                      ),
                  ],
                ),
              ),
              20.h.verticalSpacing,
              Obx(() => Expanded(
                    child: RefreshIndicator(
                      color: AppColors.primaryColor,
                      onRefresh: () async {
                        controller.paymentList.clear();
                        controller.getPaymentDetails();
                      },
                      child: controller.isLoading.value
                          ? const SecondaryLoadingWidget()
                          : controller.paymentList.isNotEmpty
                              ? ListView.builder(
                                  itemCount: controller.paymentList.length,
                                  itemBuilder: (context, index) {
                                    String colorCode = '';
                                    if (controller.paymentList[index].status ==
                                        'Reject') {
                                      colorCode = '0xFFE3342F';
                                    } else if (controller
                                            .paymentList[index].status ==
                                        'Approve') {
                                      colorCode = '0xFF3AC172';
                                    } else if (controller
                                            .paymentList[index].status ==
                                        'Pending') {
                                      colorCode = '0xFFFFBE00';
                                    } else {
                                      colorCode = '0xFF412C56';
                                    }
                                    if (kDebugMode) {
                                      print(
                                          "Payment method is ${controller.paymentList[index].paymentMethod}");
                                    }
                                    return ShowStatusTile(
                                      firstTitle: "Date".tr,
                                      firstValue: DateTime.tryParse(controller
                                                  .paymentList[index]
                                                  .createdAt ??
                                              '')
                                          ?.yyyy_mm_dd,
                                      secondTitle: "Method".tr,
                                      secondValue: controller
                                          .paymentList[index].paymentMethod,
                                      thirdTitle: "Amount".tr,
                                      thirdValue: controller
                                          .paymentList[index].amount
                                          .toString(),
                                      activeStatus:
                                          controller.paymentList[index].status,
                                      activeStatusColor:
                                          Color(int.tryParse(colorCode)!),
                                    );
                                  })
                              : const NoDataAvailableWidget(),
                    ),
                  )),
              30.h.verticalSpacing,
            ],
          ),
        ),
      ),
    );
  }
}
