import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infixedu/app/data/constants/app_colors.dart';
import 'package:infixedu/app/data/constants/app_text.dart';
import 'package:infixedu/app/data/constants/app_text_style.dart';
import 'package:infixedu/app/data/constants/image_path.dart';
import 'package:infixedu/app/modules/blocked_users/controllers/blocked_users_controller.dart';
import 'package:infixedu/app/modules/chat/controllers/chat_controller.dart';
import 'package:infixedu/app/modules/chat_search/controllers/chat_search_controller.dart';
import 'package:infixedu/app/modules/chat_search/views/widget/suggested_search_tile.dart';
import 'package:infixedu/app/utilities/app_functions/helper_functions.dart';
import 'package:infixedu/app/utilities/extensions/widget.extensions.dart';
import 'package:infixedu/app/utilities/message/snack_bars.dart';
import 'package:infixedu/config/global_variable/chat/pusher_controller.dart';
import 'package:infixedu/config/global_variable/global_variable_controller.dart';
import 'package:infixedu/domain/base_client/base_client.dart';
import 'package:infixedu/domain/core/model/chat/conversation_model/single_chat_list_response_model.dart';
import 'package:infixedu/domain/core/model/chat/file_list_response_model/file_list_response_model.dart';
import 'package:infixedu/domain/core/model/chat/search_chat_user/search_chat_user.dart';
import 'package:infixedu/domain/core/model/chat/single_chat_user_list_response_model/single_chat_user_list_response_model.dart';
import 'package:infixedu/domain/core/model/post_request_response_model.dart';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import '../../../utilities/api_urls.dart';

class SingleChatController extends GetxController {
  PusherController pusherController = Get.put(PusherController());
  GlobalRxVariableController globalRxVariableController = Get.find();
  BlockedUsersController blockedUsersController =
      Get.put(BlockedUsersController());
  ChatController chatController = Get.find();
  ChatSearchController chatSearchController = Get.put(ChatSearchController());
  TextEditingController sendTextController = TextEditingController();
  TabController? tabController;

  SingleChatUserListData? singleChatUserListData;
  SearchChatData? searchChatData;

  Rx<File> singleChatPickImage = File('').obs;
  RxBool singleChatSendLoader = false.obs;
  RxBool isLoading = false.obs;
  RxBool deleteChatLoader = false.obs;
  RxBool blockLoaded = false.obs;
  RxBool forwardChatLoader = false.obs;
  RxInt toUserId = 0.obs;
  RxInt replyId = 0.obs;
  RxInt messageId = 0.obs;
  RxString userName = "".obs;
  RxString userImage = "".obs;
  RxInt userActiveStatus = 0.obs;
  RxInt tabIndex = 0.obs;
  RxBool isBlocked = false.obs;
  RxList<FileList> singleChatFilesList = <FileList>[].obs;
  RxList<FileList> singleChatImageList = <FileList>[].obs;
  RxBool fileLoader = false.obs;
  RxBool isSearchPage = false.obs;
  RxBool onTapQuote = false.obs;
  RxString quotedText = "".obs;

  List filesList = [
    "Images",
    "Files",
  ];

  RxList<String> userList = <String>[].obs;
  RxList<SingleConversationListData> singleConversationList =
      <SingleConversationListData>[].obs;
  RxList<SingleConversationListData> reversedList =
      <SingleConversationListData>[].obs;

  /// Send a text or image
  Future<SingleChatListResponseModel> singleChatSend() async {
    try {
      singleChatSendLoader.value = true;

      // debugPrint('${Uri.parse(InfixApi.sendSingleChat)}');
      final request =
          http.MultipartRequest('POST', Uri.parse(InfixApi.sendSingleChat));
      request.headers.addAll(GlobalVariable.header);

      if (singleChatPickImage.value.path.isNotEmpty) {
        request.files.add(await http.MultipartFile.fromPath(
            'file_attach', singleChatPickImage.value.path));
      }

      request.fields['message'] = sendTextController.text;
      request.fields['from_user_id'] =
          globalRxVariableController.userId.value.toString();
      request.fields['to_user_id'] = toUserId.value.toString();
      request.fields['reply'] = replyId.value.toString();

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();
      final decodedResponse = json.decode(responseBody);
      debugPrint(decodedResponse.toString());

      SingleChatListResponseModel singleChatListResponseModel =
          SingleChatListResponseModel.fromJson(json.decode(responseBody));

      if (singleChatListResponseModel.success == true) {
        singleChatSendLoader.value = false;
        sendTextController.clear();
        onTapQuote.value = false;
        singleChatPickImage.value = File('');

        singleConversationList.add(singleChatListResponseModel.data!.first);
        singleConversationList.refresh();

        showBasicSuccessSnackBar(message: decodedResponse['message']);
      } else {
        singleChatSendLoader.value = false;
        showBasicFailedSnackBar(message: decodedResponse['message']);
      }
    } catch (e, t) {
      singleChatSendLoader.value = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      singleChatSendLoader.value = false;
      sendTextController.text = '';
      getChatConversationList(userId: toUserId.value);
    }

    return SingleChatListResponseModel();
  }

