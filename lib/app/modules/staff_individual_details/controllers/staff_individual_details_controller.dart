import 'package:flutter/cupertino.dart';
import 'package:infixedu/app/utilities/widgets/loader/loading.controller.dart';
import 'package:infixedu/domain/core/model/admin/admin_individual_staff_details_response_model/admin_individual_staff_details_response_model.dart';
import 'package:get/get.dart';

import '../../../../config/global_variable/global_variable_controller.dart';
import '../../../../domain/base_client/base_client.dart';
import '../../../utilities/api_urls.dart';

class StaffIndividualDetailsController extends GetxController {
  int staffIndividualId = 5;
  LoadingController loadingController = Get.find();
  String staffFirstName = Get.arguments["staff_first_name"] ?? "";
  String staffLastName = Get.arguments["staff_last_name"] ?? "";

  AdminIndividualStaffDetailsResponseModel?
      adminIndividualStaffDetailsResponseModel;

  Future getIndividualStaffData({required int staffIndividualId}) async {
    try {
      loadingController.isLoading = true;

      final response = await BaseClient().getData(
        url: InfixApi.getAdminStaffIndividualData(
            staffIndividualId: staffIndividualId),
        header: GlobalVariable.header,
      );

      adminIndividualStaffDetailsResponseModel =
          AdminIndividualStaffDetailsResponseModel.fromJson(response);
      if (adminIndividualStaffDetailsResponseModel!.success == true) {
        loadingController.isLoading = false;
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
    int staffIndividualId = Get.arguments["staff_individual_id"];
    this.staffIndividualId = staffIndividualId;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getIndividualStaffData(staffIndividualId: staffIndividualId);
    });

    super.onInit();
  }
}
