import 'package:flutter/material.dart';
import 'package:infixedu/app/data/constants/app_colors.dart';
import 'package:infixedu/app/data/constants/app_text.dart';
import 'package:infixedu/app/style/bottom_sheet/bottom_sheet_shpe.dart';
import 'package:infixedu/app/utilities/api_urls.dart';
import 'package:infixedu/app/utilities/extensions/widget.extensions.dart';
import 'package:infixedu/app/utilities/message/snack_bars.dart';
import 'package:infixedu/app/utilities/widgets/bottom_sheet_tile/bottom_sheet_tile.dart';
import 'package:infixedu/app/utilities/widgets/loader/loading.controller.dart';
import 'package:infixedu/config/global_variable/global_variable_controller.dart';
import 'package:infixedu/domain/base_client/base_client.dart';
import 'package:infixedu/domain/core/model/student/student_library_model/student_isssued_book_list_response_model.dart';
import 'package:get/get.dart';

import '../../../data/constants/app_text_style.dart';

class BookIssuedController extends GetxController {
  LoadingController loadingController = Get.find();
  GlobalRxVariableController globalRxVariableController = Get.find();

  RxList<StudentIssuedBookData> studentIssuedBookList =
      <StudentIssuedBookData>[].obs;
  RxBool isMembershipAvailable = false.obs;
  RxString memberShipMessage = ''.obs;

  Future<StudentIssuedBookListResponseModel> getIssuedBookList(
      {required int studentId}) async {
    try {
      studentIssuedBookList.clear();
      loadingController.isLoading = true;

      final response = await BaseClient().getData(
          url: InfixApi.getStudentIssuedBookList(studentId: studentId),
          header: GlobalVariable.header);

      StudentIssuedBookListResponseModel studentIssuedBookListResponseModel =
          StudentIssuedBookListResponseModel.fromJson(response);

      if (studentIssuedBookListResponseModel.success == true) {
        loadingController.isLoading = false;

        if (studentIssuedBookListResponseModel.data!.isNotEmpty) {
          for (var element in studentIssuedBookListResponseModel.data!) {
            studentIssuedBookList.add(element);
          }
        }

        // showBasicSuccessSnackBar(
        //     message: studentIssuedBookListResponseModel.message ?? '');
      } else {
        loadingController.isLoading = false;
        if (studentIssuedBookListResponseModel.message!.contains(
            'You are not library member ! Please contact with librarian')) {
          isMembershipAvailable.value = true;
          memberShipMessage.value =
              studentIssuedBookListResponseModel.message ??
                  'You are not library member, Please contact with librarian';
        }
        showBasicFailedSnackBar(
          message: studentIssuedBookListResponseModel.message ??
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

    return StudentIssuedBookListResponseModel();
  }

  void showBookListDetailsBottomSheet(
      {required int index, Color? bottomSheetBackgroundColor}) {
    Get.bottomSheet(
      Container(
        height: Get.height * 0.55,
        color: bottomSheetBackgroundColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            10.verticalSpacing,
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "${"Title".tr} : ${studentIssuedBookList[index].bookTitle}",
                style: AppTextStyle.fontSize14BlackW500,
              ),
            ),
            BottomSheetTile(
              title: "Issued Date".tr,
              value: studentIssuedBookList[index].issueDate,
              color: AppColors.homeworkWidgetColor,
            ),
            BottomSheetTile(
              title: "Return date".tr,
              value: studentIssuedBookList[index].returnDate,
              color: Colors.white,
            ),
            BottomSheetTile(
              title: "Author name".tr,
              value: studentIssuedBookList[index].authorName,
              color: AppColors.homeworkWidgetColor,
            ),
            BottomSheetTile(
              title: "Status".tr,
              value: studentIssuedBookList[index].status,
              color: Colors.white,
            ),
          ],
        ),
      ),
      shape: defaultBottomSheetShape(),
    );
  }

  @override
  void onInit() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getIssuedBookList(
        studentId: globalRxVariableController.studentId.value!,
      );
    });

    super.onInit();
  }
}
