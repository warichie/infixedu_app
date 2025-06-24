import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infixedu/app/data/constants/app_colors.dart';
import 'package:infixedu/app/data/constants/app_text_style.dart';
import 'package:infixedu/app/utilities/widgets/book_list_tile/book_list_tile.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:infixedu/app/utilities/widgets/no_data_available/no_data_available_widget.dart';

import 'package:get/get.dart';

import '../controllers/admin_book_list_controller.dart';

class AdminBookListView extends GetView<AdminBookListController> {
  const AdminBookListView({super.key});

  @override
  Widget build(BuildContext context) {
    return InfixEduScaffold(
      title: "Book List".tr,
      body: CustomBackground(
        customWidget: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 40.h,
              padding: const EdgeInsets.symmetric(
                horizontal: 11,
              ),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(8),
                  topLeft: Radius.circular(8),
                ),
                color: AppColors.profileCardBackgroundColor,
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: Get.width * 0.12,
                    child: Text(
                      "Book No".tr,
                      style: AppTextStyle.textStyle10WhiteW400,
                    ),
                  ),
                  const VerticalDivider(
                    color: AppColors.profileTitleColor,
                    thickness: 1,
                  ),
                  Container(
                    width: Get.width * 0.2,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      "Subject".tr,
                      style: AppTextStyle.textStyle10WhiteW400,
                    ),
                  ),
                  const VerticalDivider(
                    color: AppColors.profileTitleColor,
                    thickness: 1,
                  ),
                  Text(
                    "Book Name".tr,
                    style: AppTextStyle.textStyle10WhiteW400,
                  )
                ],
              ),
            ),
            Obx(
              () => Expanded(
                child: controller.loadingController.isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primaryColor,
                        ),
                      )
                    : controller.bookList.isNotEmpty
                        ? RefreshIndicator(
                            color: AppColors.primaryColor,
                            onRefresh: () async {
                              controller.bookList.clear();
                              controller.getAdminBookList();
                            },
                            child: ListView.builder(
                              shrinkWrap: true,
                              padding: EdgeInsets.symmetric(horizontal: 5.w),
                              itemCount: controller.bookList.length,
                              itemBuilder: (context, index) {
                                return BookListTile(
                                  bookName:
                                      controller.bookList[index].bookTitle,
                                  subject:
                                      controller.bookList[index].subjectName,
                                  bookNumber:
                                      controller.bookList[index].bookNumber,
                                  onTap: () {
                                    controller.showBookListDetailsBottomSheet(
                                      index: index,
                                      bottomSheetBackgroundColor: Colors.white,
                                    );
                                  },
                                );
                              },
                            ),
                          )
                        : const Center(
                            child: NoDataAvailableWidget(),
                          ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
