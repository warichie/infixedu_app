import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infixedu/app/data/constants/app_colors.dart';
import 'package:infixedu/app/data/constants/app_text_style.dart';
import 'package:infixedu/app/data/constants/image_path.dart';
import 'package:infixedu/app/modules/bank_payment_list/views/widget/bank_payment_tile.dart';
import 'package:infixedu/app/utilities/extensions/widget.extensions.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/duplicate_dropdown.dart';
import 'package:infixedu/app/utilities/widgets/customised_loading_widget/customised_loading_widget.dart';
import 'package:infixedu/app/utilities/widgets/no_data_available/no_data_available_widget.dart';

import 'package:get/get.dart';

import '../controllers/bank_payment_list_controller.dart';

class BankPaymentListView extends GetView<BankPaymentListController> {
  const BankPaymentListView({super.key});

  Future<bool> showConfirmationDialog(
      BuildContext context, String action) async {
    return await showDialog<bool>(
          context: context,
          barrierDismissible:
              false, // Prevent closing the dialog by tapping outside
          builder: (context) => AlertDialog(
            title: Text(
              "Are you sure?".tr,
              style: AppTextStyle.blackFontSize14W400,
            ),
            content: Text(
              "${"Do you want to".tr} $action ${"this transaction".tr}?",
              style: AppTextStyle.fontSize12GreyW400,
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context)
                    .pop(false), // Return false if "Cancel" is pressed
                child: Text(
                  "Cancel".tr,
                  style: AppTextStyle.blackFontSize14W400,
                ),
              ),
              TextButton(
                onPressed: () => Navigator.of(context)
                    .pop(true), // Return true if "Confirm" is pressed
                child: Text(
                  "Confirm".tr,
                  style: AppTextStyle.blackFontSize14W400,
                ),
              ),
            ],
          ),
        ) ??
        false; // Default to false if the dialog is dismissed
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: controller.status.length,
      child: Obx(
        () => InfixEduScaffold(
          title: "Bank Payment".tr,
          body: CustomBackground(
            customWidget: Column(
              children: [
                20.verticalSpacing,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    children: [
                      SizedBox(
                        width: Get.width * 0.48,
                        height: Get.height * 0.04,
                        child: TextFormField(
                          onTap: () {
                            controller.pickDateRange(context: context);
                          },
                          controller: controller.selectedDateTextController,
                          readOnly: true,
                          style: TextStyle(
                            color: Color(0xFF3E4347),
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w400,
                          ),
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(left: 10),
                            hintText: "${"Select Date".tr} *",
                            filled: true,
                            fillColor: const Color(0xFFFDFBFF),
                            suffixIcon: Image.asset(
                              ImagePath.calender,
                              width: 16.w,
                              height: 16.w,
                              //fit: BoxFit.contain,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: const Color(0xFF635976).withOpacity(0.2),
                              ),
                              borderRadius: BorderRadius.circular(2.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: const Color(0xFF635976).withOpacity(0.2),
                              ),
                              borderRadius: BorderRadius.circular(2.0),
                            ),
                          ),
                        ),
                      ),
                      5.horizontalSpacing,

                      /// Class Dropdown
                      controller.adminStudentsSearchController.loadingController
                              .isLoading
                          ? const CircularProgressIndicator()
                          : SizedBox(
                              width: Get.width * 0.18,
                              height: Get.height * 0.04,
                              child: DuplicateDropdown(
                                sidePadding: 0,
                                borderRadius: 2,
                                padding: const EdgeInsets.only(left: 10),
                                textStyle: AppTextStyle.blackFontSize10W400,
                                dropdownValue: controller
                                        .adminStudentsSearchController
                                        .classList
                                        .isEmpty
                                    ? controller.classNullValue.value
                                    : controller.adminStudentsSearchController
                                        .classValue.value,
                                dropdownList: controller
                                    .adminStudentsSearchController.classList,
                                changeDropdownValue: (v) {
                                  controller.pendingList.clear();
                                  controller.approveList.clear();
                                  controller.rejectList.clear();
                                  controller.adminStudentsSearchController
                                      .classValue.value = v!;
                                  controller.classId.value = v.id;
                                  controller.adminStudentsSearchController
                                      .getStudentSectionList(classId: v.id);
                                  // controller.getAllBankPaymentList(
                                  //     startDate: controller.startDate.value,
                                  //     endDate: controller.endDate.value,
                                  //     classId: controller.classId.value,
                                  //     sectionId: controller.sectionId.value);
                                },
                              ),
                            ),
                      5.horizontalSpacing,

                      /// Section Dropdown
                      controller
                              .adminStudentsSearchController.sectionLoader.value
                          ? const CircularProgressIndicator(
                              color: AppColors.primaryColor,
                            )
                          : SizedBox(
                              width: Get.width * 0.18,
                              height: Get.height * 0.04,
                              child: DuplicateDropdown(
                                sidePadding: 0,
                                borderRadius: 2,
                                padding: const EdgeInsets.only(left: 10),
                                textStyle: AppTextStyle.blackFontSize10W400,
                                dropdownValue: controller
                                        .adminStudentsSearchController
                                        .sectionList
                                        .isEmpty
                                    ? controller.sectionNullValue.value
                                    : controller.adminStudentsSearchController
                                        .sectionValue.value,
                                dropdownList: controller
                                    .adminStudentsSearchController.sectionList,
                                changeDropdownValue: (v) {
                                  controller.pendingList.clear();
                                  controller.approveList.clear();
                                  controller.rejectList.clear();
                                  controller.sectionId.value = v.id;
                                  controller.adminStudentsSearchController
                                      .sectionValue.value = v!;
                                  controller.getAllBankPaymentList(
                                      startDate: controller.startDate.value,
                                      endDate: controller.endDate.value,
                                      classId: controller.classId.value,
                                      sectionId: controller.sectionId.value);
                                },
                              ),
                            ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: TabBar(
                    labelColor: AppColors.profileValueColor,
                    indicatorSize: TabBarIndicatorSize.tab,
                    dividerHeight: 0,
                    unselectedLabelColor: Colors.black,
                    unselectedLabelStyle: AppTextStyle.fontSize12LightGreyW500,
                    labelStyle: AppTextStyle.fontSize12LightGreyW500,
                    indicatorColor: AppColors.profileIndicatorColor,
                    controller: controller.tabController,
                    tabs: List.generate(
                      controller.status.length,
                      (index) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          controller.status[index].tr,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: TabBarView(children: [
                    /// Pending List
                    controller.isLoading.value
                        ? const SecondaryLoadingWidget()
                        : controller.pendingList.isNotEmpty
                            ? RefreshIndicator(
                                onRefresh: () async {
                                  controller.pendingList.clear();
                                  controller.approveList.clear();
                                  controller.rejectList.clear();

                                  controller.getAllBankPaymentList(
                                    startDate: controller.startDate.value,
                                    endDate: controller.endDate.value,
                                    classId: controller.classId.value,
                                    sectionId: controller.sectionId.value,
                                  );
                                },
                                child: ListView.builder(
                                    itemCount: controller.pendingList.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: BankPaymentTile(
                                          studentName: controller
                                              .pendingList[index].studentName,
                                          date: controller
                                              .pendingList[index].date,
                                          amount: controller
                                              .pendingList[index].amount
                                              .toString(),
                                          status: controller
                                              .pendingList[index].status,
                                          currency: controller
                                              .appSettingsController
                                              .currencyDetail!
                                              .symbol,
                                          statusColor:
                                              AppColors.activeStatusYellowColor,
                                          onTapDetails: () {
                                            controller.showDetailsBottomSheet(
                                                index: index,
                                                studentName: controller
                                                        .pendingList[index]
                                                        .studentName ??
                                                    "",
                                                // feesType: controller.pendingList[index].viewTransaction?.feesType ?? "",
                                                // paidAmount: controller.pendingList[index].viewTransaction?.paidAmount ?? 0,
                                                feesType: controller
                                                        .pendingList[index]
                                                        .feesType ??
                                                    '',
                                                paidAmount: controller
                                                        .pendingList[index]
                                                        .amount ??
                                                    0,
                                                date: controller
                                                        .pendingList[index]
                                                        .date ??
                                                    "",
                                                note: controller
                                                        .pendingList[index]
                                                        .note ??
                                                    "",
                                                file: controller
                                                        .pendingList[index]
                                                        .file ??
                                                    "");
                                          },
                                          onTapApprove: () async {
                                            bool confirm =
                                                await showConfirmationDialog(
                                                    context, "Approve".tr);
                                            if (confirm) {
                                              controller
                                                  .bankPaymentStatusUpdate(
                                                transactionId: controller
                                                    .pendingList[index]
                                                    .transactionId
                                                    .toString(),
                                                status: "approve",
                                                index: index,
                                                updatedStatus: controller
                                                        .pendingList[index]
                                                        .status ??
                                                    "",
                                              );
                                            }
                                          },
                                          onTapReject: () async {
                                            bool confirm =
                                                await showConfirmationDialog(
                                                    context, "Reject".tr);
                                            if (confirm) {
                                              controller
                                                  .bankPaymentStatusUpdate(
                                                transactionId: controller
                                                    .pendingList[index]
                                                    .transactionId
                                                    .toString(),
                                                status: "reject",
                                                index: index,
                                                updatedStatus: controller
                                                        .pendingList[index]
                                                        .status ??
                                                    "",
                                              );
                                            }
                                          },
                                          isPending: controller
                                              .pendingList[index].status,
                                          color: Colors.white,
                                        ),
                                      );
                                    }),
                              )
                            : const SingleChildScrollView(
                                child: NoDataAvailableWidget(),
                              ),

                    /// Approve List
                    controller.isLoading.value
                        ? const SecondaryLoadingWidget()
                        : controller.approveList.isNotEmpty
                            ? RefreshIndicator(
                                onRefresh: () async {
                                  controller.approveList.clear();
                                  controller.getAllBankPaymentList(
                                    startDate: controller.startDate.value,
                                    endDate: controller.endDate.value,
                                    classId: controller.classId.value,
                                    sectionId: controller.sectionId.value,
                                  );
                                },
                                child: ListView.builder(
                                    itemCount: controller.approveList.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: BankPaymentTile(
                                          studentName: controller
                                              .approveList[index].studentName,
                                          date: controller
                                              .approveList[index].date,
                                          amount: controller
                                              .approveList[index].amount
                                              .toString(),
                                          status: controller
                                              .approveList[index].status,
                                          isApproved: true,
                                          currency: "\$",
                                          statusColor:
                                              AppColors.activeStatusGreenColor,
                                          onTapDetails: () {
                                            controller.showDetailsBottomSheet(
                                                index: index,
                                                studentName: controller
                                                        .approveList[index]
                                                        .studentName ??
                                                    "",
                                                feesType: controller
                                                        .approveList[index]
                                                        .feesType ??
                                                    '',
                                                paidAmount: controller
                                                        .approveList[index]
                                                        .amount ??
                                                    0,
                                                date: controller
                                                        .approveList[index]
                                                        .date ??
                                                    "",
                                                note: controller
                                                        .approveList[index]
                                                        .note ??
                                                    "",
                                                file: controller
                                                        .approveList[index]
                                                        .file ??
                                                    "");
                                          },
                                          onTapReject: () {
                                            controller.bankPaymentStatusUpdate(
                                              transactionId: controller
                                                  .approveList[index]
                                                  .transactionId
                                                  .toString(),
                                              status: "reject",
                                              index: index,
                                              updatedStatus: controller
                                                      .approveList[index]
                                                      .status ??
                                                  "",
                                            );
                                          },
                                          isPending: controller
                                              .approveList[index].status,
                                          color: Colors.white,
                                        ),
                                      );
                                    }),
                              )
                            : const SingleChildScrollView(
                                child: NoDataAvailableWidget(),
                              ),

                    /// Reject List
                    controller.isLoading.value
                        ? const SecondaryLoadingWidget()
                        : controller.rejectList.isNotEmpty
                            ? RefreshIndicator(
                                onRefresh: () async {
                                  controller.rejectList.clear();
                                  controller.getAllBankPaymentList(
                                    startDate: controller.startDate.value,
                                    endDate: controller.endDate.value,
                                    classId: controller.classId.value,
                                    sectionId: controller.sectionId.value,
                                  );
                                },
                                child: ListView.builder(
                                    itemCount: controller.rejectList.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: BankPaymentTile(
                                          studentName: controller
                                              .rejectList[index].studentName,
                                          date:
                                              controller.rejectList[index].date,
                                          amount: controller
                                              .rejectList[index].amount
                                              .toString(),
                                          status: controller
                                              .rejectList[index].status,
                                          currency: "\$",
                                          statusColor:
                                              AppColors.activeStatusRedColor,
                                          isRejected: true,
                                          onTapDetails: () {
                                            controller.showDetailsBottomSheet(
                                                index: index,
                                                studentName: controller
                                                        .rejectList[index]
                                                        .studentName ??
                                                    "",
                                                feesType: controller
                                                        .rejectList[index]
                                                        .feesType ??
                                                    '',
                                                paidAmount: controller
                                                        .rejectList[index]
                                                        .amount ??
                                                    0,
                                                date: controller
                                                        .rejectList[index]
                                                        .date ??
                                                    "",
                                                note: controller
                                                        .rejectList[index]
                                                        .note ??
                                                    "",
                                                file: controller
                                                        .rejectList[index]
                                                        .file ??
                                                    "");
                                          },
                                          onTapApprove: () {
                                            controller.bankPaymentStatusUpdate(
                                              index: index,
                                              transactionId: controller
                                                  .rejectList[index]
                                                  .transactionId
                                                  .toString(),
                                              status: "approve",
                                              updatedStatus: controller
                                                      .rejectList[index]
                                                      .status ??
                                                  "",
                                            );
                                          },
                                          isPending: controller
                                              .rejectList[index].status,
                                          color: Colors.white,
                                        ),
                                      );
                                    }),
                              )
                            : const SingleChildScrollView(
                                child: NoDataAvailableWidget(),
                              ),
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