  /// Get Conversation List
  Future<SingleChatListResponseModel> getChatConversationList(
      {required int userId}) async {
    try {
      isLoading.value = true;

      final response = await BaseClient().postData(
          url: InfixApi.getSingleChatList(userId: userId),
          header: GlobalVariable.header);

      SingleChatListResponseModel singleChatListResponseModel =
          SingleChatListResponseModel.fromJson(response);

      if (singleChatListResponseModel.success == true) {
        isLoading.value = false;

        if (singleChatListResponseModel.data!.isNotEmpty) {
          for (var element in singleChatListResponseModel.data!) {
            singleConversationList.add(element);
          }
        }
      } else {
        isLoading.value = false;
      }
    } catch (e, t) {
      isLoading.value = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      isLoading.value = false;
    }
    return SingleChatListResponseModel();
  }

  /// Get Chat Files
  Future<FileListResponseModel> getSingleChatFileList(
      {required int userId}) async {
    try {
      singleChatFilesList.clear();
      singleChatImageList.clear();
      fileLoader.value = true;
      final response = await BaseClient().getData(
        url: InfixApi.getSingleChatFileList(userID: userId),
        header: GlobalVariable.header,
      );

      FileListResponseModel singleChatFileListResponseModel =
          FileListResponseModel.fromJson(response);

      if (singleChatFileListResponseModel.success == true) {
        fileLoader.value = false;
        if (singleChatFileListResponseModel.data!.isNotEmpty) {
          for (int i = 0;
              i < singleChatFileListResponseModel.data!.length;
              i++) {
            if (HelperFunctions().isExtensionImage(
                singleChatFileListResponseModel.data![i].file!)) {
              singleChatImageList.add(singleChatFileListResponseModel.data![i]);
            } else if (HelperFunctions().isExtensionFile(
                singleChatFileListResponseModel.data![i].file!)) {
              singleChatFilesList.add(singleChatFileListResponseModel.data![i]);
            }
          }
        }
      } else {
        fileLoader.value = false;
        showBasicFailedSnackBar(
          message: singleChatFileListResponseModel.message ??
              AppText.somethingWentWrong.tr,
        );
      }
    } catch (e, t) {
      Get.back();
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      fileLoader.value = false;
    }

    return FileListResponseModel();
  }

  /// Forward message
  Future<void> forwardSingleChat({
    required int userId,
    required int messageId,
    required BuildContext context,
  }) async {
    try {
      ///Show Loader Dialog

      AlertDialog alert = AlertDialog(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconColor: Colors.transparent,
        content: Center(child: Lottie.asset('assets/images/loader.json')),
      );

      showDialog(
        barrierDismissible: false,
        context: context,
        barrierColor: AppColors.secondaryColor.withOpacity(0.15),
        builder: (BuildContext context) {
          return alert;
        },
      );

      forwardChatLoader.value = true;
      final response = await BaseClient().postData(
          url: InfixApi.forwardSingleChat(userId: userId, messageId: messageId),
          header: GlobalVariable.header);
      PostRequestResponseModel postRequestResponseModel =
          PostRequestResponseModel.fromJson(response);

      if (postRequestResponseModel.success == true) {
        forwardChatLoader.value = false;
        Get.back();
        showBasicSuccessSnackBar(
            message: postRequestResponseModel.message ?? 'Chat Forward'.tr);
      } else {
        forwardChatLoader.value = false;
        showBasicFailedSnackBar(
            message:
                postRequestResponseModel.message ?? 'Something went wrong'.tr);
      }
    } catch (e, t) {
      forwardChatLoader.value = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      forwardChatLoader.value = false;
    }
  }

