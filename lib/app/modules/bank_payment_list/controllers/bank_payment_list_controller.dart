import 'package:flutter/material.dart';
import 'package:infixedu/app/data/constants/app_colors.dart';
import 'package:infixedu/app/data/constants/app_text.dart';
import 'package:infixedu/app/data/constants/app_text_style.dart';
import 'package:infixedu/app/modules/admin_students_search/controllers/admin_students_search_controller.dart';
import 'package:infixedu/app/style/bottom_sheet/bottom_sheet_shpe.dart';
import 'package:infixedu/app/utilities/api_urls.dart';
import 'package:infixedu/app/utilities/extensions/widget.extensions.dart';
import 'package:infixedu/app/utilities/file_downloader/file_download_utils.dart';
import 'package:infixedu/app/utilities/message/snack_bars.dart';
import 'package:infixedu/app/utilities/widgets/bottom_sheet_tile/bottom_sheet_tile.dart';
import 'package:infixedu/config/app_config.dart';
import 'package:infixedu/config/global_variable/app_settings_controller.dart';
import 'package:infixedu/config/global_variable/global_variable_controller.dart';
import 'package:infixedu/domain/base_client/base_client.dart';
import 'package:infixedu/domain/core/model/admin/admin_fees_model/bank_payment_list_response_model.dart';
import 'package:infixedu/domain/core/model/post_request_response_model.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as path;

class BankPaymentListController extends GetxController {
  AppSettingsController appSettingsController =
      Get.put(AppSettingsController());
  AdminStudentsSearchController adminStudentsSearchController =
      Get.put(AdminStudentsSearchController());

  // text: DateFormat('MM-dd-yyyy').format(DateTime.now()).toString());

  RxList<ApproveList> approveList = <ApproveList>[].obs;
  RxList<PendingList> pendingList = <PendingList>[].obs;
  RxList<RejectedList> rejectList = <RejectedList>[].obs;
  RxBool isLoading = false.obs;
  RxBool statusUpdateLoaded = false.obs;
  RxString classNullValue = ''.obs;
  RxString sectionNullValue = ''.obs;
  RxString startDate = DateTime.now()
      .subtract(const Duration(days: 1))
      .dd_mm_yyyy_new
      .toString()
      .obs;
  RxString startDateForUI = "".obs;
  RxString endDate = DateTime.now().dd_mm_yyyy_new.toString().obs;
  RxString endDateForUI = "".obs;

  TextEditingController selectedDateTextController = TextEditingController(
      text:
          '${DateTime.now().subtract(const Duration(days: 1)).dd_mm_yyyy_new} - ${DateTime.now().dd_mm_yyyy_new.toString()}');

  RxInt classId = 0.obs;
  RxInt sectionId = 0.obs;

  TabController? tabController;

  List<String> status = <String>[
    'Pending',
    'Approved',
    'Rejected',
  ];

  DateTimeRange dateRange = DateTimeRange(
    start: DateTime(2024, 1, 5),
    end: DateTime(2025, 12, 10),
  );

  Future<BankPaymentListResponseModel?> getAllBankPaymentList(
      {required String startDate,
      required String endDate,
      required int classId,
      required int sectionId}) async {
    try {
      isLoading.value = true;

      final response = await BaseClient().getData(
        url: InfixApi.getBankPaymentList(
            startDate: startDate,
            endDate: endDate,
            classId: classId,
            sectionId: sectionId),
        header: GlobalVariable.header,
      );

      BankPaymentListResponseModel bankPaymentListResponseModel =
          BankPaymentListResponseModel.fromJson(response);
      if (bankPaymentListResponseModel.success == true) {
        isLoading.value = false;
        if (bankPaymentListResponseModel.data!.approve!.isNotEmpty) {
          for (int i = 0;
              i < bankPaymentListResponseModel.data!.approve!.length;
              i++) {
            approveList.add(bankPaymentListResponseModel.data!.approve![i]);
          }
        }
        if (bankPaymentListResponseModel.data!.pending!.isNotEmpty) {
          for (int i = 0;
              i < bankPaymentListResponseModel.data!.pending!.length;
              i++) {
            pendingList.add(bankPaymentListResponseModel.data!.pending![i]);
          }
        }
        if (bankPaymentListResponseModel.data!.reject!.isNotEmpty) {
          for (int i = 0;
              i < bankPaymentListResponseModel.data!.reject!.length;
              i++) {
            rejectList.add(bankPaymentListResponseModel.data!.reject![i]);
          }
        }
      }
    } catch (e, t) {
      isLoading.value = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      isLoading.value = false;
    }
    return BankPaymentListResponseModel();
  }

