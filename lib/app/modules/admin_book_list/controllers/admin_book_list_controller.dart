import 'package:flutter/material.dart';
import 'package:infixedu/app/data/constants/app_colors.dart';
import 'package:infixedu/app/data/constants/app_text.dart';
import 'package:infixedu/app/data/constants/app_text_style.dart';
import 'package:infixedu/app/style/bottom_sheet/bottom_sheet_shpe.dart';
import 'package:infixedu/app/utilities/api_urls.dart';
import 'package:infixedu/app/utilities/extensions/widget.extensions.dart';
import 'package:infixedu/app/utilities/message/snack_bars.dart';
import 'package:infixedu/app/utilities/widgets/bottom_sheet_tile/bottom_sheet_tile.dart';
import 'package:infixedu/app/utilities/widgets/loader/loading.controller.dart';
import 'package:infixedu/config/global_variable/global_variable_controller.dart';
import 'package:infixedu/domain/base_client/base_client.dart';
import 'package:infixedu/domain/core/model/admin/admin_library_model/admin_book_list_response_model.dart';
import 'package:get/get.dart';

class AdminBookListController extends GetxController {
  GlobalRxVariableController globalRxVariableController = Get.find();
  LoadingController loadingController = Get.find();

  List<AdminBookData> bookList = <AdminBookData>[].obs;

  Future<AdminBookListResponseModel> getAdminBookList() async {
    try {
      bookList.clear();
      loadingController.isLoading = true;

      final response = await BaseClient().getData(
          url: globalRxVariableController.roleId.value == 4
              ? InfixApi.getTeacherBookList
              : InfixApi.getAdminBookList,
          header: GlobalVariable.header);

      AdminBookListResponseModel adminBookListResponseModel =
          AdminBookListResponseModel.fromJson(response);

      if (adminBookListResponseModel.success == true) {
        loadingController.isLoading = false;
        if (adminBookListResponseModel.data!.isNotEmpty) {
          for (int i = 0; i < adminBookListResponseModel.data!.length; i++) {
            bookList.add(adminBookListResponseModel.data![i]);
          }
        }
      } else {
        loadingController.isLoading = false;
        showBasicFailedSnackBar(
          message: adminBookListResponseModel.message ??
              AppText.somethingWentWrong.tr,
        );
      }
    } catch (e, t) {
      loadingController.isLoading = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      loadingController.isLoading = false;
    }

    return AdminBookListResponseModel();
  }

  void showBookListDetailsBottomSheet(
      {required int index, Color? bottomSheetBackgroundColor}) {
    Get.bottomSheet(
      Container(
          height: Get.height * 0.55,
          color: bottomSheetBackgroundColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              10.verticalSpacing,
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  bookList[index].bookTitle ?? '',
                  style: AppTextStyle.fontSize14BlackW500,
                ),
              ),
              BottomSheetTile(
                title: "Book No".tr,
                value: bookList[index].bookNumber ?? '',
                color: AppColors.homeworkWidgetColor,
              ),
              BottomSheetTile(
                title: "Subject".tr,
                value: bookList[index].subjectName,
                color: Colors.white,
              ),
              BottomSheetTile(
                title: "Publisher name".tr,
                value: bookList[index].publisherName,
                color: AppColors.homeworkWidgetColor,
              ),
              BottomSheetTile(
                title: "Author Name".tr,
                value: bookList[index].authorName,
                color: Colors.white,
              ),
              BottomSheetTile(
                title: "Quantity".tr,
                value: bookList[index].quantity == null
                    ? '_'
                    : bookList[index].quantity.toString(),
                color: AppColors.homeworkWidgetColor,
              ),
              BottomSheetTile(
                title: "Price".tr,
                value: bookList[index].bookPrice == null
                    ? '_'
                    : bookList[index].bookPrice.toString(),
                color: Colors.white,
              ),
            ],
          )),
      shape: defaultBottomSheetShape(),
    );
  }

  @override
  void onInit() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getAdminBookList();
    });
    super.onInit();
  }
}
