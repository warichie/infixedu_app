class NoticeListResponseModel {
  bool? success;
  Data? data;
  String? message;

  NoticeListResponseModel({this.success, this.data, this.message});

  NoticeListResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = message;
    return data;
  }
}

class Data {
  List<AllNotices>? allNotices;

  Data({this.allNotices});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['allNotices'] != null) {
      allNotices = <AllNotices>[];
      json['allNotices'].forEach((v) {
        allNotices!.add(AllNotices.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (allNotices != null) {
      data['allNotices'] = allNotices!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AllNotices {
  int? id;
  String? noticeTitle;
  String? noticeMessage;
  String? publishOn;

  AllNotices({this.id, this.noticeTitle, this.noticeMessage, this.publishOn});

  AllNotices.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    noticeTitle = json['notice_title'];
    noticeMessage = json['notice_message'];
    publishOn = json['publish_on'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['notice_title'] = noticeTitle;
    data['notice_message'] = noticeMessage;
    data['publish_on'] = publishOn;
    return data;
  }
}
