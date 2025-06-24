class ChatSettingsResponseModel {
  PermissionSettings? permissionSettings;
  InvitationSettings? invitationSettings;
  ChatSettings? chatSettings;

  ChatSettingsResponseModel(
      {this.permissionSettings, this.invitationSettings, this.chatSettings});

  ChatSettingsResponseModel.fromJson(Map<String, dynamic> json) {
    permissionSettings = json['permission_settings'] != null
        ? PermissionSettings.fromJson(json['permission_settings'])
        : null;
    invitationSettings = json['invitation_settings'] != null
        ? InvitationSettings.fromJson(json['invitation_settings'])
        : null;
    chatSettings = json['chat_settings'] != null
        ? ChatSettings.fromJson(json['chat_settings'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (permissionSettings != null) {
      data['permission_settings'] = permissionSettings!.toJson();
    }
    if (invitationSettings != null) {
      data['invitation_settings'] = invitationSettings!.toJson();
    }
    if (chatSettings != null) {
      data['chat_settings'] = chatSettings!.toJson();
    }
    return data;
  }
}

class PermissionSettings {
  String? chatCanUploadFile;
  String? chatFileLimit;
  String? chatCanMakeGroup;
  String? chatStaffOrTeacherCanBanStudent;
  String? chatTeacherCanPinTopMessage;

  PermissionSettings(
      {this.chatCanUploadFile,
        this.chatFileLimit,
        this.chatCanMakeGroup,
        this.chatStaffOrTeacherCanBanStudent,
        this.chatTeacherCanPinTopMessage});

  PermissionSettings.fromJson(Map<String, dynamic> json) {
    chatCanUploadFile = json['chat_can_upload_file'];
    chatFileLimit = json['chat_file_limit'];
    chatCanMakeGroup = json['chat_can_make_group'];
    chatStaffOrTeacherCanBanStudent =
    json['chat_staff_or_teacher_can_ban_student'];
    chatTeacherCanPinTopMessage = json['chat_teacher_can_pin_top_message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['chat_can_upload_file'] = chatCanUploadFile;
    data['chat_file_limit'] = chatFileLimit;
    data['chat_can_make_group'] = chatCanMakeGroup;
    data['chat_staff_or_teacher_can_ban_student'] =
        chatStaffOrTeacherCanBanStudent;
    data['chat_teacher_can_pin_top_message'] = chatTeacherCanPinTopMessage;
    return data;
  }
}

class InvitationSettings {
  String? chatInvitationRequirement;

  InvitationSettings({this.chatInvitationRequirement});

  InvitationSettings.fromJson(Map<String, dynamic> json) {
    chatInvitationRequirement = json['chat_invitation_requirement'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['chat_invitation_requirement'] = chatInvitationRequirement;
    return data;
  }
}

class ChatSettings {
  String? chatCanTeacherChatWithParents;
  String? chatCanStudentChatWithAdminAccount;
  String? chatAdminCanChatWithoutInvitation;
  String? chatOpen;
  String? method;
  String? pusherAppKey;
  String? pusherAppCluster;
  String? pusherAppSecret;
  String? pusherAppId;

  ChatSettings(
      {this.chatCanTeacherChatWithParents,
        this.chatCanStudentChatWithAdminAccount,
        this.chatAdminCanChatWithoutInvitation,
        this.chatOpen,
        this.method,
        this.pusherAppKey,
        this.pusherAppCluster,
        this.pusherAppSecret,
        this.pusherAppId});

  ChatSettings.fromJson(Map<String, dynamic> json) {
    chatCanTeacherChatWithParents = json['chat_can_teacher_chat_with_parents'];
    chatCanStudentChatWithAdminAccount =
    json['chat_can_student_chat_with_admin_account'];
    chatAdminCanChatWithoutInvitation =
    json['chat_admin_can_chat_without_invitation'];
    chatOpen = json['chat_open'];
    method = json['method'];
    pusherAppKey = json['pusher_app_key'];
    pusherAppCluster = json['pusher_app_cluster'];
    pusherAppSecret = json['pusher_app_secret'];
    pusherAppId = json['pusher_app_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['chat_can_teacher_chat_with_parents'] =
        chatCanTeacherChatWithParents;
    data['chat_can_student_chat_with_admin_account'] =
        chatCanStudentChatWithAdminAccount;
    data['chat_admin_can_chat_without_invitation'] =
        chatAdminCanChatWithoutInvitation;
    data['chat_open'] = chatOpen;
    data['method'] = method;
    data['pusher_app_key'] = pusherAppKey;
    data['pusher_app_cluster'] = pusherAppCluster;
    data['pusher_app_secret'] = pusherAppSecret;
    data['pusher_app_id'] = pusherAppId;
    return data;
  }
}
