import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:infixedu/app/database/auth_database.dart';
import 'package:infixedu/app/routes/app_pages.dart';
import 'package:infixedu/app/utilities/api_urls.dart';
import 'package:infixedu/app/utilities/message/snack_bars.dart';
import 'package:infixedu/config/global_variable/global_variable_controller.dart';
import 'package:infixedu/config/language/controller/language_controller.dart';
import 'package:infixedu/config/language/controller/languages/translated_language.dart';
import 'package:infixedu/domain/core/exceptions/conflict_exception.dart';
import 'package:infixedu/domain/core/exceptions/default.exception.dart';
import 'package:infixedu/domain/core/exceptions/forbidden.exception.dart';
import 'package:infixedu/domain/core/exceptions/unprocessable_exception.dart';
import 'package:infixedu/domain/core/model/settings/general_settings_response_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AppSettingsController extends GetxController {
  final AuthDatabase authDatabase = AuthDatabase.instance;

  /// Loader
  RxBool languageLoader = false.obs;
  RxBool serviceLoader = false.obs;

  RxBool isConnected = false.obs;
  RxBool connectedStatus = false.obs;
  RxString serverMessage = 'Something Went wrong.\n Restart your app.'.obs;
  RxString errorMsg = "".obs;

  Rx<GeneralSettingsResponseModel> systemSettings =
      GeneralSettingsResponseModel().obs;
  CurrencyDetail? currencyDetail;

  void navNextPage() async {
    await 1000.milliseconds.delay();

    Get.offAndToNamed(Routes.SPLASH);
  }

  void getLang() async {
    debugPrint('LANG URL :: ${InfixApi.languageList}');

    try {
      languageList.clear();
      languageLoader.value = false;

      final response = await http.get(Uri.parse(InfixApi.languageList));

      debugPrint('Lang Response ::: ${response.body}');

      if (response.statusCode == 200) {
        languageLoader.value = true;
        Map<String, dynamic> responseData = json.decode(response.body);
        Map<String, String> translations =
            Map<String, String>.from(responseData['lang']);
        for (int i = 0; i < responseData['lang_list'].length; i++) {
          languageList.add(LanguageModel(
            id: responseData['lang_list'][i]['id'],
            languageName: responseData['lang_list'][i]['lang_name'],
            languageLocal: responseData['lang_list'][i]['locale'],
            defaultLocale: responseData['lang_list'][i]['default_locale'],
            activeStatus: responseData['lang_list'][i]['active_status'],
          ));

          if (responseData['lang_list'][i]['active_status'] == true) {
            translatedLanguage.assignAll(translations);
            debugPrint('Translated DATA $translatedLanguage');
            Get.find<LanguageController>().langName.value =
                responseData['lang_list'][i]['lang_name'];
            Get.find<LanguageController>().appLocale =
                responseData['lang_list'][i]['default_locale'];
            Get.find<LanguageController>().langCode =
                responseData['lang_list'][i]['default_locale'];
            Get.updateLocale(Locale(responseData['lang_list'][i]['locale']));
            Get.find<GlobalRxVariableController>().isRtl.value =
                responseData['lang_list'][i]['rtl'];
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setBool('isRtl', responseData['lang_list'][i]['rtl']);
          }
        }
        navNextPage();
      } else {
        languageLoader.value = true;
        navNextPage();
        throw Exception('Failed to load translations');
      }
    } catch (e, t) {
      languageLoader.value = true;
      navNextPage();
      debugPrint('$e');
      debugPrint('$t');
      throw Exception('Failed to load translations: $e');
    } finally {
      languageLoader.value = true;
      navNextPage();
    }
  }

  void getActiveUserLang() async {
    debugPrint('LANG URL :: ${InfixApi.activeUserLanguageList}');

    try {
      languageList.clear();
      languageLoader.value = false;

      final response = await http.get(
        Uri.parse(InfixApi.activeUserLanguageList),
        headers: GlobalVariable.header,
      );

      if (response.statusCode == 200) {
        languageLoader.value = true;
        Map<String, dynamic> responseData = json.decode(response.body);
        Map<String, String> translations =
            Map<String, String>.from(responseData['lang']);
        for (int i = 0; i < responseData['lang_list'].length; i++) {
          languageList.add(LanguageModel(
            id: responseData['lang_list'][i]['id'],
            languageName: responseData['lang_list'][i]['lang_name'],
            languageLocal: responseData['lang_list'][i]['locale'],
            defaultLocale: responseData['lang_list'][i]['default_locale'],
            activeStatus: responseData['lang_list'][i]['active_status'],
          ));

          if (responseData['lang_list'][i]['active_status'] == true) {
            translatedLanguage.assignAll(translations);
            Get.find<LanguageController>().langName.value =
                responseData['lang_list'][i]['lang_name'];
            // Get.find<LanguageController>().appLocale = responseData['lang_list'][i]['locale'];
            Get.find<LanguageController>().appLocale =
                responseData['lang_list'][i]['default_locale'];
            Get.find<LanguageController>().langCode =
                responseData['lang_list'][i]['default_locale'];
            Get.updateLocale(Locale(Get.find<LanguageController>().appLocale));
            Get.find<GlobalRxVariableController>().isRtl.value =
                responseData['lang_list'][i]['rtl'];
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setBool('isRtl', responseData['lang_list'][i]['rtl']);
          }
        }
        navNextPage();
      } else {
        languageLoader.value = true;
        navNextPage();
        // throw Exception('Failed to load translations');
      }
    } catch (e, t) {
      languageLoader.value = true;
      navNextPage();
      debugPrint('$e');
      debugPrint('$t');
      // throw Exception('Failed to load translations: $e');
    } finally {
      languageLoader.value = true;
      navNextPage();
    }
  }

  Future<void> getGeneralSettings() async {
    try {
      final response = await http.get(
        Uri.parse(InfixApi.generalSettings),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': Get.find<GlobalRxVariableController>().token.value!
        },
      );
      debugPrint('Settings Response ::: $response');
      GeneralSettingsResponseModel responseModel =
          GeneralSettingsResponseModel.fromJson(
              json.decode(response.body.toString()));

      if (responseModel.success == true) {
        systemSettings.value = responseModel;

        currencyDetail = responseModel.data!.systemSettings!.currencyDetail;
        Get.find<GlobalRxVariableController>().currencySymbol.value =
            currencyDetail?.currencyType;
      } else {
        if (responseModel.message!.contains('Unauthenticated')) {
          authDatabase.logOut();
          Future.delayed(const Duration(seconds: 2)).then((val) {
            Get.offNamedUntil('/secondary-splash', (route) => false);
            // Get.offNamedUntil('/splash', (route) => false);
          });
        }
      }
    } catch (e, t) {
      debugPrint('$e');
      debugPrint('$t');
    } finally {}
  }

  Future<void> loadData() async {
    try {
      debugPrint('Url ::: ${InfixApi.service}');
      serviceLoader.value = true;

      final response = await http.get(Uri.parse(InfixApi.service),
          headers: {'Accept': 'application/json'});
      var decode = jsonDecode(response.body);
      debugPrint('Service Check Response::::::: ${response.body}');

      if (response.statusCode == 200) {
        serviceLoader.value = false;
        isConnected.value = decode;
        // return connected.value;
      } else {
        serviceLoader.value = false;
        connectedStatus.value = true;
        isConnected.value = false;
        serverMessage.value = decode['message'];
        Get.offAndToNamed(Routes.SERVICE_ERROR);
      }
    } on UnProcessableException catch (e) {
      showBasicFailedSnackBar(message: e.message);
    } on ForbiddenException catch (e) {
      showBasicFailedSnackBar(message: e.message);
    } on ConflictException catch (e) {
      showBasicFailedSnackBar(message: e.message);
    } on DefaultException catch (e) {
      showBasicFailedSnackBar(message: e.message);
    } catch (e, t) {
      debugPrint('$e');
      debugPrint('$t');
      connectedStatus.value = true;
      serverMessage.value = 'Something Went wrong.\n Restart your app.';
      serviceLoader.value = false;
      errorMsg.value = e.toString();
      throw e.toString();
    } finally {
      serviceLoader.value = false;
    }
  }

  // @override
  // void onInit() {
  //   loadData();
  //   super.onInit();
  // }
}