  /// Function to forward a chat
  void forwardChat({required BuildContext context, required int messageId}) {
    Get.dialog(
      Obx(
        () => Material(
          child: SingleChildScrollView(
            child: Column(
              children: [
                30.h.verticalSpacing,
                Row(
                  children: [
                    15.h.horizontalSpacing,
                    InkWell(
                      onTap: () => Get.back(),
                      child: Icon(
                        Platform.isIOS
                            ? Icons.arrow_back_ios
                            : Icons.arrow_back,
                        size: 20.w,
                      ),
                    ),
                    30.w.horizontalSpacing,
                    Text(
                      "Forward Text".tr,
                      style: AppTextStyle.fontSize16lightBlackW500,
                    ),
                  ],
                ),
                20.h.verticalSpacing,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                  child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: chatController.singleChatList.length,
                      itemBuilder: (context, index) {
                        return SuggestedSearchTile(
                          profileImage: ImagePath.editProfileImage,
                          name: chatController.singleChatList[index].fullName,
                          isForward: true,
                          onTapSend: () {
                            forwardSingleChat(
                              userId: chatController.singleChatList[index].id!,
                              messageId: messageId,
                              context: context,
                            );
                          },
                        );
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Delete Single Message
  Future<PostRequestResponseModel> deleteSingleChat(
      {required int messageId, required int index}) async {
    try {
      deleteChatLoader.value = true;
      final response = await BaseClient().postData(
          url: InfixApi.deleteSingleChat(messageId: messageId),
          header: GlobalVariable.header);
      PostRequestResponseModel postRequestResponseModel =
          PostRequestResponseModel.fromJson(response);

      if (postRequestResponseModel.success == true) {
        Get.back();
        int messageIdIndex = reversedList
            .indexWhere((element) => element.messageId == messageId);

        if (messageIdIndex != -1) {
          reversedList.removeAt(messageIdIndex);
          reversedList.refresh();
        }

        int messageIdIndex1 = singleConversationList
            .indexWhere((element) => element.messageId == messageId);

        if (messageIdIndex1 != -1) {
          singleConversationList.removeAt(messageIdIndex1);
          singleConversationList.refresh();
        }

        deleteChatLoader.value = false;

        showBasicSuccessSnackBar(
            message: postRequestResponseModel.message ?? 'Data deleted'.tr);
      } else {
        deleteChatLoader.value = false;
        showBasicFailedSnackBar(
            message: postRequestResponseModel.message ??
                AppText.somethingWentWrong.tr);
      }
    } catch (e, t) {
      deleteChatLoader.value = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      deleteChatLoader.value = false;
    }

    return PostRequestResponseModel();
  }

  void pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx', 'jpg', 'jpeg', 'png', 'txt'],
    );

    if (result != null) {
      singleChatPickImage.value = File(result.files.single.path!);
    } else {
      showBasicFailedSnackBar(message: 'Canceled file selection'.tr);
      debugPrint("User canceled file selection");
    }
  }

  bool validation() {
    if (sendTextController.text.isEmpty &&
        singleChatPickImage.value.path.isEmpty) {
      showBasicFailedSnackBar(message: 'Enter something'.tr);
      return false;
    }
    return true;
  }

  @override
  void onInit() {
    singleChatUserListData = Get.arguments['single_chat_list'];
    isSearchPage.value = Get.arguments["search_chat"] ?? false;

    if (isSearchPage.value == false) {
      toUserId.value = singleChatUserListData!.id!;
      getChatConversationList(userId: toUserId.value);
      pusherController.chatOpenSingle(
        authUserId: globalRxVariableController.userId.value!,
        chatListId: singleChatUserListData!.id!,
      );
    }
    if (isSearchPage.value) {
      searchChatData = Get.arguments['new_chat'];
      toUserId.value = searchChatData!.userId!;
      getChatConversationList(userId: toUserId.value);
      pusherController.chatOpenSingle(
        authUserId: globalRxVariableController.userId.value!,
        chatListId: searchChatData!.userId!,
      );
    }

    super.onInit();
  }
}
