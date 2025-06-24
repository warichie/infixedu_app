class SearchChatUser {
  bool? success;
  List<SearchChatData>? data;
  String? message;

  SearchChatUser({this.success, this.data, this.message});

  SearchChatUser.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <SearchChatData>[];
      json['data'].forEach((v) {
        data!.add(SearchChatData.fromJson(v));
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

class SearchChatData {
  int? userId;
  String? fullName;
  String? image;
  String? activeStatus;
  String? statusColor;
  String? lastMessage;
  String? lastMessageTime;
  int? countConversation;
  bool isSelected = false;
  bool? blocked ;

  SearchChatData(
      {this.userId,
        this.fullName,
        this.image,
        this.activeStatus,
        this.statusColor,
        this.lastMessage,
        this.lastMessageTime,
        this.countConversation,
        this.isSelected = false,
        this.blocked,
      });

  SearchChatData.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    fullName = json['full_name'];
    image = json['image'];
    activeStatus = json['active_status'];
    statusColor = json['status_color'] ?? "0xFFF60003";
    lastMessage = json['last_message'];
    lastMessageTime = json['last_message_time'];
    countConversation = json['count_conversation'];
    blocked = json['blocked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['full_name'] = fullName;
    data['image'] = image;
    data['active_status'] = activeStatus;
    data['status_color'] = statusColor;
    data['last_message'] = lastMessage;
    data['last_message_time'] = lastMessageTime;
    data['count_conversation'] = countConversation;
    data['is_select'] = isSelected;
    data['blocked'] = blocked;

    return data;
  }
}
