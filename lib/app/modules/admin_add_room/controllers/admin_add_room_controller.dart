import 'package:flutter/cupertino.dart';
import 'package:infixedu/app/utilities/api_urls.dart';
import 'package:infixedu/app/utilities/message/snack_bars.dart';
import 'package:infixedu/app/utilities/widgets/loader/loading.controller.dart';
import 'package:infixedu/config/global_variable/global_variable_controller.dart';
import 'package:infixedu/domain/base_client/base_client.dart';
import 'package:infixedu/domain/core/model/admin/dormitory_model/dormitory_list_response_model.dart';
import 'package:infixedu/domain/core/model/admin/dormitory_model/dormitory_room_type_response_model.dart';
import 'package:infixedu/domain/core/model/post_request_response_model.dart';
import 'package:get/get.dart';

class AdminAddRoomController extends GetxController {
  LoadingController loadingController = Get.find();

  TextEditingController roomNameTextController = TextEditingController();
  TextEditingController numberOfBedTextController = TextEditingController();
  TextEditingController costPerBedTextController = TextEditingController();
  TextEditingController descriptionTextController = TextEditingController();

  RxBool isLoading = false.obs;
  RxBool saveLoader = false.obs;
  RxInt dormitoryId = 0.obs;
  RxInt roomTypeId = 0.obs;

  Rx<DormitoryListData> dormitoryValue =
      DormitoryListData(id: -1, name: "Dormitory").obs;
  List<String> dormitoryDropdownList = [];
  RxList<DormitoryListData> dormitoryList = <DormitoryListData>[].obs;

  Rx<DormitoryRoomTypeData> roomTypeValue =
      DormitoryRoomTypeData(id: -1, name: "Select dormitory room").obs;
  RxList<DormitoryRoomTypeData> roomTypeList = <DormitoryRoomTypeData>[].obs;

  bool validation() {
    if (roomNameTextController.text.isEmpty) {
      showBasicFailedSnackBar(message: 'Select Room Name'.tr);
      return false;
    }

    if (numberOfBedTextController.text.isEmpty) {
      showBasicFailedSnackBar(message: 'Select Number of Bed'.tr);
      return false;
    }

    if (costPerBedTextController.text.isEmpty) {
      showBasicFailedSnackBar(message: 'Select Cost Per Bed'.tr);
      return false;
    }

    return true;
  }

  Future<DormitoryListResponseModel> getDormitoryList() async {
    try {
      loadingController.isLoading = true;

      final response = await BaseClient().getData(
          url: InfixApi.getAdminDormitoryList, header: GlobalVariable.header);

      DormitoryListResponseModel dormitoryListResponseModel =
          DormitoryListResponseModel.fromJson(response);
      if (dormitoryListResponseModel.success == true) {
        loadingController.isLoading = false;

        if (dormitoryListResponseModel.data!.isNotEmpty) {
          for (int i = 0; i < dormitoryListResponseModel.data!.length; i++) {
            dormitoryList.add(dormitoryListResponseModel.data![i]);
            dormitoryDropdownList
                .add(dormitoryListResponseModel.data![i].name!);
          }
          dormitoryValue.value = dormitoryList[0];
          dormitoryId.value = dormitoryList[0].id!;
        }
      } else {
        loadingController.isLoading = false;
        showBasicFailedSnackBar(
            message: dormitoryListResponseModel.message ??
                'Something went wrong'.tr);
      }
    } catch (e, t) {
      loadingController.isLoading = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      loadingController.isLoading = false;
    }
    return DormitoryListResponseModel();
  }

  Future<DormitoryRoomTypeResponseModel> getDormitoryRoomType() async {
    try {
      isLoading.value = true;
      final response = await BaseClient().getData(
          url: InfixApi.getAdminRoomType, header: GlobalVariable.header);
      DormitoryRoomTypeResponseModel dormitoryRoomTypeResponseModel =
          DormitoryRoomTypeResponseModel.fromJson(response);

      if (dormitoryRoomTypeResponseModel.success == true) {
        if (dormitoryRoomTypeResponseModel.data!.isNotEmpty) {
          for (int i = 0;
              i < dormitoryRoomTypeResponseModel.data!.length;
              i++) {
            roomTypeList.add(dormitoryRoomTypeResponseModel.data![i]);
          }

          roomTypeValue.value = roomTypeList[0];
          roomTypeId.value = roomTypeList[0].id!;
        }
      } else {
        isLoading.value = false;
        showBasicFailedSnackBar(
            message: dormitoryRoomTypeResponseModel.message ??
                'Something went wrong'.tr);
      }
    } catch (e, t) {
      isLoading.value = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      isLoading.value = false;
    }

    return DormitoryRoomTypeResponseModel();
  }

  void addDormitoryRoom() async {
    try {
      saveLoader.value = true;
      final response = await BaseClient().postData(
        url: InfixApi.addDormitoryRoomFromAdin,
        header: GlobalVariable.header,
        payload: {
          "name": roomNameTextController.text,
          "dormitory_id": dormitoryId.toInt(),
          "room_type_id": roomTypeId.toInt(),
          "number_of_bed": numberOfBedTextController.text,
          "cost_per_bed": costPerBedTextController.text,
          "description": descriptionTextController.text,
        },
      );

      PostRequestResponseModel postRequestResponseModel =
          PostRequestResponseModel.fromJson(response);
      if (postRequestResponseModel.success == true) {
        saveLoader.value = false;
        roomNameTextController.clear();
        numberOfBedTextController.clear();
        costPerBedTextController.clear();
        descriptionTextController.clear();
        showBasicSuccessSnackBar(
            message:
                postRequestResponseModel.message ?? 'Operation Successful'.tr);
      } else {
        saveLoader.value = false;
        showBasicFailedSnackBar(
            message: postRequestResponseModel.message ?? 'Operation Failed'.tr);
      }
    } catch (e, t) {
      saveLoader.value = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      saveLoader.value = false;
    }
  }

  @override
  void onInit() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getDormitoryRoomType();
      getDormitoryList();
    });

    super.onInit();
  }
}
