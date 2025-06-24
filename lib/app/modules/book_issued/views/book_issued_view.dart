import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infixedu/app/data/constants/app_colors.dart';
import 'package:infixedu/app/data/constants/app_text_style.dart';
import 'package:infixedu/app/utilities/widgets/book_list_tile/book_list_tile.dart';
import 'package:infixedu/app/utilities/extensions/widget.extensions.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:infixedu/app/utilities/widgets/loader/loading.widget.dart';
import 'package:infixedu/app/utilities/widgets/no_data_available/no_data_available_widget.dart';

import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../controllers/book_issued_controller.dart';

class BookIssuedView extends GetView<BookIssuedController> {
  const BookIssuedView({super.key});

  @override
  Widget build(BuildContext context) {
    return InfixEduScaffold(
      title: "Book Issued".tr,
      body: SingleChildScrollView(
        child: CustomBackground(
          customWidget: Column(
            children: [
              Container(
                height: 40.h,
                padding: EdgeInsets.symmetric(
                  horizontal: 11.w,
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
                        style: AppTextStyle.textStyle12WhiteW500,
                      ),
                    ),
                    const VerticalDivider(
                      color: AppColors.profileTitleColor,
                      thickness: 1,
                    ),
                    Text(
                      "Book Name".tr,
                      style: AppTextStyle.textStyle12WhiteW500,
                    )
                  ],
                ),
              ),
              10.w.verticalSpacing,
              Obx(
                () => controller.loadingController.isLoading
                    ? const Expanded(
                        child: LoadingWidget(),
                      )
                    : controller.isMembershipAvailable.value == true
                        ? Padding(
                            padding: const EdgeInsets.only(top: 78.0),
                            child: Container(
                              //height: 113.h,
                              width: 320.w,
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                  color: const Color(0xFFFDE8E8),
                                  borderRadius: 8.circularRadius),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Iconsax.info_circle5,
                                        color: Color(0xFFC81E1E),
                                        size: 18.w,
                                      ),
                                      5.w.horizontalSpacing,
                                      Text(
                                        'Alert'.tr,
                                        style: AppTextStyle
                                            .chatTextStyle16ColorC81E1EW600,
                                      ),
                                    ],
                                  ),
                                  Text(
                                    controller.memberShipMessage.value.tr,
                                    style: AppTextStyle
                                        .chatTextStyle14ColorC81E1EW400,
                                  )
                                ],
                              ),
                            ),
                          )
                        : Expanded(
                            child: controller.studentIssuedBookList.isEmpty
                                ? const NoDataAvailableWidget()
                                : ListView.builder(
                                    padding: EdgeInsets.all(5.w),
                                    itemCount:
                                        controller.studentIssuedBookList.length,
                                    itemBuilder: (context, index) {
                                      return BookListTile(
                                        bookNumber: controller
                                            .studentIssuedBookList[index]
                                            .bookNumber,
                                        bookName: controller
                                            .studentIssuedBookList[index]
                                            .bookTitle,
                                        subject: controller
                                            .studentIssuedBookList[index]
                                            .subject,
                                        view: "Details".tr,
                                        onTap: () => controller
                                            .showBookListDetailsBottomSheet(
                                          index: index,
                                          bottomSheetBackgroundColor:
                                              Colors.white,
                                        ),
                                      );
                                    },
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