  Future<void> bankPaymentStatusUpdate(
      {required String transactionId,
      required String status,
      required int index,
      required String updatedStatus}) async {
    try {
      statusUpdateLoaded.value = true;

      final response = await BaseClient().postData(
        url: InfixApi.getBankPaymentStatusUpdate,
        header: GlobalVariable.header,
        payload: {
          "change_status": status,
          "transaction_id": transactionId,
        },
      );

      PostRequestResponseModel postRequestResponseModel =
          PostRequestResponseModel.fromJson(response);

      if (postRequestResponseModel.success == true) {
        statusUpdateLoaded.value = false;
        // if (updatedStatus == "PENDING") {
        //   pendingList.removeAt(index);
        //   pendingList.refresh();
        //   if (status == "reject") {
        //     rejectList.add(RejectedList(
        //       studentName: approveList[index].studentName,
        //     ));
        //   }
        // }

        // if (updatedStatus == "APPROVE") {
        //   approveList.removeAt(index);
        //   approveList.refresh();
        //   rejectList.add(RejectedList(
        //     studentName: approveList[index].studentName,
        //     amount: approveList[index].amount,
        //     file: approveList[index].file,
        //     date: approveList[index].date,
        //     status: "REJECT",
        //   ));
        // }

        // if (updatedStatus == "REJECT") {
        //   rejectList.removeAt(index);
        //   rejectList.refresh();
        //   approveList.add(ApproveList(
        //     studentName: rejectList[index].studentName,
        //     amount: rejectList[index].amount,
        //     file: rejectList[index].file,
        //     date: rejectList[index].date,
        //     status: "APPROVE",
        //   ));
        // }
        showBasicSuccessSnackBar(
            message: postRequestResponseModel.message ?? '');
        pendingList.clear();
        approveList.clear();
        rejectList.clear();

        await getAllBankPaymentList(
          startDate: startDate.value,
          endDate: endDate.value,
          classId: classId.value,
          sectionId: sectionId.value,
        );
        pendingList.refresh();
        rejectList.refresh();
        approveList.refresh();
      } else {
        statusUpdateLoaded.value = false;
        showBasicFailedSnackBar(
          message:
              postRequestResponseModel.message ?? AppText.somethingWentWrong.tr,
        );
      }
    } catch (e, t) {
      statusUpdateLoaded.value = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      statusUpdateLoaded.value = false;
    }
  }

  void showDetailsBottomSheet({
    required int index,
    required String studentName,
    required String feesType,
    required int paidAmount,
    required String date,
    required String note,
    required String file,
  }) {
    Get.bottomSheet(
      Container(
          padding: const EdgeInsets.all(20),
          height: Get.height * 0.45,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              10.verticalSpacing,
              Text(
                studentName,
                style: AppTextStyle.fontSize14BlackW500,
              ),
              20.verticalSpacing,
              BottomSheetTile(
                title: "Date".tr,
                value: date,
                color: AppColors.homeworkWidgetColor,
              ),
              BottomSheetTile(
                title: "Fees Type".tr,
                value: feesType,
              ),
              BottomSheetTile(
                title: "Paid Amount".tr,
                value: paidAmount.toString(),
                color: AppColors.homeworkWidgetColor,
              ),
              BottomSheetTile(
                title: "Note".tr,
                value: note,
              ),
              if (file.isNotEmpty)
                GestureDetector(
                  onTap: () {
                    Uri uri = Uri.parse(file);
                    String fileName = path.basename(uri.path);

                    FileDownloadUtils().downloadFiles(
                        url: file,
                        title: '$fileName${AppConfig.getExtension(file)}');
                  },
                  child: BottomSheetTile(
                    title: "File".tr,
                    value: "Click to download".tr,
                    color: AppColors.homeworkWidgetColor,
                  ),
                ),
            ],
          )),
      backgroundColor: Colors.white,
      shape: defaultBottomSheetShape(),
    );
  }

  Future pickDateRange({required BuildContext context}) async {
    DateTimeRange? newDateRange = await showDateRangePicker(
      context: context,
      initialDateRange: dateRange,
      firstDate: DateTime(2024),
      lastDate: DateTime(2026),
    ).then((value) {
      startDate.value =
          DateFormat('MM-dd-yyyy').format(value?.start ?? DateTime.now());
      endDate.value =
          DateFormat('MM-dd-yyyy').format(value?.end ?? DateTime.now());
      startDateForUI.value =
          DateFormat('dd/MM/yyyy').format(value?.start ?? DateTime.now());
      endDateForUI.value =
          DateFormat('dd/MM/yyyy').format(value?.end ?? DateTime.now());
      pendingList.clear();
      approveList.clear();
      rejectList.clear();
      getAllBankPaymentList(
        startDate: startDate.value,
        endDate: endDate.value,
        classId: classId.value,
        sectionId: sectionId.value,
      );
      selectedDateTextController.text = "$startDateForUI - $endDateForUI";
      return null;
    });
    dateRange = newDateRange ?? dateRange;
  }

  @override
  void onInit() {
    adminStudentsSearchController.fetchDataOnInit.value = false;
    adminStudentsSearchController.getStudentClassList().then(
          (value) => adminStudentsSearchController
              .getStudentSectionList(
                  classId: adminStudentsSearchController.studentClassId.value)
              .then(
                (value) => getAllBankPaymentList(
                  startDate: startDate.value,
                  endDate: endDate.value,
                  classId: adminStudentsSearchController.studentClassId.value,
                  sectionId:
                      adminStudentsSearchController.studentSectionId.value,
                ),
              ),
        );

    super.onInit();
  }
}
