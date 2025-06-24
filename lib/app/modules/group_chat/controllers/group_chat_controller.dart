import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infixedu/app/data/constants/app_colors.dart';
import 'package:infixedu/app/data/constants/app_text.dart';
import 'package:infixedu/app/data/constants/app_text_style.dart';
import 'package:infixedu/app/data/constants/image_path.dart';
import 'package:infixedu/app/modules/chat/controllers/chat_controller.dart';
import 'package:infixedu/app/modules/chat_search/controllers/chat_search_controller.dart';
import 'package:infixedu/app/modules/chat_search/views/widget/suggested_search_tile.dart';
import 'package:infixedu/app/utilities/api_urls.dart';
import 'package:infixedu/app/utilities/app_functions/helper_functions.dart';
import 'package:infixedu/app/utilities/extensions/widget.extensions.dart';
import 'package:infixedu/app/utilities/message/snack_bars.dart';
import 'package:infixedu/app/utilities/widgets/customised_loading_widget/customised_loading_widget.dart';
import 'package:infixedu/config/global_variable/chat/pusher_controller.dart';
import 'package:infixedu/config/global_variable/global_variable_controller.dart';
import 'package:infixedu/domain/base_client/base_client.dart';
import 'package:infixedu/domain/core/model/chat/file_list_response_model/file_list_response_model.dart';
import 'package:infixedu/domain/core/model/chat/group_chat_list_response_model/group_chat_list_response_model.dart';
import 'package:infixedu/domain/core/model/chat/group_chat_member_list_response_model/group_chat_member_list_response_model.dart';
import 'package:infixedu/domain/core/model/post_request_response_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';

import '../../../utilities/widgets/appbar/back_button_widget.dart';

class GroupChatController extends GetxController {
  PusherController pusherController = Get.put(PusherController());
  GlobalRxVariableController globalRxVariableController = Get.find();
  ChatSearchController chatSearchController = Get.put(ChatSearchController());
  TabController? tabController;

  TextEditingController sendTextController = TextEditingController();
  TextEditingController searchTextController = TextEditingController();
  ChatController chatController = Get.find();

  // RxList<GroupChatUserListData> groupChatListData = <GroupChatUserListData>[].obs ;
  RxString chatGroupId = "".obs;
  RxString chatName = "".obs;
  RxString groupImage = "".obs;

  RxList<GroupChatMemberListData> groupChatMemberList =
      <GroupChatMemberListData>[].obs;
  RxList<GroupChatData> groupChatConversationList = <GroupChatData>[].obs;
  RxList<GroupChatData> reversedConversationList = <GroupChatData>[].obs;

  RxList<FileList> groupChatFilesList = <FileList>[].obs;
  RxList<FileList> groupChatImageList = <FileList>[].obs;

  Rx<File> groupChatPickImage = File('').obs;
  RxBool singleChatSendLoader = false.obs;
  RxString groupId = "".obs;
  RxBool groupMemberListLoader = false.obs;
  RxBool groupChatDataLoader = false.obs;
  RxBool fileLoader = false.obs;
  RxInt tabIndex = 0.obs;
  RxBool onTapQuote = false.obs;
  RxString quotedText = "".obs;
  RxInt replyId = (-1).obs;
  RxBool deleteChatLoader = false.obs;
  RxBool forwardChatLoader = false.obs;
  RxBool addMemberLoader = false.obs;

  RxBool checkboxSelect = false.obs;

  RxList<String> userList = <String>[].obs;

  List filesList = [
    "Images",
    "Files",
  ];

