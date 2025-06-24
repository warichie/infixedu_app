import 'package:flutter/cupertino.dart';
import 'package:infixedu/app/data/constants/app_text.dart';
import 'package:infixedu/app/modules/admin_fees_invoice_list/controllers/admin_fees_invoice_list_controller.dart';
import 'package:infixedu/app/routes/app_pages.dart';
import 'package:infixedu/app/utilities/api_urls.dart';
import 'package:infixedu/app/utilities/message/snack_bars.dart';
import 'package:infixedu/app/utilities/widgets/loader/loading.controller.dart';
import 'package:infixedu/config/global_variable/global_variable_controller.dart';
import 'package:infixedu/domain/base_client/base_client.dart';
import 'package:infixedu/domain/core/model/admin/admin_attendance_model/admin_student_subject_list_response_model.dart';
import 'package:infixedu/domain/core/model/admin/admin_student_model/admin_student_search_response_model.dart';
import 'package:infixedu/domain/core/model/admin/admin_student_model/student_class_list_response_model.dart';
import 'package:infixedu/domain/core/model/admin/admin_student_model/student_section_list_response_model.dart';
import 'package:get/get.dart';

class AdminStudentsSearchController extends GetxController {
  final bool searchInvoice;

  AdminStudentsSearchController({this.searchInvoice = false});
  GlobalRxVariableController globalRxVariableController = Get.find();
  LoadingController loadingController = Get.find();
  RxBool sectionLoader = false.obs;
  RxBool searchLoader = false.obs;
  RxBool subjectLoader = false.obs;
  RxBool subjectCall = false.obs;
  var fetchDataOnInit = true.obs;
  TextEditingController nameTextController = TextEditingController();
  TextEditingController rollTextController = TextEditingController();

  Rx<ClassListData> classValue = ClassListData(id: -1, name: "").obs;
  RxList<ClassListData> classList = <ClassListData>[].obs;
  RxInt studentClassId = 0.obs;

  RxList<SectionListData> sectionList = <SectionListData>[].obs;
  Rx<SectionListData> sectionValue = SectionListData(id: -1, name: "").obs;
  RxInt studentSectionId = 0.obs;

  RxList<StudentSearchData> studentSearchDataList = <StudentSearchData>[].obs;

  Rx<SubjectData> subjectValue = SubjectData(id: -1, name: "").obs;
  RxList<SubjectData> subjectList = <SubjectData>[].obs;
  RxInt studentSubjectId = 0.obs;

  /// Get Admin / Teacher Student Class List
  Future<StudentClassListResponseModel> getStudentClassList() async {
    try {
      classList.clear();
      loadingController.isLoading = true;

      final response = await BaseClient().getData(
          url: globalRxVariableController.roleId.value == 1
              ? InfixApi.getAdminClassList
              : InfixApi.getTeacherClassList,
          header: GlobalVariable.header);

      StudentClassListResponseModel studentClassListResponseModel =
          StudentClassListResponseModel.fromJson(response);

      if (studentClassListResponseModel.success == true) {
        if (studentClassListResponseModel.data!.isNotEmpty) {
          for (int i = 0; i < studentClassListResponseModel.data!.length; i++) {
            classList.add(studentClassListResponseModel.data![i]);
          }
          classValue.value = classList[0];
          studentClassId.value = classList[0].id!;
          globalRxVariableController.classId.value = classList[0].id!;
          getStudentSectionList(classId: studentClassId.value);
        }
      } else {
        loadingController.isLoading = false;
        showBasicFailedSnackBar(
            message: studentClassListResponseModel.message ??
                AppText.somethingWentWrong.tr);
      }
    } catch (e, t) {
      loadingController.isLoading = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      loadingController.isLoading = false;
    }

    return StudentClassListResponseModel();
  }

