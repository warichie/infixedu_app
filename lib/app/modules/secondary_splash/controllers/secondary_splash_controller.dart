import 'package:infixedu/app/database/auth_database.dart';
import 'package:infixedu/app/routes/app_pages.dart';
import 'package:infixedu/config/global_variable/app_settings_controller.dart';
import 'package:infixedu/config/global_variable/global_variable_controller.dart';
import 'package:get/get.dart';

class SecondarySplashController extends GetxController {
  @override
  void onInit() async {
    AuthDatabase authDatabase = AuthDatabase.instance;
    await 500.milliseconds.delay();

    Get.find<AppSettingsController>().loadData().then((value) {
      if (Get.find<AppSettingsController>().isConnected.value) {
        if (authDatabase.auth()) {
          Get.find<GlobalRxVariableController>().token.value =
              authDatabase.getToken()!;
          Get.find<AppSettingsController>().getActiveUserLang();
          Get.find<AppSettingsController>().getGeneralSettings();
        } else {
          Get.find<AppSettingsController>().getLang();
        }
      } else {
        Get.offAndToNamed(Routes.SERVICE_ERROR);
      }
    });

    super.onInit();
  }
}
