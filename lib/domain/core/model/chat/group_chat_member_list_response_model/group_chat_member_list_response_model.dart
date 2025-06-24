class GroupChatMemberListResponseModel {
  bool? success;
  List<GroupChatMemberListData>? data;
  String? message;

  GroupChatMemberListResponseModel({this.success, this.data, this.message});

  GroupChatMemberListResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <GroupChatMemberListData>[];
      json['data'].forEach((v) {
        data!.add(GroupChatMemberListData.fromJson(v));
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

class GroupChatMemberListData {
  int? userId;
  String? fullName;
  String? image;

  GroupChatMemberListData({this.userId, this.fullName, this.image});

  GroupChatMemberListData.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    fullName = json['full_name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['full_name'] = fullName;
    data['image'] = image;
    return data;
  }
}
