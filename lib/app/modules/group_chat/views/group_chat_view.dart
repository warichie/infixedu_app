import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infixedu/app/data/constants/app_colors.dart';
import 'package:infixedu/app/data/constants/app_text_style.dart';
import 'package:infixedu/app/data/constants/image_path.dart';
import 'package:infixedu/app/modules/chat_search/views/widget/suggested_search_tile.dart';
import 'package:infixedu/app/modules/group_chat/views/widget/group_chat_helper.dart';
import 'package:infixedu/app/modules/group_chat/views/widget/selecting_member.dart';
import 'package:infixedu/app/modules/single_chat/views/widget/chat_text_tile.dart';
import 'package:infixedu/app/modules/single_chat/views/widget/files_popup_dialog.dart';
import 'package:infixedu/app/modules/single_chat/views/widget/popup_action_menu.dart';
import 'package:infixedu/app/modules/single_chat/views/widget/quote_text.dart';
import 'package:infixedu/app/service/image/image_picker_utils.dart';
import 'package:infixedu/app/utilities/extensions/widget.extensions.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/text_field.dart';
import 'package:infixedu/app/utilities/widgets/customised_loading_widget/customised_loading_widget.dart';
import 'package:infixedu/app/utilities/widgets/no_data_available/no_data_available_widget.dart';
import 'package:get/get.dart';
import '../controllers/group_chat_controller.dart';