  /// Pick a file for sending
  void pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx', 'jpg', 'jpeg', 'png', 'txt'],
    );

    if (result != null) {
      groupChatPickImage.value = File(result.files.single.path!);
    } else {
      showBasicFailedSnackBar(message: 'Canceled file selection'.tr);
      debugPrint("User canceled file selection");
    }
  }

  /// Clear check box data
  void clearCheckboxData() {
    for (var element in chatSearchController.searchChatDataList) {
      element.isSelected = false;
    }

    chatSearchController.searchChatDataList.refresh();
  }

  /// Group chat Member List
  Future<GroupChatMemberListResponseModel?> getGroupChatMemberList(
      {required String groupId}) async {
    groupChatMemberList.clear();
    try {
      groupMemberListLoader.value = true;

      final response = await BaseClient().getData(
        url: InfixApi.getGroupChatMemberList(groupId: groupId),
        header: GlobalVariable.header,
      );

      GroupChatMemberListResponseModel groupChatMemberListResponseModel =
          GroupChatMemberListResponseModel.fromJson(response);
      if (groupChatMemberListResponseModel.success == true) {
        groupMemberListLoader.value = false;
        if (groupChatMemberListResponseModel.data!.isNotEmpty) {
          for (int i = 0;
              i < groupChatMemberListResponseModel.data!.length;
              i++) {
            groupChatMemberList.add(groupChatMemberListResponseModel.data![i]);
          }
        }
      } else {
        groupMemberListLoader.value = false;
        showBasicFailedSnackBar(
          message: groupChatMemberListResponseModel.message ??
              AppText.somethingWentWrong.tr,
        );
      }
    } catch (e, t) {
      groupMemberListLoader.value = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      groupMemberListLoader.value = false;
    }
    return GroupChatMemberListResponseModel();
  }

  /// Group Conversation
  Future<GroupChatListResponseModel?> getGroupChatList(
      {required String groupId}) async {
    try {
      groupChatDataLoader.value = true;

      final response = await BaseClient().getData(
        url: InfixApi.getGroupChatList(groupId: groupId),
        header: GlobalVariable.header,
      );

      GroupChatListResponseModel groupChatListResponseModel =
          GroupChatListResponseModel.fromJson(response);
      if (groupChatListResponseModel.success == true) {
        groupChatDataLoader.value = false;
        if (groupChatListResponseModel.data!.isNotEmpty) {
          for (int i = 0; i < groupChatListResponseModel.data!.length; i++) {
            groupChatConversationList.add(groupChatListResponseModel.data![i]);
          }
        }
      } else {
        groupChatDataLoader.value = false;
        showBasicFailedSnackBar(
          message: groupChatListResponseModel.message ??
              AppText.somethingWentWrong.tr,
        );
      }
    } catch (e, t) {
      groupChatDataLoader.value = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      groupChatDataLoader.value = false;
    }
    return GroupChatListResponseModel();
  }

  /// Group Add Member
  Future<void> groupAddMember(
      {required String groupId, required List<String> userList}) async {
    try {
      addMemberLoader.value = true;
      final response = await BaseClient().postData(
          url: InfixApi.groupAddMember,
          payload: {
            "group_id": groupId,
            "user_id": userList,
          },
          header: GlobalVariable.header);
      PostRequestResponseModel postRequestResponseModel =
          PostRequestResponseModel.fromJson(response);

      if (postRequestResponseModel.success == true) {
        addMemberLoader.value = false;
        const SecondaryLoadingWidget();
        userList.clear();
        Get.back();
        showBasicSuccessSnackBar(
            message: postRequestResponseModel.message ?? 'Member Added'.tr);
      } else {
        addMemberLoader.value = false;
        showBasicFailedSnackBar(
            message:
                postRequestResponseModel.message ?? 'Something went wrong'.tr);
      }
    } catch (e, t) {
      addMemberLoader.value = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      addMemberLoader.value = false;
    }
  }

  /// Group Member Leave
  Future<void> groupLeaveMember({required String groupId}) async {
    try {
      addMemberLoader.value = true;
      final response = await BaseClient().postData(
          url: InfixApi.groupLeaveMember(groupId: groupId),
          header: GlobalVariable.header);
      PostRequestResponseModel postRequestResponseModel =
          PostRequestResponseModel.fromJson(response);

      if (postRequestResponseModel.success == true) {
        addMemberLoader.value = false;

        const SecondaryLoadingWidget();
        chatController.groupChatList
            .removeWhere((element) => element.groupId == groupId);
        chatController.groupChatList.refresh();

        Get.back();
        showBasicSuccessSnackBar(
            message: postRequestResponseModel.message ?? 'Group Leave'.tr);
      } else {
        addMemberLoader.value = false;
        showBasicFailedSnackBar(
            message:
                postRequestResponseModel.message ?? 'Something went wrong'.tr);
      }
    } catch (e, t) {
      addMemberLoader.value = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      addMemberLoader.value = false;
    }
  }

  /// Group delete group
  Future<void> groupDelete({required String groupId}) async {
    try {
      addMemberLoader.value = true;
      final response = await BaseClient().postData(
          url: InfixApi.groupDelete(groupId: groupId),
          header: GlobalVariable.header);
      PostRequestResponseModel postRequestResponseModel =
          PostRequestResponseModel.fromJson(response);

      if (postRequestResponseModel.success == true) {
        addMemberLoader.value = false;

        const SecondaryLoadingWidget();
        chatController.groupChatList
            .removeWhere((element) => element.groupId == groupId);
        chatController.groupChatList.refresh();

        Get.back();
        showBasicSuccessSnackBar(
            message: postRequestResponseModel.message ?? 'Group Deleted'.tr);
      } else {
        addMemberLoader.value = false;
        showBasicFailedSnackBar(
            message:
                postRequestResponseModel.message ?? 'Something went wrong'.tr);
      }
    } catch (e, t) {
      addMemberLoader.value = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      addMemberLoader.value = false;
    }
  }

  /// Group chat Send a Text or File
  Future<GroupChatListResponseModel> groupChatSend() async {
    try {
      singleChatSendLoader.value = true;

      final request =
          http.MultipartRequest('POST', Uri.parse(InfixApi.sendGroupChat));
      request.headers.addAll(GlobalVariable.header);

      if (groupChatPickImage.value.path.isNotEmpty) {
        request.files.add(await http.MultipartFile.fromPath(
            'file_attach', groupChatPickImage.value.path));
      }

      request.fields['message'] = sendTextController.text;
      request.fields['user_id'] =
          globalRxVariableController.userId.value.toString();
      request.fields['group_id'] = groupId.value;
      request.fields['reply'] = replyId.value.toString();

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();
      final decodedResponse = json.decode(responseBody);
      debugPrint(decodedResponse.toString());

      GroupChatListResponseModel groupChatListResponseModel =
          GroupChatListResponseModel.fromJson(json.decode(responseBody));

      if (groupChatListResponseModel.success == true) {
        singleChatSendLoader.value = false;
        sendTextController.clear();
        groupChatPickImage.value = File('');
        onTapQuote.value = false;

        groupChatConversationList.add(groupChatListResponseModel.data!.first);
        groupChatConversationList.refresh();
        chatController.getGroupChatList();
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
    }

    return GroupChatListResponseModel();
  }

  /// Delete Single Message
  Future<void> deleteSingleChat(
      {required int threadId, required int index}) async {
    try {
      deleteChatLoader.value = true;
      final response = await BaseClient().postData(
          url: InfixApi.groupDeleteSingleChat(threadId: threadId),
          header: GlobalVariable.header);
      PostRequestResponseModel postRequestResponseModel =
          PostRequestResponseModel.fromJson(response);

      if (postRequestResponseModel.success == true) {
        deleteChatLoader.value = false;
        Get.back();
        int messageIdIndex = reversedConversationList
            .indexWhere((element) => element.threadId == threadId);

        if (messageIdIndex != -1) {
          reversedConversationList.removeAt(messageIdIndex);
          reversedConversationList.refresh();
        }

        int messageIdIndex1 = groupChatConversationList
            .indexWhere((element) => element.threadId == threadId);

        if (messageIdIndex1 != -1) {
          groupChatConversationList.removeAt(messageIdIndex1);
          groupChatConversationList.refresh();
        }
        showBasicSuccessSnackBar(
            message: postRequestResponseModel.message ?? 'Data deleted'.tr);
      } else {
        deleteChatLoader.value = false;
        showBasicFailedSnackBar(
            message:
                postRequestResponseModel.message ?? 'Something went wrong'.tr);
      }
    } catch (e, t) {
      deleteChatLoader.value = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      deleteChatLoader.value = false;
    }
  }

  /// Forward a message
  Future<void> forwardSingleChat({
    required String groupId,
    required int messageId,
    required String message,
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
          url: InfixApi.forwardGroupChat,
          payload: {
            "group_id": groupId,
            "message_id": messageId,
            "message": message,
            // "user_id": toGroupId,
          },
          header: GlobalVariable.header);
      PostRequestResponseModel postRequestResponseModel =
          PostRequestResponseModel.fromJson(response);

      if (postRequestResponseModel.success == true) {
        forwardChatLoader.value = false;
        Get.back();
        showBasicSuccessSnackBar(
            message: postRequestResponseModel.message ??
                'Text Forward Successfully');
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

  /// Remove a member from group
  Future<void> removeSingleMemberFromGroup(
      {required String groupId,
      required int userId,
      required int index,
      required BuildContext context}) async {
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

      final response = await BaseClient().postData(
          url:
              "${InfixApi.baseApi}admin-group-member-delete?group_id=$groupId&user_id=$userId",
          header: GlobalVariable.header);
      PostRequestResponseModel postRequestResponseModel =
          PostRequestResponseModel.fromJson(response);

      if (postRequestResponseModel.success == true) {
        groupChatMemberList.removeAt(index);
        groupChatMemberList.refresh();
        Get.back();
        showBasicSuccessSnackBar(
            message: postRequestResponseModel.message ?? 'Member removed'.tr);
      } else {
        showBasicFailedSnackBar(
            message:
                postRequestResponseModel.message ?? 'Something went wrong'.tr);
      }
    } catch (e, t) {
      debugPrint('$e');
      debugPrint('$t');
    } finally {}
  }

  /// Validation before sending a text
  bool validation() {
    if (sendTextController.text.isEmpty &&
        groupChatPickImage.value.path.isEmpty) {
      showBasicFailedSnackBar(message: 'Enter something'.tr);
      return false;
    }
    return true;
  }

  void forwardChat(
      {required BuildContext context,
      required int messageId,
      required String message}) {
    Get.dialog(
      Obx(
        () => Material(
          child: SingleChildScrollView(
            child: Column(
              children: [
                30.h.verticalSpacing,
                Row(
                  children: [
                    15.w.horizontalSpacing,
                    BackButtonWidget(
                      color: Colors.black,
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
                      itemCount: chatController.groupChatList.length,
                      itemBuilder: (context, index) {
                        return SuggestedSearchTile(
                          profileImage: ImagePath.editProfileImage,
                          name: chatController.groupChatList[index].name,
                          isForward: true,
                          onTapSend: () {
                            forwardSingleChat(
                                groupId: chatController
                                    .groupChatList[index].groupId!,
                                messageId: messageId,
                                message: message,
                                context: context);
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

  /// Get Chat Files
  Future<FileListResponseModel> getGroupChatFileList(
      {required String groupId}) async {
    try {
      groupChatFilesList.clear();
      groupChatImageList.clear();
      fileLoader.value = true;
      final response = await BaseClient().getData(
        url: InfixApi.getGroupChatFileList(groupId: groupId),
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
              groupChatImageList.add(singleChatFileListResponseModel.data![i]);
            } else if (HelperFunctions().isExtensionFile(
                singleChatFileListResponseModel.data![i].file!)) {
              groupChatFilesList.add(singleChatFileListResponseModel.data![i]);
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

  @override
  void onInit() {
    groupId.value = Get.arguments["group_id"];
    chatName.value = Get.arguments["name"];
    // groupImage.value = Get.arguments["image"];
    getGroupChatList(groupId: groupId.value);
    pusherController.chatOpenGroup(
      authUserId: globalRxVariableController.userId.value!,
      chatListId: groupId.value,
    );

    // getGroupChatMemberList(groupId: groupId.value);

    super.onInit();
  }
}
