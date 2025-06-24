import 'package:flutter/cupertino.dart';
import 'package:infixedu/app/utilities/widgets/loader/loading.controller.dart';
import 'package:get/get.dart';

import '../../../../config/global_variable/global_variable_controller.dart';
import '../../../../domain/base_client/base_client.dart';
import '../../../../domain/core/model/admin/admin_staff_role_list_response_model/admin_staff_role_list_response_model.dart';
import '../../../utilities/api_urls.dart';

class StaffController extends GetxController {
  LoadingController loadingController = Get.find();
  RxBool isLoading = false.obs;

  final selectIndex = RxInt(-1);
  List<StaffRolesData> staffRoleList = [];

  Future<void> getAllRolesList() async {
    try {
      isLoading.value = true;

      final response = await BaseClient().getData(
        url: InfixApi.getAdminStaffRoleList,
        header: GlobalVariable.header,
      );

      AdminStaffRoleListResponseModel adminStaffRoleListResponseModel =
          AdminStaffRoleListResponseModel.fromJson(response);

      if (adminStaffRoleListResponseModel.success == true) {
        isLoading.value = false;
        if (adminStaffRoleListResponseModel.data!.roles!.isNotEmpty) {
          for (int i = 0;
              i < adminStaffRoleListResponseModel.data!.roles!.length;
              i++) {
            staffRoleList.add(adminStaffRoleListResponseModel.data!.roles![i]);
          }
        }
      }
    } catch (e, t) {
      isLoading.value = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    getAllRolesList();
    super.onInit();
  }
}