class GroupChatView extends GetView<GroupChatController> {
  const GroupChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => InfixEduScaffold(
        appBarHeight: 80,
        appBar: Padding(
          padding:
              const EdgeInsets.only(top: 80.0, bottom: 20, left: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () => Get.back(),
                      child: Container(
                        color: Colors.transparent,
                        margin: ScreenUtil().deviceType(Get.context!) ==
                                DeviceType.tablet
                            ? EdgeInsets.only(right: 5.w)
                            : null,
                        height: 40,
                        width: 40,
                        child: Platform.isAndroid
                            ? Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                                size: 17.w,
                              )
                            : Icon(Icons.arrow_back_ios_new_outlined,
                                color: Colors.white, size: 17.w),
                      ),
                    ),
                    15.w.horizontalSpacing,
                    Flexible(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          controller.groupImage.value.isNotEmpty
                              ? Container(
                                  height: 20,
                                  width: 20,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            controller.groupImage.value),
                                        filterQuality: FilterQuality.high),
                                  ),
                                )
                              : Container(
                                  height: Get.height * 0.15,
                                  width: Get.width * 0.12,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: AssetImage(ImagePath.dp),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                          10.h.horizontalSpacing,
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  controller.chatName.value,
                                  maxLines: 1,
                                  overflow: TextOverflow.clip,
                                  style: AppTextStyle.cardTextStyle14WhiteW500,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(child: Container()),
              GroupChatHelper().popupMenu(onTap: (v) async {
                /// Add People
                if (v == 1) {
                  Get.dialog(Material(
                    child: Obx(
                      () => SingleChildScrollView(
                        child: Column(
                          children: [
                            SelectingMember(
                              searchTextController:
                                  controller.searchTextController,
                              onChange: (searchKey) {
                                controller
                                    .chatSearchController.searchChatDataList
                                    .clear();
                                controller.chatSearchController
                                    .getSearchChat(searchKey);
                              },
                              onAddButtonTap: controller.userList.isEmpty
                                  ? null
                                  : () {
                                      controller.groupAddMember(
                                          groupId: controller.groupId.value,
                                          userList: controller.userList);
                                      controller.clearCheckboxData();
                                      controller.searchTextController.clear();
                                    },
                              textStyle: controller.userList.isEmpty
                                  ? AppTextStyle.fontSize13GreyW300
                                  : AppTextStyle.blackFontSize14W400,
                              backOnTap: () {
                                controller.clearCheckboxData();
                                controller.searchTextController.clear();
                                Get.back();
                              },
                            ),
                            20.h.verticalSpacing,
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: controller.chatSearchController
                                          .searchLoader.value ||
                                      controller.addMemberLoader.value
                                  ? const SecondaryLoadingWidget()
                                  : controller
                                          .searchTextController.text.isNotEmpty
                                      ? ListView.builder(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: controller
                                              .chatSearchController
                                              .searchChatDataList
                                              .length,
                                          itemBuilder: (context, index) {
                                            return SuggestedSearchTile(
                                              profileImage:
                                                  ImagePath.editProfileImage,
                                              name: controller
                                                  .chatSearchController
                                                  .searchChatDataList[index]
                                                  .fullName,
                                              onTap: () {},
                                              checkboxValue: controller
                                                  .chatSearchController
                                                  .searchChatDataList[index]
                                                  .isSelected,
                                              onCheckboxTap: (bool? value) {
                                                controller
                                                        .chatSearchController
                                                        .searchChatDataList[index]
                                                        .isSelected =
                                                    !controller
                                                        .chatSearchController
                                                        .searchChatDataList[
                                                            index]
                                                        .isSelected;
                                                controller.chatSearchController
                                                    .searchChatDataList
                                                    .refresh();
                                                if (controller
                                                        .chatSearchController
                                                        .searchChatDataList[
                                                            index]
                                                        .isSelected ==
                                                    true) {
                                                  controller.userList.add(
                                                      controller
                                                          .chatSearchController
                                                          .searchChatDataList[
                                                              index]
                                                          .userId
                                                          .toString());
                                                }

                                                if (controller
                                                        .chatSearchController
                                                        .searchChatDataList[
                                                            index]
                                                        .isSelected ==
                                                    false) {
                                                  controller.userList.remove(
                                                      controller
                                                          .chatSearchController
                                                          .searchChatDataList[
                                                              index]
                                                          .userId
                                                          .toString());
                                                }
                                              },
                                            );
                                          })
                                      : const Center(
                                          child: NoDataAvailableWidget(),
                                        ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ));
                }

                /// File

                else if (v == 2) {
                  controller.getGroupChatFileList(
                    groupId: controller.groupId.value,
                  );
                  Get.dialog(Material(
                    child: Obx(
                      () => FilesPopupDialog(
                        tabBarLength: controller.filesList.length,
                        tabController: controller.tabController,
                        tabs: List.generate(
                          controller.filesList.length,
                          (index) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child:
                                Text("${controller.filesList[index] ?? ''}".tr),
                          ),
                        ),
                        imageWidget: controller.fileLoader.value
                            ? const SecondaryLoadingWidget()
                            : GridView.builder(
                                shrinkWrap: true,
                                itemCount: controller.groupChatImageList.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                ),
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(controller
                                                    .groupChatImageList[index]
                                                    .file ??
                                                ""),
                                            fit: BoxFit.cover),
                                      ),
                                    ),
                                  );
                                },
                              ),
                        fileWidget: ListView.builder(
                            itemCount: controller.groupChatFilesList.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0, vertical: 10),
                                child: Container(
                                  height: Get.height * 0.1,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: AppColors.transportDividerColor
                                        .withOpacity(0.4),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: Get.width * 0.15,
                                        height: Get.height * 0.1,
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            bottomLeft: Radius.circular(10),
                                          ),
                                          color: AppColors.transportDividerColor
                                              .withOpacity(0.8),
                                        ),
                                        child: Image.asset(
                                          ImagePath.adminFees,
                                          scale: 4,
                                          color: Colors.black,
                                        ),
                                      ),
                                      30.horizontalSpacing,
                                      Text(
                                        controller.groupChatFilesList[index]
                                            .originalFileName!,
                                        style: AppTextStyle.fontSize13BlackW400,
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }),
                        onTap: (index) {
                          controller.tabIndex.value = index;
                        },
                      ),
                    ),
                  ));
                }

                /// Member List
                else if (v == 3) {
                  await controller.getGroupChatMemberList(
                      groupId: controller.groupId.value);

                  GroupChatHelper().showGroupMemberListBottomSheet(
                    header: "Members".tr,
                    bottomSheetBackgroundColor: Colors.white,
                  );
                }

                /// Delete Group

                else if (v == 4) {
                  controller.groupDelete(groupId: controller.groupId.value);
                }

                /// Group Leave
                else if (v == 5) {
                  controller.groupLeaveMember(
                      groupId: controller.groupId.value);
                }
              })
            ],
          ),
        ),
        // titleWidget:
        body: CustomBackground(
          customWidget: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              controller.groupChatDataLoader.value
                  ? const Expanded(child: SecondaryLoadingWidget())
                  : controller.groupChatConversationList.isNotEmpty
                      ? Expanded(
                          child: ListView.builder(
                            reverse: true,
                            shrinkWrap: true,
                            itemCount:
                                controller.groupChatConversationList.length,
                            itemBuilder: (context, index) {
                              controller.reversedConversationList.value =
                                  List.from(controller
                                      .groupChatConversationList.reversed);
                              return Column(
                                crossAxisAlignment: controller
                                            .reversedConversationList[index]
                                            .sender ==
                                        true
                                    ? CrossAxisAlignment.end
                                    : CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: controller
                                                    .reversedConversationList[
                                                        index]
                                                    .sender ==
                                                true
                                            ? 60.w
                                            : 0,
                                        right: controller
                                                    .reversedConversationList[
                                                        index]
                                                    .sender ==
                                                true
                                            ? 0
                                            : 60.w),
                                    child: Row(
                                      mainAxisAlignment: controller
                                                  .reversedConversationList[
                                                      index]
                                                  .sender ==
                                              true
                                          ? MainAxisAlignment.end
                                          : MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        controller
                                                    .reversedConversationList[
                                                        index]
                                                    .sender ==
                                                true
                                            ? InkWell(
                                                onTap: () {
                                                  Get.dialog(
                                                    Material(
                                                      color: Colors.transparent,
                                                      child: PopupActionMenu(
                                                        positionRight: 20.w,
                                                        // isDisableForwarding: false,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .end,
                                                        text: controller
                                                            .reversedConversationList[
                                                                index]
                                                            .message,
                                                        imageUrl: controller
                                                                .reversedConversationList[
                                                                    index]
                                                                .file ??
                                                            "",
                                                        color: controller
                                                                    .reversedConversationList[
                                                                        index]
                                                                    .sender ==
                                                                true
                                                            ? AppColors
                                                                .primaryColor
                                                            : AppColors
                                                                .homeworkWidgetColor,
                                                        textStyle: controller
                                                                    .reversedConversationList[
                                                                        index]
                                                                    .sender ==
                                                                true
                                                            ? AppTextStyle
                                                                .textStyle12WhiteW400
                                                            : AppTextStyle
                                                                .fontSize12W400ReceivedText,
                                                        radiusBottomLeft: controller
                                                                    .reversedConversationList[
                                                                        index]
                                                                    .sender ==
                                                                true
                                                            ? 20.w
                                                            : 0,
                                                        radiusBottomRight: controller
                                                                    .reversedConversationList[
                                                                        index]
                                                                    .sender ==
                                                                true
                                                            ? 0
                                                            : 20.w,
                                                        onDeleteTap: () {
                                                          controller.deleteSingleChat(
                                                              threadId: controller
                                                                  .reversedConversationList[
                                                                      index]
                                                                  .threadId!,
                                                              index: index);
                                                        },
                                                        onForwardTap: () {
                                                          controller.forwardChat(
                                                              context: context,
                                                              messageId: controller
                                                                  .reversedConversationList[
                                                                      index]
                                                                  .messageId!,
                                                              message: controller
                                                                      .reversedConversationList[
                                                                          index]
                                                                      .message ??
                                                                  "");
                                                        },
                                                        onQuoteTap: () {
                                                          Get.back();
                                                          controller.quotedText
                                                              .value = controller
                                                                  .reversedConversationList[
                                                                      index]
                                                                  .message ??
                                                              "";
                                                          controller.onTapQuote
                                                              .value = true;
                                                          controller.replyId
                                                                  .value =
                                                              controller
                                                                  .reversedConversationList[
                                                                      index]
                                                                  .messageId!;
                                                        },
                                                        isReceiver: controller
                                                            .reversedConversationList[
                                                                index]
                                                            .receiver!,
                                                      ),
                                                    ),
                                                  );
                                                },
                                                child: Icon(
                                                  Icons.more_vert,
                                                  size: 16.h,
                                                ),
                                              )
                                            : const SizedBox(),
                                        Flexible(
                                          child: ChatTextTile(
                                            text: controller
                                                    .reversedConversationList[
                                                        index]
                                                    .message ??
                                                "",
                                            color: controller
                                                        .reversedConversationList[
                                                            index]
                                                        .sender ==
                                                    true
                                                ? AppColors.primaryColor
                                                : AppColors.homeworkWidgetColor,
                                            forwardImageBackgroundColor: controller
                                                        .reversedConversationList[
                                                            index]
                                                        .sender ==
                                                    true
                                                ? AppColors.primaryColor
                                                : AppColors.homeworkWidgetColor,
                                            textStyle: controller
                                                        .reversedConversationList[
                                                            index]
                                                        .sender ==
                                                    true
                                                ? AppTextStyle
                                                    .textStyle12WhiteW400
                                                : AppTextStyle
                                                    .fontSize12W400ReceivedText,
                                            radiusBottomLeft: controller
                                                        .reversedConversationList[
                                                            index]
                                                        .sender ==
                                                    true
                                                ? 20.w
                                                : 0,
                                            radiusBottomRight: controller
                                                        .reversedConversationList[
                                                            index]
                                                        .sender ==
                                                    true
                                                ? 0
                                                : 20.w,
                                            textLeftPadding: controller
                                                        .reversedConversationList[
                                                            index]
                                                        .sender ==
                                                    true
                                                ? 0
                                                : 10.w,
                                            textRightPadding: controller
                                                        .reversedConversationList[
                                                            index]
                                                        .sender ==
                                                    true
                                                ? 10.w
                                                : 0,
                                            imageUrl: controller
                                                    .reversedConversationList[
                                                        index]
                                                    .file ??
                                                "",
                                            isForwardedText: controller
                                                    .reversedConversationList[
                                                        index]
                                                    .forwarded ??
                                                false,
                                            isQuotedText: controller
                                                .reversedConversationList[index]
                                                .reply!,
                                            quotedText: controller
                                                .reversedConversationList[index]
                                                .replyFor,
                                            onImageTap: () {
                                              Get.dialog(
                                                Material(
                                                  color: Colors.transparent,
                                                  child: InkWell(
                                                    onTap: () => Get.back(),
                                                    child: Stack(
                                                      alignment:
                                                          AlignmentDirectional
                                                              .center,
                                                      children: [
                                                        Expanded(
                                                          child: InkWell(
                                                            onTap: () =>
                                                                Get.back(),
                                                            child:
                                                                Positioned.fill(
                                                              child:
                                                                  BackdropFilter(
                                                                filter:
                                                                    ImageFilter
                                                                        .blur(
                                                                  sigmaX: 10,
                                                                  sigmaY: 10,
                                                                ),
                                                                child:
                                                                    Container(
                                                                  color: Colors
                                                                      .black12,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          height:
                                                              Get.height * 0.7,
                                                          width:
                                                              Get.width * 0.7,
                                                          decoration:
                                                              BoxDecoration(
                                                            image:
                                                                DecorationImage(
                                                              image:
                                                                  NetworkImage(
                                                                controller
                                                                        .reversedConversationList[
                                                                            index]
                                                                        .file ??
                                                                    "",
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                        controller
                                                    .reversedConversationList[
                                                        index]
                                                    .sender ==
                                                false
                                            ? InkWell(
                                                onTap: () {
                                                  Get.dialog(Material(
                                                    color: Colors.transparent,
                                                    child: PopupActionMenu(
                                                      // isDisableForwarding: false,
                                                      positionLeft: 20.w,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      text: controller
                                                          .reversedConversationList[
                                                              index]
                                                          .message,
                                                      color: controller
                                                                  .reversedConversationList[
                                                                      index]
                                                                  .sender ==
                                                              true
                                                          ? AppColors
                                                              .primaryColor
                                                          : AppColors
                                                              .homeworkWidgetColor,
                                                      textStyle: controller
                                                                  .reversedConversationList[
                                                                      index]
                                                                  .sender ==
                                                              true
                                                          ? AppTextStyle
                                                              .textStyle12WhiteW400
                                                          : AppTextStyle
                                                              .fontSize12W400ReceivedText,
                                                      radiusBottomLeft: controller
                                                                  .reversedConversationList[
                                                                      index]
                                                                  .sender ==
                                                              true
                                                          ? 30.w
                                                          : 0,
                                                      radiusBottomRight: controller
                                                                  .reversedConversationList[
                                                                      index]
                                                                  .sender ==
                                                              true
                                                          ? 0
                                                          : 30.w,
                                                      onForwardTap: () {
                                                        controller.forwardChat(
                                                            context: context,
                                                            messageId: controller
                                                                .reversedConversationList[
                                                                    index]
                                                                .messageId!,
                                                            message: controller
                                                                    .reversedConversationList[
                                                                        index]
                                                                    .message ??
                                                                "");
                                                      },
                                                      onQuoteTap: () {
                                                        Get.back();
                                                        controller.quotedText
                                                            .value = controller
                                                                .reversedConversationList[
                                                                    index]
                                                                .message ??
                                                            "";
                                                        controller.onTapQuote
                                                            .value = true;
                                                        controller
                                                                .replyId.value =
                                                            controller
                                                                .reversedConversationList[
                                                                    index]
                                                                .messageId!;
                                                      },
                                                      isReceiver: controller
                                                          .reversedConversationList[
                                                              index]
                                                          .receiver!,
                                                    ),
                                                  ));
                                                },
                                                child: Icon(
                                                  Icons.more_vert,
                                                  size: 16.h,
                                                ),
                                              )
                                            : const SizedBox(),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        )
                      : Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                NoDataAvailableWidget(
                                  message: "No message available".tr,
                                ),
                              ],
                            ),
                          ),
                        ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0.w),
                child: Container(
                  padding: EdgeInsets.all(15.w),
                  color: const Color(0xFFFDFBFF),
                  child: SingleChildScrollView(
                    child: Obx(
                      () => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          controller.onTapQuote.value
                              ? QuoteText(
                                  repliedText: controller.quotedText.value == ""
                                      ? "Attachment"
                                      : controller.quotedText.value,
                                )
                              : const SizedBox(),
                          controller.groupChatPickImage.value.path.isNotEmpty
                              ? Row(
                                  children: [
                                    Image.file(
                                      height: 60.h,
                                      width: 80.w,
                                      File(controller
                                          .groupChatPickImage.value.path),
                                      fit: BoxFit.cover,
                                    ),
                                    5.w.horizontalSpacing,
                                    InkWell(
                                      onTap: () {
                                        controller.groupChatPickImage.value =
                                            File('');
                                      },
                                      child: Icon(
                                        Icons.clear,
                                        color: AppColors.primaryColor,
                                        size: 16.h,
                                      ),
                                    ),
                                  ],
                                )
                              : const SizedBox(),
                          10.h.verticalSpacing,
                          Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  FlutterImagePickerUtils.imagePickerModalSheet(
                                    context: context,
                                    fromGallery: () async {
                                      controller.groupChatPickImage.value =
                                          await FlutterImagePickerUtils
                                              .getImageGallery(
                                        context,
                                      );
                                    },
                                    fromCamera: () async {
                                      controller.groupChatPickImage.value =
                                          await FlutterImagePickerUtils
                                              .getImageCamera(
                                        context,
                                      );
                                    },
                                  );
                                },
                                child: Image.asset(
                                  ImagePath.camera,
                                  color:
                                      AppColors.editProfileTextFieldLabelColor,
                                  width: 20.w,
                                ),
                              ),
                              10.h.horizontalSpacing,
                              SizedBox(
                                height: 30.h,
                                child: VerticalDivider(
                                  color: AppColors.dividerColor,
                                ),
                              ),
                              Expanded(
                                child: CustomTextFormField(
                                  inputBorder: InputBorder.none,
                                  hintTextStyle: AppTextStyle.homeworkElements,
                                  hintText: "${"Type something".tr}...",
                                  controller: controller.sendTextController,
                                ),
                              ),
                              Obx(
                                () => InkWell(
                                  onTap: () {
                                    if (controller.singleChatSendLoader.value) {
                                      return;
                                    }
                                    if (controller.validation()) {
                                      controller.groupChatSend();
                                    }
                                  },
                                  child: Container(
                                    height: 45,
                                    width: 45,
                                    padding: const EdgeInsets.all(5),
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.primaryColor,
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 5,
                                          spreadRadius: 1,
                                          color: AppColors.primaryColor,
                                        ),
                                      ],
                                    ),
                                    child: Center(
                                      child: controller
                                              .singleChatSendLoader.value
                                          ? CircularProgressIndicator(
                                              strokeWidth: 2.5,
                                              valueColor:
                                                  AlwaysStoppedAnimation<Color>(
                                                      Colors.white),
                                            )
                                          : Image.asset(
                                              ImagePath.send,
                                              scale: 2.5,
                                            ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
