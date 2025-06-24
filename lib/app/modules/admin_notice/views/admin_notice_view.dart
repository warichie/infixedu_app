import 'package:flutter/material.dart';
import 'package:infixedu/app/data/constants/app_colors.dart';
import 'package:infixedu/app/utilities/extensions/widget.extensions.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:infixedu/app/utilities/widgets/loader/loading.widget.dart';
import 'package:infixedu/app/utilities/widgets/no_data_available/no_data_available_widget.dart';
import 'package:infixedu/app/utilities/widgets/notice_tile/notice_tile.dart';

import 'package:get/get.dart';

import '../controllers/admin_notice_controller.dart';

class AdminNoticeView extends GetView<AdminNoticeController> {
  const AdminNoticeView({super.key});

  @override
  Widget build(BuildContext context) {
    return InfixEduScaffold(
      title: "Notice".tr,
      body: CustomBackground(
        customWidget: RefreshIndicator(
          color: AppColors.primaryColor,
          onRefresh: () async {
            controller.getAdminStaffNotice();
          },
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Obx(
                  () => controller.loadingController.isLoading
                      ? SizedBox(
                          height: Get.height, child: const LoadingWidget())
                      : controller.adminStaffNoticeList.isNotEmpty
                          ? ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: controller.adminStaffNoticeList.length,
                              itemBuilder: (context, index) {
                                return NoticeTile(
                                  noticeTitle: controller
                                      .adminStaffNoticeList[index].noticeTitle,
                                  noticeDetails: controller
                                      .adminStaffNoticeList[index]
                                      .noticeMessage,
                                  noticeDate: controller
                                      .adminStaffNoticeList[index].noticeDate,
                                  cardBackgroundColor: Colors.white,
                                  onTap: () {
                                    controller.showNoticeDetailsBottomSheet(
                                      index: index,
                                      bottomSheetBackgroundColor: Colors.white,
                                    );
                                  },
                                );
                              },
                            )
                          : const Center(
                              child: NoDataAvailableWidget(),
                            ),
                ),
                50.verticalSpacing,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
