import 'package:infixedu/config/language/controller/languages/translated_language.dart';
import 'package:flutter/material.dart';
import 'package:infixedu/config/language/controller/languages/en_US.dart';
import 'package:get/get.dart';

import 'language_selection.dart';

String? language;
bool langValue = false;

class LanguageController extends GetxController implements Translations {
  String appLocale = 'en';
  String langCode = 'en';

  RxString langName = "".obs;
  Map<String, Map<String, String>> translationsData = {
    "en": en,
    "active": translatedLanguage,
  };

  @override
  Map<String, Map<String, String>> get keys => translationsData;

  Future changeLanguage() async {
    for (int i = 0; i < languageList.length; i++) {
      if (languageList[i].languageLocal == language) {
        // LanguageSelection.instance.val.value = languageList[i].languageLocal;
        // LanguageSelection.instance.drop.value = languageList[i].languageLocal;
        // LanguageSelection.instance.langName = languageList[i].languageName;
        // appLocale = languageList[i].languageLocal;

        LanguageSelection.instance.val.value = languageList[i].defaultLocale;
        LanguageSelection.instance.drop.value = languageList[i].defaultLocale;
        LanguageSelection.instance.langName = languageList[i].defaultLocale;
        appLocale = languageList[i].defaultLocale;
      } else {
        appLocale = Get.deviceLocale!.languageCode;
        langValue = true;
      }
    }
  }

  @override
  void onInit() async {
    super.onInit();
    keys['en'] = en;
    await changeLanguage();
    Get.updateLocale(Locale(appLocale));
    update();
  }
}

class LanguageModel {
  final int id;
  final String languageName;
  final String languageLocal;
  final String defaultLocale;
  final bool activeStatus;

  LanguageModel({
    required this.id,
    required this.languageName,
    required this.languageLocal,
    required this.defaultLocale,
    required this.activeStatus,
  });
}

RxList<LanguageModel> languageList = <LanguageModel>[].obs;
