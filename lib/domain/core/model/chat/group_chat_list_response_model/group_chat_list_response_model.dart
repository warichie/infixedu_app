class GroupChatListResponseModel {
  bool? success;
  List<GroupChatData>? data;
  String? message;

  GroupChatListResponseModel({this.success, this.data, this.message});

  GroupChatListResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <GroupChatData>[];
      json['data'].forEach((v) {
        data!.add(GroupChatData.fromJson(v));
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

class GroupChatData {
  int? threadId;
  int? messageId;
  String? message;
  int? status;
  int? messageType;
  String? file;
  String? originalFileName;
  bool? sender;
  bool? receiver;
  String? replyFor;
  bool? reply;
  bool? forwarded;

  GroupChatData({
    this.threadId,
    this.messageId,
    this.message,
    this.status,
    this.messageType,
    this.file,
    this.originalFileName,
    this.sender,
    this.receiver,
    this.forwarded,
    this.replyFor,
    this.reply,
  });

  GroupChatData.fromJson(Map<String, dynamic> json) {
    threadId = json['thread_id'];
    messageId = json['message_id'];
    message = json['message'];
    status = json['status'];
    messageType = json['message_type'];
    file = json['file'];
    originalFileName = json['original_file_name'];
    sender = json['sender'];
    receiver = json['receiver'];
    forwarded = json['forwarded'];
    replyFor = json['reply_for']?.toString();
    reply = json['reply'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['thread_id'] = threadId;
    data['message_id'] = messageId;
    data['message'] = message;
    data['status'] = status;
    data['message_type'] = messageType;
    data['file'] = file;
    data['original_file_name'] = originalFileName;
    data['sender'] = sender;
    data['receiver'] = receiver;
    data['forwarded'] = forwarded;
    data['reply'] = reply;
    data['reply_for'] = replyFor;
    return data;
  }
}
