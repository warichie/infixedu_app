import 'package:flutter/cupertino.dart';
import 'package:infixedu/app/data/constants/app_text.dart';
import 'package:infixedu/app/utilities/api_urls.dart';
import 'package:infixedu/app/utilities/message/snack_bars.dart';
import 'package:infixedu/app/utilities/widgets/loader/loading.controller.dart';
import 'package:infixedu/config/global_variable/global_variable_controller.dart';
import 'package:infixedu/domain/base_client/base_client.dart';
import 'package:infixedu/domain/core/model/admin/admin_library_model/member_model/admin_library_add_member_class_response_model.dart';
import 'package:infixedu/domain/core/model/admin/admin_library_model/member_model/admin_library_add_member_parents_response_model.dart';
import 'package:infixedu/domain/core/model/admin/admin_library_model/member_model/admin_library_add_member_roles_response_model.dart';
import 'package:infixedu/domain/core/model/admin/admin_library_model/member_model/admin_library_add_member_section_response_model.dart';
import 'package:infixedu/domain/core/model/admin/admin_library_model/member_model/admin_library_add_member_student_response_model.dart';
import 'package:infixedu/domain/core/model/admin/admin_library_model/member_model/admin_library_add_member_user_name_response_model.dart';
import 'package:infixedu/domain/core/model/post_request_response_model.dart';
import 'package:get/get.dart';

class AdminAddMemberController extends GetxController {
  LoadingController loadingController = Get.find();

  TextEditingController uniqueIdTextController = TextEditingController();

  /// Loader
  RxBool rolesLoader = false.obs;
  RxBool userNameLoader = false.obs;
  RxBool classLoader = false.obs;
  RxBool sectionLoader = false.obs;
  RxBool studentLoader = false.obs;
  RxBool parentLoader = false.obs;

  /// Roles dropdown
  RxList<AdminAddMemberRoleData> rolesList = <AdminAddMemberRoleData>[].obs;
  Rx<AdminAddMemberRoleData> rolesDropdownValue =
      AdminAddMemberRoleData(id: -1, name: "Roles Name").obs;
  RxInt rolesId = 0.obs;

  /// user Name dropdown
  RxList<AdminAddMemberUserNameData> userNameList =
      <AdminAddMemberUserNameData>[].obs;
  Rx<AdminAddMemberUserNameData> userNameDropdownValue =
      AdminAddMemberUserNameData(id: -1, name: "User Name").obs;
  RxInt nameId = 0.obs;
  RxInt userId = 0.obs;

  /// Class List dropdown
  RxList<AdminLibraryAddMemberClassData> classList =
      <AdminLibraryAddMemberClassData>[].obs;
  Rx<AdminLibraryAddMemberClassData> classDropdownValue =
      AdminLibraryAddMemberClassData(id: -1, name: "Class").obs;
  RxInt classId = 0.obs;

  /// Section List dropdown
  RxList<AdminAddMemberSectionData> sectionList =
      <AdminAddMemberSectionData>[].obs;
  Rx<AdminAddMemberSectionData> sectionDropdownValue =
      AdminAddMemberSectionData(id: -1, name: "Section").obs;
  RxInt sectionId = 0.obs;

  /// Student List dropdown
  RxList<AdminLibraryAddMemberStudentData> studentList =
      <AdminLibraryAddMemberStudentData>[].obs;
  Rx<AdminLibraryAddMemberStudentData> studentDropdownValue =
      AdminLibraryAddMemberStudentData(id: -1, name: "Section").obs;
  RxInt studentId = 0.obs;

  /// Parents List Dropdown
  RxList<AdminLibraryAddMemberParentsData> parentsList =
      <AdminLibraryAddMemberParentsData>[].obs;
  Rx<AdminLibraryAddMemberParentsData> parentsDropdownValue =
      AdminLibraryAddMemberParentsData(id: -1, name: "parent_name").obs;
  RxInt parentsId = 0.obs;

  /// Get Member Role List
  Future<AdminLibraryAddMemberRolesResponseModel> getRolesList() async {
    try {
      rolesList.clear();
      rolesLoader.value = true;

      final response = await BaseClient().getData(
          url: InfixApi.getAdminMemberRolesList, header: GlobalVariable.header);

      AdminLibraryAddMemberRolesResponseModel addMemberRolesResponseModel =
          AdminLibraryAddMemberRolesResponseModel.fromJson(response);

      if (addMemberRolesResponseModel.success == true) {
        rolesLoader.value = false;

        if (addMemberRolesResponseModel.data!.isNotEmpty) {
          for (int i = 0; i < addMemberRolesResponseModel.data!.length; i++) {
            rolesList.add(addMemberRolesResponseModel.data![i]);
          }
          rolesDropdownValue.value = rolesList[0];
          rolesId.value = rolesList[0].id!;
        }
      } else {
        rolesLoader.value = false;
        showBasicFailedSnackBar(
            message: addMemberRolesResponseModel.message ??
                AppText.somethingWentWrong.tr);
      }
    } catch (e, t) {
      rolesLoader.value = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      rolesLoader.value = false;
    }

    return AdminLibraryAddMemberRolesResponseModel();
  }

