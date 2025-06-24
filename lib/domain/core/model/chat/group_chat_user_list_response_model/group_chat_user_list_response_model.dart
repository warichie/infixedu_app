class GroupChatUserListResponseModel {
  bool? success;
  List<GroupChatUserListData>? data;
  String? message;

  GroupChatUserListResponseModel({this.success, this.data, this.message});

  GroupChatUserListResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <GroupChatUserListData>[];
      json['data'].forEach((v) {
        data!.add(GroupChatUserListData.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    return data;
  }
}

class GroupChatUserListData {
  String? groupId;
  String? name;
  String? image;
  int? activeStatus;
  String? lastMessage;
  String? lastMessageTime;
  int? countConversation;

  GroupChatUserListData(
      {this.groupId,
      this.name,
      this.image,
      this.activeStatus,
      this.lastMessage,
      this.lastMessageTime,
      this.countConversation});

  GroupChatUserListData.fromJson(Map<String, dynamic> json) {
    groupId = json['group_id'];
    name = json['name'];
    image = json['image'];
    activeStatus = json['active_status'];
    lastMessage = json['last_message'];
    lastMessageTime = json['last_message_time'];
    countConversation = json['count_conversation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['group_id'] = groupId;
    data['name'] = name;
    data['image'] = image;
    data['active_status'] = activeStatus;
    data['last_message'] = lastMessage;
    data['last_message_time'] = lastMessageTime;
    data['count_conversation'] = countConversation;
    return data;
  }
}
