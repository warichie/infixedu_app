import 'package:flutter/cupertino.dart';
import 'package:infixedu/app/data/constants/app_text.dart';
import 'package:infixedu/app/modules/admin_students_search/controllers/admin_students_search_controller.dart';
import 'package:infixedu/app/utilities/api_urls.dart';
import 'package:infixedu/app/utilities/message/snack_bars.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/alert_dialog.dart';
import 'package:infixedu/config/global_variable/global_variable_controller.dart';
import 'package:infixedu/domain/base_client/base_client.dart';
import 'package:infixedu/domain/core/model/admin/admin_fees_model/admin_fees_invoice_list_response_model.dart';
import 'package:get/get.dart';

class AdminFeesInvoiceListController extends GetxController {
  AdminStudentsSearchController adminStudentsSearchController =
      Get.put(AdminStudentsSearchController(searchInvoice: true));

  TextEditingController searchController = TextEditingController();

  RxBool isLoading = false.obs;
  RxBool searchLoader = false.obs;

  RxList<StudentInvoices> feesInvoiceList = <StudentInvoices>[].obs;
  RxString classNullValue = ''.obs;
  RxString sectionNullValue = ''.obs;

  Future<AdminFeesInvoiceListResponseModel> getFeesInvoiceList() async {
    try {
      feesInvoiceList.clear();
      isLoading.value = true;

      final response = await BaseClient().getData(
          url: InfixApi.getAdminFeesInvoiceList, header: GlobalVariable.header);

      AdminFeesInvoiceListResponseModel adminFeesInvoiceListResponseModel =
          AdminFeesInvoiceListResponseModel.fromJson(response);

      if (adminFeesInvoiceListResponseModel.success == true) {
        isLoading.value = false;

        if (adminFeesInvoiceListResponseModel
            .data!.studentInvoices!.isNotEmpty) {
          for (int i = 0;
              i <
                  adminFeesInvoiceListResponseModel
                      .data!.studentInvoices!.length;
              i++) {
            feesInvoiceList.add(
                adminFeesInvoiceListResponseModel.data!.studentInvoices![i]);
          }
        }
      } else {
        isLoading.value = false;
        showBasicFailedSnackBar(
            message: adminFeesInvoiceListResponseModel.message ??
                AppText.somethingWentWrong.tr);
      }
    } catch (e, t) {
      isLoading.value = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      isLoading.value = false;
    }

    return AdminFeesInvoiceListResponseModel();
  }

  Future<AdminFeesInvoiceListResponseModel> searchFeesInvoice(
      int classId, int sectionId, String studentName) async {
    try {
      feesInvoiceList.clear();
      searchLoader.value = true;

      final response = await BaseClient().getData(
          url: InfixApi.searchAdminFeesInvoice(
              classId: classId, sectionId: sectionId, studentName: studentName),
          header: GlobalVariable.header);

      AdminFeesInvoiceListResponseModel adminFeesInvoiceListResponseModel =
          AdminFeesInvoiceListResponseModel.fromJson(response);

      if (adminFeesInvoiceListResponseModel.success == true) {
        searchLoader.value = false;

        if (adminFeesInvoiceListResponseModel
            .data!.studentInvoices!.isNotEmpty) {
          for (int i = 0;
              i <
                  adminFeesInvoiceListResponseModel
                      .data!.studentInvoices!.length;
              i++) {
            feesInvoiceList.add(
                adminFeesInvoiceListResponseModel.data!.studentInvoices![i]);
          }
        }
      } else {
        searchLoader.value = false;
        showBasicFailedSnackBar(
            message: adminFeesInvoiceListResponseModel.message ??
                AppText.somethingWentWrong.tr);
      }
    } catch (e, t) {
      searchLoader.value = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      searchLoader.value = false;
    }

    return AdminFeesInvoiceListResponseModel();
  }

  void showAlertDialog() {
    Get.dialog(
      CustomPopupDialogue(
        subTitle: "${'Are you sure?'.tr}\n${'Want to delete?'.tr}",
        noText: 'Cancel'.tr,
        yesText: 'Delete'.tr,
        onYesTap: () {
          Get.back();
        },
      ),
    );
  }

  @override
  void onInit() {
    getFeesInvoiceList();
    super.onInit();
  }
}