  /// Get User Name list
  Future<AdminLibraryAddMemberUserNameResponseModel> getUserNameList(
      {required int roleId}) async {
    try {
      userNameList.clear();
      userNameLoader.value = true;

      final response = await BaseClient().getData(
          url: InfixApi.getAdminMemberUserNameList(roleId: roleId),
          header: GlobalVariable.header);

      AdminLibraryAddMemberUserNameResponseModel
          addMemberUserNameResponseModel =
          AdminLibraryAddMemberUserNameResponseModel.fromJson(response);

      if (addMemberUserNameResponseModel.success == true) {
        userNameLoader.value = false;

        if (addMemberUserNameResponseModel.data!.isNotEmpty) {
          for (int i = 0;
              i < addMemberUserNameResponseModel.data!.length;
              i++) {
            userNameList.add(addMemberUserNameResponseModel.data![i]);
          }
          userNameDropdownValue.value = userNameList[0];
          nameId.value = userNameList[0].id!;
          userId.value = userNameList.first.userId!;
        }
      } else {
        userNameLoader.value = false;
        showBasicFailedSnackBar(
            message: addMemberUserNameResponseModel.message ??
                AppText.somethingWentWrong.tr);
      }
    } catch (e, t) {
      userNameLoader.value = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      userNameLoader.value = false;
    }

    return AdminLibraryAddMemberUserNameResponseModel();
  }

  /// Get Class List
  Future<AdminLibraryAddMemberClassResponseModel> getClassList(
      {required int roleId}) async {
    try {
      classList.clear();
      classLoader.value = true;

      final response = await BaseClient().getData(
          url: InfixApi.getAdminMemberClassList(roleId: roleId),
          header: GlobalVariable.header);

      AdminLibraryAddMemberClassResponseModel addMemberClassResponseModel =
          AdminLibraryAddMemberClassResponseModel.fromJson(response);

      if (addMemberClassResponseModel.success == true) {
        classLoader.value = false;

        if (addMemberClassResponseModel.data!.isNotEmpty) {
          for (int i = 0; i < addMemberClassResponseModel.data!.length; i++) {
            classList.add(addMemberClassResponseModel.data![i]);
          }
          classDropdownValue.value = classList[0];
          classId.value = classList[0].id!;
          await getSectionList(classId: classId.value);
        }
      } else {
        classLoader.value = false;
        showBasicFailedSnackBar(
            message: addMemberClassResponseModel.message ??
                AppText.somethingWentWrong.tr);
      }
    } catch (e, t) {
      classLoader.value = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      classLoader.value = false;
    }

    return AdminLibraryAddMemberClassResponseModel();
  }

  /// Get Sections List
  Future<AdminLibraryAddMemberSectionResponseModel> getSectionList(
      {required int classId}) async {
    try {
      sectionList.clear();
      sectionLoader.value = true;

      final response = await BaseClient().getData(
          url: InfixApi.getAdminMemberSectionList(classId: classId),
          header: GlobalVariable.header);

      AdminLibraryAddMemberSectionResponseModel addMemberSectionResponseModel =
          AdminLibraryAddMemberSectionResponseModel.fromJson(response);

      if (addMemberSectionResponseModel.success == true) {
        sectionLoader.value = false;

        if (addMemberSectionResponseModel.data!.isNotEmpty) {
          for (int i = 0; i < addMemberSectionResponseModel.data!.length; i++) {
            sectionList.add(addMemberSectionResponseModel.data![i]);
          }
          sectionDropdownValue.value = sectionList[0];
          sectionId.value = sectionList[0].id!;

          if (rolesId.value == 2) {
            getStudentList(classId: classId, sectionId: sectionId.value);
          } else if (rolesId.value == 3) {
            getParentsList(classId: classId, sectionId: sectionId.value);
          }
        }
      } else {
        sectionLoader.value = false;
        showBasicFailedSnackBar(
            message: addMemberSectionResponseModel.message ??
                AppText.somethingWentWrong.tr);
      }
    } catch (e, t) {
      sectionLoader.value = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      sectionLoader.value = false;
    }

    return AdminLibraryAddMemberSectionResponseModel();
  }