  /// Get Admin / Teacher Student Section List
  Future<StudentSectionListResponseModel> getStudentSectionList(
      {required int classId}) async {
    try {
      sectionList.clear();
      sectionLoader.value = true;

      final response = await BaseClient().getData(
          url: globalRxVariableController.roleId.value == 1
              ? InfixApi.getAdminSectionList(classId: classId)
              : InfixApi.getTeacherSectionList(classId: classId),
          header: GlobalVariable.header);

      StudentSectionListResponseModel studentSectionListResponseModel =
          StudentSectionListResponseModel.fromJson(response);

      if (studentSectionListResponseModel.success == true) {
        sectionLoader.value = false;
        if (studentSectionListResponseModel.data!.isNotEmpty) {
          sectionList.clear();
          for (int i = 0;
              i < studentSectionListResponseModel.data!.length;
              i++) {
            sectionList.add(studentSectionListResponseModel.data![i]);
          }
          sectionValue.value = sectionList.first;
          studentSectionId.value = sectionList.first.id!;
          globalRxVariableController.sectionId.value = sectionList.first.id!;

          getAdminStudentSubjectList(
            classId: studentClassId.value,
            sectionId: studentSectionId.value,
          );

          if (searchInvoice) {
            var controller = Get.find<AdminFeesInvoiceListController>();
            controller.feesInvoiceList.clear();
            controller.searchFeesInvoice(
              controller.adminStudentsSearchController.studentClassId.value,
              controller.adminStudentsSearchController.studentSectionId.value,
              "",
            );
          }
        }
      } else {
        sectionLoader.value = false;
        showBasicFailedSnackBar(
            message: studentSectionListResponseModel.message ??
                AppText.somethingWentWrong.tr);
      }
    } catch (e, t) {
      sectionLoader.value = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      sectionLoader.value = false;
    }

    return StudentSectionListResponseModel();
  }

  /// Get Admin / Teacher Student Subject List
  Future<AdminStudentSubjectListResponseModel> getAdminStudentSubjectList(
      {required int classId, required int sectionId}) async {
    try {
      subjectList.clear();
      subjectLoader.value = true;

      final response = await BaseClient().getData(
        url: globalRxVariableController.roleId.value == 1
            ? InfixApi.getAdminStudentSubjectList(
                classId: classId, sectionId: sectionId)
            : InfixApi.getTeacherStudentSubjectList(
                classId: classId,
                sectionId: sectionId,
              ),
        header: GlobalVariable.header,
      );

      AdminStudentSubjectListResponseModel
          adminStudentSubjectListResponseModel =
          AdminStudentSubjectListResponseModel.fromJson(response);

      if (adminStudentSubjectListResponseModel.success == true) {
        if (adminStudentSubjectListResponseModel.data!.isNotEmpty) {
          for (int i = 0;
              i < adminStudentSubjectListResponseModel.data!.length;
              i++) {
            subjectList.add(adminStudentSubjectListResponseModel.data![i]);
          }
          subjectValue.value = subjectList[0];
          studentSubjectId.value = subjectList[0].id!;
        }
      } else {
        subjectLoader.value = false;
        showBasicFailedSnackBar(
          message: adminStudentSubjectListResponseModel.message ??
              AppText.somethingWentWrong.tr,
        );
      }
    } catch (e, t) {
      subjectLoader.value = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      subjectLoader.value = false;
    }

    return AdminStudentSubjectListResponseModel();
  }

  /// Get Student List against class, section, roll no & name
  Future<AdminStudentSearchResponseModel> getSearchStudentDataList({
    required int classId,
    required int sectionId,
    required String rollNo,
    required String name,
  }) async {
    try {
      studentSearchDataList.clear();
      searchLoader.value = true;

      final response = await BaseClient().getData(
          url: InfixApi.getAdminStudentSearchList(
            classId: classId,
            sectionId: sectionId,
            rollNo: rollNo,
            name: name,
          ),
          header: GlobalVariable.header);

      AdminStudentSearchResponseModel adminStudentSearchResponseModel =
          AdminStudentSearchResponseModel.fromJson(response);

      if (adminStudentSearchResponseModel.success == true) {
        searchLoader.value = false;
        if (adminStudentSearchResponseModel.data!.isNotEmpty) {
          for (int i = 0;
              i < adminStudentSearchResponseModel.data!.length;
              i++) {
            studentSearchDataList.add(adminStudentSearchResponseModel.data![i]);
          }
          Get.toNamed(Routes.ADMIN_STUDENTS_SEARCH_LIST,
              arguments: {'search_data': studentSearchDataList});
        } else {
          Get.toNamed(Routes.ADMIN_STUDENTS_SEARCH_LIST,
              arguments: {'search_data': studentSearchDataList});
        }
      } else {
        searchLoader.value = false;
        showBasicFailedSnackBar(
            message: adminStudentSearchResponseModel.message ??
                AppText.somethingWentWrong.tr);
      }
    } catch (e, t) {
      searchLoader.value = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      searchLoader.value = false;
    }

    return AdminStudentSearchResponseModel();
  }

  @override
  void onReady() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (fetchDataOnInit.value) {
        getStudentClassList().then((value) {
          if (classList.isNotEmpty) {
            getStudentSectionList(classId: studentClassId.value).then((value) {
              if (sectionList.isNotEmpty && subjectCall.isTrue) {
                getAdminStudentSubjectList(
                    classId: studentClassId.value,
                    sectionId: studentSectionId.value);
              }
            });
          }
        });
      }
    });

    super.onReady();
  }
}
