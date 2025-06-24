import 'dart:io';

import 'package:get/get.dart';

class ProfileDataController extends GetxController {

  RxString firstName          = ''.obs;
  RxString lastName           = ''.obs;
  RxString email               = ''.obs;
  RxString phoneNumber        = ''.obs;
  RxString dateOfBirth        = ''.obs;
  RxString presentAddress     = ''.obs;
  RxString profilePhoto       = ''.obs;

  Rx<File> profilePickedImage       = File('').obs;

}