  /// Get Students List
  Future<AdminLibraryAddMemberStudentResponseModel> getStudentList(
      {required int classId, required int sectionId}) async {
    try {
      studentList.clear();
      studentLoader.value = true;

      final response = await BaseClient().getData(
          url: InfixApi.getAdminMemberStudentList(
              classId: classId, sectionId: sectionId),
          header: GlobalVariable.header);

      AdminLibraryAddMemberStudentResponseModel addMemberStudentResponseModel =
          AdminLibraryAddMemberStudentResponseModel.fromJson(response);

      if (addMemberStudentResponseModel.success == true) {
        studentLoader.value = false;

        if (addMemberStudentResponseModel.data!.isNotEmpty) {
          for (int i = 0; i < addMemberStudentResponseModel.data!.length; i++) {
            studentList.add(addMemberStudentResponseModel.data![i]);
          }
          studentDropdownValue.value = studentList[0];
          studentId.value = studentList[0].id!;
          userId.value = studentList.first.userId!;
        }
      } else {
        studentLoader.value = false;
        showBasicFailedSnackBar(
            message: addMemberStudentResponseModel.message ??
                AppText.somethingWentWrong.tr);
      }
    } catch (e, t) {
      studentLoader.value = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      studentLoader.value = false;
    }

    return AdminLibraryAddMemberStudentResponseModel();
  }

  /// Get Parents List
  Future<AdminLibraryAddMemberParentsResponseModel> getParentsList(
      {required int classId, required int sectionId}) async {
    try {
      parentsList.clear();
      parentLoader.value = true;

      final response = await BaseClient().getData(
          url: InfixApi.getAdminMemberParentList(
              classId: classId, sectionId: sectionId),
          header: GlobalVariable.header);

      AdminLibraryAddMemberParentsResponseModel addMemberParentsResponseModel =
          AdminLibraryAddMemberParentsResponseModel.fromJson(response);

      if (addMemberParentsResponseModel.success == true) {
        parentLoader.value = false;

        if (addMemberParentsResponseModel.data!.isNotEmpty) {
          for (int i = 0; i < addMemberParentsResponseModel.data!.length; i++) {
            parentsList.add(addMemberParentsResponseModel.data![i]);
          }
          parentsDropdownValue.value = parentsList[0];
          parentsId.value = parentsList[0].id!;
          userId.value = parentsList.first.userId!;
        }
      } else {
        parentLoader.value = false;
        showBasicFailedSnackBar(
            message: addMemberParentsResponseModel.message ??
                AppText.somethingWentWrong.tr);
      }
    } catch (e, t) {
      parentLoader.value = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      parentLoader.value = false;
    }

    return AdminLibraryAddMemberParentsResponseModel();
  }

  bool validation() {
    if (rolesList.isEmpty) {
      showBasicFailedSnackBar(message: 'The member type field is required'.tr);
      return false;
    } else if (uniqueIdTextController.text.isEmpty) {
      showBasicFailedSnackBar(message: 'The Member id is required'.tr);
      return false;
    }

    return true;
  }

  Future<PostRequestResponseModel> adminAddMember() async {
    try {
      loadingController.isLoading = true;
      final response = await BaseClient().postData(
          url: InfixApi.postAdminLibraryAddMember,
          header: GlobalVariable.header,
          payload: {
            'student': studentId.value,
            'parent': parentsId.value,
            'staff': nameId.value,
            'user_id': userId.value,
            'member_type': rolesId.value,
            'member_ud_id': uniqueIdTextController.text,
          });

      PostRequestResponseModel postRequestResponseModel =
          PostRequestResponseModel.fromJson(response);

      if (postRequestResponseModel.success == true) {
        uniqueIdTextController.clear();
        loadingController.isLoading = false;
        uniqueIdTextController.clear();
        showBasicSuccessSnackBar(
          message:
              postRequestResponseModel.message ?? AppText.somethingWentWrong.tr,
        );
      } else {
        loadingController.isLoading = false;
        showBasicFailedSnackBar(
          message:
              postRequestResponseModel.message ?? AppText.somethingWentWrong.tr,
        );
      }
    } catch (e, t) {
      loadingController.isLoading = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      loadingController.isLoading = false;
    }

    return PostRequestResponseModel();
  }

  @override
  void onInit() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getRolesList().then((value) => getUserNameList(roleId: rolesId.value));
    });

    super.onInit();
  }
}
