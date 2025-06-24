import 'package:get/get.dart';


class LanguageSelection {
  RxString drop = ''.obs;
  RxString val = 'en'.obs;

  String langName = 'English';

  LanguageSelection._privateConstructor();

  static LanguageSelection get instance => _instance;

  static final LanguageSelection _instance =
  LanguageSelection._privateConstructor();

  factory LanguageSelection() {
    return _instance;
  }
}