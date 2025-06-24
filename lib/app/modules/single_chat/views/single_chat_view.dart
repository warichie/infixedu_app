import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infixedu/app/data/constants/app_colors.dart';
import 'package:infixedu/app/data/constants/image_path.dart';
import 'package:infixedu/app/modules/single_chat/views/widget/chat_text_tile.dart';
import 'package:infixedu/app/modules/single_chat/views/widget/files_popup_dialog.dart';
import 'package:infixedu/app/modules/single_chat/views/widget/popup_action_menu.dart';
import 'package:infixedu/app/modules/single_chat/views/widget/quote_text.dart';
import 'package:infixedu/app/utilities/extensions/widget.extensions.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/text_field.dart';
import 'package:infixedu/app/utilities/widgets/customised_loading_widget/customised_loading_widget.dart';
import 'package:infixedu/app/utilities/widgets/no_data_available/no_data_available_widget.dart';
import 'package:infixedu/app/utilities/widgets/popup_item_tile/popup_item_tile.dart';
import 'package:get/get.dart';
import '../../../data/constants/app_text_style.dart';
import '../../../service/image/image_picker_utils.dart';
import '../controllers/single_chat_controller.dart';

class SingleChatView extends GetView<SingleChatController> {
  const SingleChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => InfixEduScaffold(
        appBarHeight: 80,
        appBar: Padding(
          padding:
              const EdgeInsets.only(top: 40.0, bottom: 20, left: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  10.w.horizontalSpacing,
                  // InkWell(
                  //     onTap: () {
                  //       Get.back();
                  //       controller.chatController.singleChatList.clear();
                  //       controller.reversedList.clear();
                  //       controller.singleConversationList.clear();
                  //
                  //       controller.reversedList.clear();
                  //
                  //       controller.chatController.getSingleChatList();
                  //     },
                  //     child: const Icon(
                  //       Icons.arrow_back,
                  //       color: Colors.white,
                  //     )),

                  InkWell(
                    onTap: () {
                      Get.back();
                      controller.chatController.singleChatList.clear();
                      controller.chatController.getSingleChatList();
                      controller.reversedList.clear();
                      controller.singleConversationList.clear();
                      controller.reversedList.clear();
                    },
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
                  Stack(
                    alignment: AlignmentDirectional.center,
                    children: <Widget>[
                      Container(
                        height: 50.w,
                        width: 50.w,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: NetworkImage(controller.isSearchPage.value
                                  ? controller.searchChatData!.image!
                                  : controller.singleChatUserListData!.image!),
                              fit: BoxFit.cover),
                        ),
                      ),
                      Positioned(
                        right: 3.w,
                        top: 6.h,
                        child: Container(
                          height: 8.w,
                          width: 8.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: controller.isSearchPage.value
                                ? Color(
                                    int.parse(controller
                                        .searchChatData!.statusColor!),
                                  )
                                : Color(
                                    int.parse(controller
                                        .singleChatUserListData!.statusColor!),
                                  ),
                          ),
                        ), //Icon
                      ),
                    ], //<Widget>[]
                  ),
                  10.w.horizontalSpacing,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        controller.isSearchPage.value
                            ? controller.searchChatData!.fullName!
                            : controller.singleChatUserListData!.fullName ?? "",
                        style: AppTextStyle.cardTextStyle14WhiteW500,
                      ),
                      3.h.verticalSpacing,
                      Text(
                        controller.isSearchPage.value
                            ? controller.searchChatData!.activeStatus
                                .toString()
                                .tr
                            : controller
                                .singleChatUserListData!.activeStatus!.tr,
                        style: TextStyle(
                          color: controller.isSearchPage.value
                              ? Color(
                                  int.parse(
                                      controller.searchChatData!.statusColor!),
                                )
                              : Color(
                                  int.parse(controller
                                      .singleChatUserListData!.statusColor!),
                                ),
                          fontSize: 12.sp,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              PopupMenuButton(
                padding: EdgeInsets.zero,
                color: Colors.white,
                iconColor: Colors.white,
                icon: Icon(
                  Icons.more_vert_sharp,
                  size: 16.w,
                ),
                onSelected: (v) {
                  if (v == 1) {
                    controller.getSingleChatFileList(
                        userId: controller.isSearchPage.value
                            ? controller.searchChatData!.userId!
                            : controller.singleChatUserListData!.id!);
                    Get.dialog(Material(
                      child: Obx(
                        () => FilesPopupDialog(
                          tabBarLength: controller.filesList.length,
                          tabController: controller.tabController,
                          tabs: List.generate(
                            controller.filesList.length,
                            (index) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Text(
                                  ("${controller.filesList[index] ?? ''}".tr)),
                            ),
                          ),
                          imageWidget: controller.fileLoader.value
                              ? const SecondaryLoadingWidget()
                              : GridView.builder(
                                  shrinkWrap: true,
                                  itemCount:
                                      controller.singleChatImageList.length,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                  ),
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 1,
                                              color:
                                                  AppColors.borderColorEAE7F0),
                                          image: DecorationImage(
                                              image: NetworkImage(controller
                                                      .singleChatImageList[
                                                          index]
                                                      .file ??
                                                  ""),
                                              fit: BoxFit.cover),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                          fileWidget: ListView.builder(
                              itemCount: controller.singleChatFilesList.length,
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
                                            borderRadius:
                                                const BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              bottomLeft: Radius.circular(10),
                                            ),
                                            color: AppColors
                                                .transportDividerColor
                                                .withOpacity(0.8),
                                          ),
                                          child: Image.asset(
                                            ImagePath.adminFees,
                                            scale: 4,
                                            color: Colors.black,
                                          ),
                                        ),
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
                  if (v == 2) {
                    if (controller.isSearchPage.value == false) {
                      controller.blockedUsersController.blockSingleUser(
                          type: controller.singleChatUserListData!.blocked!
                              ? ""
                              : "block",
                          userId: controller.singleChatUserListData!.id!);
                    }
                    if (controller.isSearchPage.value) {
                      controller.blockedUsersController.blockSingleUser(
                          type: controller.searchChatData!.blocked!
                              ? ""
                              : "block",
                          userId: controller.searchChatData!.userId!);
                    }
                  }
                },
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 1,
                    height: 40.h,
                    child: PopupItemTile(title: "Files".tr),
                  ),
                  PopupMenuItem(
                    value: 2,
                    height: 40.h,
                    child: controller.isSearchPage.value
                        ? controller.searchChatData!.blocked!
                            ? PopupItemTile(title: "Unblock User".tr)
                            : PopupItemTile(title: "Block User".tr)
                        : controller.singleChatUserListData!.blocked!
                            ? PopupItemTile(title: "Unblock User".tr)
                            : PopupItemTile(title: "Block User".tr),
                  ),
                ],
              ),
            ],
          ),
        ),
        // titleWidget:
        body: CustomBackground(
          customWidget: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              controller.isLoading.value
                  ? const Expanded(child: SecondaryLoadingWidget())
                  : controller.singleConversationList.isNotEmpty
                      ? Expanded(
                          child: ListView.builder(
                            reverse: true,
                            shrinkWrap: true,
                            itemCount: controller.singleConversationList.length,
                            itemBuilder: (context, index) {
                              controller.reversedList.value = List.from(
                                controller.singleConversationList.reversed,
                              );
                              return Column(
                                crossAxisAlignment:
                                    controller.reversedList[index].sender ==
                                            true
                                        ? CrossAxisAlignment.end
                                        : CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: controller.reversedList[index]
                                                    .sender ==
                                                true
                                            ? 60.w
                                            : 0,
                                        right: controller.reversedList[index]
                                                    .sender ==
                                                true
                                            ? 0
                                            : 60.w),
                                    child: Row(
                                      mainAxisAlignment: controller
                                                  .reversedList[index].sender ==
                                              true
                                          ? MainAxisAlignment.end
                                          : MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        //// Sender Side
                                        controller.reversedList[index].sender ==
                                                true
                                            ? InkWell(
                                                onTap: () {
                                                  Get.dialog(
                                                    Material(
                                                      color: Colors.transparent,
                                                      child: PopupActionMenu(
                                                        positionRight: 20.w,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .end,
                                                        text: controller
                                                            .reversedList[index]
                                                            .message,
                                                        imageUrl: controller
                                                                .reversedList[
                                                                    index]
                                                                .file ??
                                                            "",
                                                        color: controller
                                                                    .reversedList[
                                                                        index]
                                                                    .sender ==
                                                                true
                                                            ? AppColors
                                                                .primaryColor
                                                            : AppColors
                                                                .homeworkWidgetColor,
                                                        textStyle: controller
                                                                    .reversedList[
                                                                        index]
                                                                    .sender ==
                                                                true
                                                            ? AppTextStyle
                                                                .textStyle12WhiteW400
                                                            : AppTextStyle
                                                                .fontSize12W400ReceivedText,
                                                        radiusBottomLeft: controller
                                                                    .reversedList[
                                                                        index]
                                                                    .sender ==
                                                                true
                                                            ? 20.w
                                                            : 0,
                                                        radiusBottomRight: controller
                                                                    .reversedList[
                                                                        index]
                                                                    .sender ==
                                                                true
                                                            ? 0
                                                            : 20.w,
                                                        onDeleteTap: () {
                                                          controller.deleteSingleChat(
                                                              messageId: controller
                                                                  .reversedList[
                                                                      index]
                                                                  .messageId!,
                                                              index: index);
                                                        },
                                                        onForwardTap: () {
                                                          controller
                                                              .forwardChat(
                                                            messageId: controller
                                                                .reversedList[
                                                                    index]
                                                                .messageId!,
                                                            context: context,
                                                          );
                                                        },
                                                        onQuoteTap: () {
                                                          Get.back();
                                                          controller.quotedText
                                                              .value = controller
                                                                  .reversedList[
                                                                      index]
                                                                  .message ??
                                                              "";
                                                          controller.onTapQuote
                                                              .value = true;
                                                          controller.replyId
                                                                  .value =
                                                              controller
                                                                  .reversedList[
                                                                      index]
                                                                  .messageId!;
                                                        },
                                                        isReceiver: controller
                                                            .reversedList[index]
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

                                        /// Main Chat Screen
                                        Flexible(
                                          child: ChatTextTile(
                                            text: controller.reversedList[index]
                                                    .message ??
                                                "",
                                            color: controller
                                                        .reversedList[index]
                                                        .sender ==
                                                    true
                                                ? AppColors.primaryColor
                                                : AppColors.homeworkWidgetColor,
                                            forwardImageBackgroundColor:
                                                controller.reversedList[index]
                                                            .sender ==
                                                        true
                                                    ? AppColors.primaryColor
                                                    : AppColors
                                                        .homeworkWidgetColor,
                                            textStyle: controller
                                                        .reversedList[index]
                                                        .sender ==
                                                    true
                                                ? AppTextStyle
                                                    .textStyle12WhiteW400
                                                : AppTextStyle
                                                    .fontSize12W400ReceivedText,
                                            forwardedTextStyle: controller
                                                        .reversedList[index]
                                                        .sender ==
                                                    true
                                                ? AppTextStyle
                                                    .chatTextStyle12WhiteW400
                                                : AppTextStyle
                                                    .fontSize12W400ReceivedText,
                                            radiusBottomLeft: controller
                                                        .reversedList[index]
                                                        .sender ==
                                                    true
                                                ? 20.w
                                                : 0,
                                            radiusBottomRight: controller
                                                        .reversedList[index]
                                                        .sender ==
                                                    true
                                                ? 0
                                                : 20.w,
                                            textLeftPadding: controller
                                                        .reversedList[index]
                                                        .sender ==
                                                    true
                                                ? 0
                                                : 10.w,
                                            textRightPadding: controller
                                                        .reversedList[index]
                                                        .sender ==
                                                    true
                                                ? 10.w
                                                : 0,
                                            imageUrl: controller
                                                    .reversedList[index].file ??
                                                "",
                                            isForwardedText: controller
                                                    .reversedList[index]
                                                    .forwarded ??
                                                false,
                                            isQuotedText: controller
                                                .reversedList[index].reply!,
                                            quotedText: controller
                                                .reversedList[index].replyFor,
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
                                                                        .reversedList[
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

                                        /// Receiver side Icon Button
                                        controller.reversedList[index].sender ==
                                                false
                                            ? InkWell(
                                                onTap: () {
                                                  Get.dialog(Material(
                                                    color: Colors.transparent,
                                                    child: PopupActionMenu(
                                                      positionLeft: 20.w,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      text: controller
                                                          .reversedList[index]
                                                          .message,
                                                      color: controller
                                                                  .reversedList[
                                                                      index]
                                                                  .sender ==
                                                              true
                                                          ? AppColors
                                                              .primaryColor
                                                          : AppColors
                                                              .homeworkWidgetColor,
                                                      textStyle: controller
                                                                  .reversedList[
                                                                      index]
                                                                  .sender ==
                                                              true
                                                          ? AppTextStyle
                                                              .textStyle12WhiteW400
                                                          : AppTextStyle
                                                              .fontSize12W400ReceivedText,
                                                      radiusBottomLeft: controller
                                                                  .reversedList[
                                                                      index]
                                                                  .sender ==
                                                              true
                                                          ? 30.w
                                                          : 0,
                                                      radiusBottomRight: controller
                                                                  .reversedList[
                                                                      index]
                                                                  .sender ==
                                                              true
                                                          ? 0
                                                          : 30.w,
                                                      onForwardTap: () {
                                                        controller.forwardChat(
                                                          messageId: controller
                                                              .reversedList[
                                                                  index]
                                                              .messageId!,
                                                          context: context,
                                                        );
                                                      },
                                                      onQuoteTap: () {
                                                        Get.back();
                                                        controller.quotedText
                                                            .value = controller
                                                                .reversedList[
                                                                    index]
                                                                .message ??
                                                            "";
                                                        controller.onTapQuote
                                                            .value = true;
                                                        controller
                                                                .replyId.value =
                                                            controller
                                                                .reversedList[
                                                                    index]
                                                                .messageId!;
                                                      },
                                                      isReceiver: controller
                                                          .reversedList[index]
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
                      : const Expanded(
                          child: SingleChildScrollView(
                            child: NoDataAvailableWidget(),
                          ),
                        ),

              /// Message type section
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
                          controller.singleChatPickImage.value.path.isNotEmpty
                              ? Row(
                                  children: [
                                    Image.file(
                                      height: 60.h,
                                      width: 80.w,
                                      File(controller
                                          .singleChatPickImage.value.path),
                                      fit: BoxFit.cover,
                                    ),
                                    5.w.horizontalSpacing,
                                    InkWell(
                                      onTap: () {
                                        controller.singleChatPickImage.value =
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
                          controller.searchChatData?.blocked == true ||
                                  controller.singleChatUserListData?.blocked ==
                                      true
                              ? SizedBox(
                                  width: Get.width,
                                  child: Center(
                                    child: Text(
                                      "You can't reply to this conversation".tr,
                                      style:
                                          AppTextStyle.fontSize16lightBlackW500,
                                    ),
                                  ),
                                )
                              : Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        FlutterImagePickerUtils
                                            .imagePickerModalSheet(
                                          context: context,
                                          fromGallery: () async {
                                            controller
                                                    .singleChatPickImage.value =
                                                await FlutterImagePickerUtils
                                                    .getImageGallery(
                                              context,
                                            );
                                          },
                                          fromCamera: () async {
                                            controller
                                                    .singleChatPickImage.value =
                                                await FlutterImagePickerUtils
                                                    .getImageCamera(
                                              context,
                                            );
                                          },
                                        );
                                      },
                                      child: Image.asset(
                                        ImagePath.camera,
                                        color: AppColors
                                            .editProfileTextFieldLabelColor,
                                        width: 20.w,
                                      ),
                                    ),
                                    10.w.horizontalSpacing,
                                    const SizedBox(
                                      height: 30,
                                      child: VerticalDivider(
                                        color: AppColors.dividerColor,
                                      ),
                                    ),
                                    Expanded(
                                      child: CustomTextFormField(
                                        inputBorder: InputBorder.none,
                                        hintTextStyle:
                                            AppTextStyle.homeworkElements,
                                        hintText: "${"Type something".tr}...",
                                        controller:
                                            controller.sendTextController,
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        if (controller.validation()) {
                                          controller.singleChatSend().then(
                                            (value) {
                                              controller.singleChatPickImage
                                                  .value = File('');
                                              controller.onTapQuote.value =
                                                  false;
                                              controller.replyId.value = 0;
                                            },
                                          );
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
                                                color: AppColors.primaryColor),
                                          ],
                                        ),
                                        child: Center(
                                          child: controller
                                                  .singleChatSendLoader.isTrue
                                              ? const CircularProgressIndicator(
                                                  color: Colors.white,
                                                )
                                              : Image.asset(
                                                  ImagePath.send,
                                                  scale: 2.5,
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
