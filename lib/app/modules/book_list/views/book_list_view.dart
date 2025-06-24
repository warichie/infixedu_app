import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infixedu/app/data/constants/app_colors.dart';
import 'package:infixedu/app/utilities/extensions/widget.extensions.dart';
import 'package:infixedu/app/utilities/widgets/book_list_tile/book_list_tile.dart';
import 'package:infixedu/app/modules/book_list/views/widget/search_field.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:infixedu/app/utilities/widgets/loader/loading.widget.dart';
import 'package:infixedu/app/utilities/widgets/no_data_available/no_data_available_widget.dart';
import 'package:get/get.dart';
import '../../../data/constants/app_text_style.dart';
import '../controllers/book_list_controller.dart';

class BookListView extends GetView<BookListController> {
  const BookListView({super.key});

  @override
  Widget build(BuildContext context) {
    return InfixEduScaffold(
      title: "Book List".tr,
      body: CustomBackground(
        customWidget: Obx(
          () => RefreshIndicator(
            color: AppColors.primaryColor,
            onRefresh: () async {
              controller.bookListData.clear();
              controller.getAllBookList();
            },
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  10.w.verticalSpacing,
                  SearchField(
                    borderRadius: 2.0,
                    controller: controller.searchController,
                    onChange: (searchKey) {
                      controller.bookSearchList.clear();
                      controller.getSearchBook(searchKey);
                    },
                    hintTextStyle: AppTextStyle.fontSize10GreyW400,
                    icon: controller.searchController.text.isNotEmpty
                        ? InkWell(
                            onTap: () {
                              controller.searchController.clear();
                              controller.bookListData.clear();
                              controller.getAllBookList();
                            },
                            child: Icon(
                              Icons.close,
                              color: AppColors.profileDividerColor,
                              size: 16.w,
                            ),
                          )
                        : Icon(
                            Icons.search,
                            color: AppColors.profileDividerColor,
                            size: 16.w,
                          ),
                  ),
                  10.w.verticalSpacing,
                  Container(
                    height: 40.h,
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
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
                  controller.searchController.text.isEmpty
                      ? controller.loadingController.isLoading
                          ? SizedBox(
                              height: Get.height * 0.7,
                              child: const LoadingWidget())
                          : controller.bookListData.isNotEmpty
                              ? ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: controller.bookListData.length,
                                  itemBuilder: (context, index) {
                                    return BookListTile(
                                      bookName: controller
                                          .bookListData[index].bookTitle,
                                      subject: controller
                                          .bookListData[index].subject,
                                      bookNumber: controller
                                          .bookListData[index].bookNumber,
                                      onTap: () => controller
                                          .showBookListDetailsBottomSheet(
                                              index: index,
                                              bottomSheetBackgroundColor:
                                                  Colors.white),
                                      view: "Details".tr,
                                    );
                                  })
                              : const Center(child: NoDataAvailableWidget())
                      : controller.loadingController.isLoading
                          ? SizedBox(
                              height: Get.height * 0.7,
                              child: const LoadingWidget())
                          : controller.bookSearchList.isNotEmpty
                              ? ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: controller.bookSearchList.length,
                                  itemBuilder: (context, index) {
                                    return BookListTile(
                                      bookName: controller
                                          .bookSearchList[index].bookTitle,
                                      subject: controller
                                          .bookSearchList[index].subject,
                                      bookNumber: controller
                                          .bookSearchList[index].bookNumber,
                                      onTap: () => controller
                                          .showBookListDetailsBottomSheet(
                                              index: index,
                                              bottomSheetBackgroundColor:
                                                  Colors.white),
                                    );
                                  })
                              : Center(
                                  child: NoDataAvailableWidget(
                                    message:
                                        "${"No results for".tr} ${controller.searchController.text}",
                                  ),
                                ),
                  20.verticalSpacing,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
