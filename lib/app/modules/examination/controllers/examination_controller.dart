import 'package:flutter/cupertino.dart';
import 'package:infixedu/app/modules/home/controllers/home_controller.dart';
import 'package:infixedu/app/utilities/message/snack_bars.dart';
import 'package:infixedu/app/utilities/widgets/loader/loading.controller.dart';
import 'package:get/get.dart';
import '../../../../config/global_variable/global_variable_controller.dart';
import '../../../../domain/base_client/base_client.dart';
import '../../../../domain/core/model/exam_dropdown_model/exam_dropdown_response_model.dart';
import '../../../data/constants/image_path.dart';
import '../../../data/module_data/home_data/home_dummy_data.dart';
import '../../../utilities/api_urls.dart';

class ExaminationController extends GetxController {
  HomeController homeController = Get.find();
  LoadingController loadingController = Get.find();

  final selectIndex = RxInt(-1);

  List<HomeTileModelClass> examinationTileList = [
    HomeTileModelClass(
      icon: ImagePath.examinationSchedule,
      title: 'Schedule',
      value: 'Schedule',
    ),
    HomeTileModelClass(
      icon: ImagePath.examinationResult,
      title: 'Result',
      value: 'Result',
    ),
  ];

  // List<ExamDataList> examList = [];
  // List<String> examDropdownList = [];
  // List<int> examDropdownIdList = [];

  Rx<ExamDataList> dropdownValue = ExamDataList(id: -1, name: "title").obs;

  RxList<ExamDataList> dropdownList = <ExamDataList>[].obs;

  RxList examDropdownList = <String>[].obs;
  RxList examDropdownIdList = <int>[].obs;
  RxList<ExamDataList> examList = <ExamDataList>[].obs;
  RxInt examId = 0.obs;

  void getStudentExamList({required int recordId}) async {
    try {
      loadingController.isLoading = true;

      final response = await BaseClient().getData(
        url: InfixApi.getStudentExamList(recordId),
        header: GlobalVariable.header,
      );

      ExamDropdownResponseModel examDropdownResponseModel =
          ExamDropdownResponseModel.fromJson(response);
      if (examDropdownResponseModel.success == true) {
        loadingController.isLoading = false;
        if (examDropdownResponseModel.data!.isNotEmpty) {
          for (int i = 0; i < examDropdownResponseModel.data!.length; i++) {
            examList.add(examDropdownResponseModel.data![i]);
            examDropdownList.add(examDropdownResponseModel.data![i].name!);
            examDropdownIdList.add(examDropdownResponseModel.data![i].id!);
            dropdownList.add(examDropdownResponseModel.data![i]);
          }
          dropdownValue.value = dropdownList[0];
          examId.value = dropdownList.first.id!;
        }
      } else {
        loadingController.isLoading = false;
        showBasicFailedSnackBar(
            message:
                examDropdownResponseModel.message ?? 'Failed to load data'.tr);
      }
    } catch (e, t) {
      loadingController.isLoading = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      loadingController.isLoading = false;
    }
  }

  @override
  void onInit() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (homeController.studentRecordList.isNotEmpty) {
        getStudentExamList(recordId: homeController.studentRecordList[0].id);
      }
    });

    super.onInit();
  }
}
