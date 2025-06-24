import 'package:get/get.dart';

import '../controllers/staff_individual_details_controller.dart';

class StaffIndividualDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<StaffIndividualDetailsController>(
      StaffIndividualDetailsController(),
    );
  }
}
