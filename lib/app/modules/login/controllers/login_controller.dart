import 'package:flutter/cupertino.dart';
import 'package:infixedu/app/utilities/app_functions/functionality.dart';
import 'package:infixedu/app/utilities/widgets/loader/loading.controller.dart';
import 'package:infixedu/config/global_variable/app_settings_controller.dart';
import 'package:infixedu/config/global_variable/global_variable_controller.dart';
import 'package:infixedu/domain/core/model/profile_ui_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../../domain/base_client/base_client.dart';
import '../../../utilities/widgets/no_internet/internet_controller.dart';
import '../../../database/auth_database.dart';
import '../../../utilities/api_urls.dart';
import '../../../utilities/message/snack_bars.dart';

class LoginController extends GetxController {
  GlobalRxVariableController globalRxVariableController =
      Get.find<GlobalRxVariableController>();

  RxBool isLoading = false.obs;
  RxBool isObscureText = true.obs;

  LoadingController loadingController = Get.find();
  InternetController internetController = Get.find();

  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  final GetStorage _box = GetStorage();

  void userLogin({required String email, required String password}) async {
    ProfileInfoModel profileInfoModel;

    try {
      isLoading.value = true;
      final res = await BaseClient().postData(
        url: InfixApi.login(),
        header: {'Content-Type': 'application/json'},
        payload: {"email": email, "password": password},
      );

      profileInfoModel = ProfileInfoModel.fromJson(res);
      if (profileInfoModel.success == true) {
        isLoading.value = false;
        _box.write('password', password);
        globalRxVariableController.notificationCount.value =
            profileInfoModel.data.unreadNotifications;
        globalRxVariableController.token.value =
            profileInfoModel.data.accessToken;
        globalRxVariableController.roleId.value =
            profileInfoModel.data.user.roleId;
        globalRxVariableController.userId.value = profileInfoModel.data.user.id;
        globalRxVariableController.email.value =
            profileInfoModel.data.user.email;
        globalRxVariableController.fullName.value =
            profileInfoModel.data.user.fullName;

        showBasicSuccessSnackBar(message: profileInfoModel.message);
        bool status = await AuthDatabase.instance.saveAuthInfo(
          profileInfoModelModel: profileInfoModel,
        );

        GlobalVariable.header = {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': Get.find<GlobalRxVariableController>().token.value!,
        };

        if (profileInfoModel.data.user.roleId == 2) {
          globalRxVariableController.studentId.value =
              profileInfoModel.data.user.studentId;
          globalRxVariableController.roleName.value = 'Student';
          globalRxVariableController.isStudent.value = true;
          debugPrint('Student Id ::: ${globalRxVariableController.studentId}');
        }

        if (profileInfoModel.data.user.roleId == 1 ||
            profileInfoModel.data.user.roleId == 4) {
          globalRxVariableController.staffId.value =
              profileInfoModel.data.user.staffId;
          profileInfoModel.data.user.roleId == 1
              ? globalRxVariableController.roleName.value = 'Admin'
              : globalRxVariableController.roleName.value = 'Teacher';

          debugPrint(
              'Admin/Teacher Id ::: ${globalRxVariableController.staffId}');
        }

        if (profileInfoModel.data.user.roleId == 3) {
          globalRxVariableController.parentId.value =
              profileInfoModel.data.user.parentId;
          globalRxVariableController.roleName.value = 'Parent';
          debugPrint('Parent Id ::: ${globalRxVariableController.parentId}');
        }

        if (status) {
          AppFunctions().getFunctions(profileInfoModel.data.user.roleId);
        }
        Get.find<AppSettingsController>().getGeneralSettings();
      } else {
        isLoading.value = false;
        showBasicFailedSnackBar(message: profileInfoModel.message);
      }
    } catch (e, t) {
      isLoading.value = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      isLoading.value = false;
    }
  }

  void demoUserLogin({required int role}) async {
    ProfileInfoModel profileInfoModel;
    try {
      isLoading.value = true;
      final response = await BaseClient().getData(
        url: InfixApi.demoLogin(role.toString()),
        header: {'Content-Type': 'application/json'},
      );

      profileInfoModel = ProfileInfoModel.fromJson(response);
      if (profileInfoModel.success == true) {
        isLoading.value = false;
        globalRxVariableController.notificationCount.value =
            profileInfoModel.data.unreadNotifications;
        globalRxVariableController.token.value =
            profileInfoModel.data.accessToken;
        globalRxVariableController.roleId.value =
            profileInfoModel.data.user.roleId;
        globalRxVariableController.userId.value = profileInfoModel.data.user.id;
        globalRxVariableController.email.value =
            profileInfoModel.data.user.email;
        globalRxVariableController.fullName.value =
            profileInfoModel.data.user.fullName;

        showBasicSuccessSnackBar(message: profileInfoModel.message);
        bool status = await AuthDatabase.instance.saveAuthInfo(
          profileInfoModelModel: profileInfoModel,
        );

        GlobalVariable.header = {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': Get.find<GlobalRxVariableController>().token.value!,
        };

        if (profileInfoModel.data.user.roleId == 2) {
          globalRxVariableController.studentId.value =
              profileInfoModel.data.user.studentId;
          globalRxVariableController.isStudent.value = true;
          globalRxVariableController.roleName.value = 'Student';
          debugPrint('Student Id ::: ${globalRxVariableController.studentId}');
        }

        if (profileInfoModel.data.user.roleId == 1 ||
            profileInfoModel.data.user.roleId == 4) {
          globalRxVariableController.staffId.value =
              profileInfoModel.data.user.staffId;
          debugPrint(
              'Admin/Teacher Id ::: ${globalRxVariableController.staffId}');
          profileInfoModel.data.user.roleId == 1
              ? globalRxVariableController.roleName.value = 'Admin'
              : globalRxVariableController.roleName.value = 'Teacher';
        }

        if (profileInfoModel.data.user.roleId == 3) {
          globalRxVariableController.parentId.value =
              profileInfoModel.data.user.parentId;
          debugPrint('Parent Id ::: ${globalRxVariableController.parentId}');
          globalRxVariableController.roleName.value = 'Parent';
        }

        if (status) {
          AppFunctions().getFunctions(profileInfoModel.data.user.roleId);
        }
        Get.find<AppSettingsController>().getGeneralSettings();
      } else {
        isLoading.value = false;
        showBasicFailedSnackBar(message: profileInfoModel.message);
      }
    } catch (e, t) {
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    internetConnectionChecker();
    super.onInit();
  }
}
