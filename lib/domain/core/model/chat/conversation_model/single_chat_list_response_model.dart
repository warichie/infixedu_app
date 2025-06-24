class SingleChatListResponseModel {
  bool? success;
  List<SingleConversationListData>? data;
  String? message;

  SingleChatListResponseModel({this.success, this.data, this.message});

  SingleChatListResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <SingleConversationListData>[];
      json['data'].forEach((v) {
        data!.add(SingleConversationListData.fromJson(v));
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

class SingleConversationListData {
  int? messageId;
  String? message;
  int? status;
  int? messageType;
  String? file;
  String? originalFileName;
  String? replyFor;
  bool? reply;
  bool? sender;
  bool? receiver;
  bool? forwarded;

  SingleConversationListData(
      {this.messageId,
        this.message,
        this.status,
        this.messageType,
        this.file,
        this.originalFileName,
        this.reply,
        this.sender,
        this.receiver,
        this.forwarded,
        this.replyFor,
      });

  SingleConversationListData.fromJson(Map<String, dynamic> json) {
    messageId = json['message_id'];
    message = json['message'];
    status = json['status'];
    messageType = json['message_type'];
    file = json['file'];
    originalFileName = json['original_file_name'];
    reply = json['reply'];
    sender = json['sender'];
    receiver = json['receiver'];
    forwarded = json['forwarded'];
    replyFor= json['reply_for'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message_id'] = messageId;
    data['message'] = message;
    data['status'] = status;
    data['message_type'] = messageType;
    data['file'] = file;
    data['original_file_name'] = originalFileName;
    data['reply'] = reply;
    data['sender'] = sender;
    data['receiver'] = receiver;
    data['forwarded'] = forwarded;
    data['reply_for'] = replyFor;
    return data;
  }
}
