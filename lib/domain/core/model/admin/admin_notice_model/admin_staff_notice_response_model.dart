class AdminStaffNoticeResponseModel {
  bool? success;
  List<AdminStaffNoticeData>? data;
  String? message;

  AdminStaffNoticeResponseModel({this.success, this.data, this.message});

  AdminStaffNoticeResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <AdminStaffNoticeData>[];
      json['data'].forEach((v) {
        data!.add(AdminStaffNoticeData.fromJson(v));
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

class AdminStaffNoticeData {
  int? id;
  String? noticeTitle;
  String? noticeDate;
  String? noticeMessage;

  AdminStaffNoticeData({this.id, this.noticeTitle, this.noticeDate, this.noticeMessage});

  AdminStaffNoticeData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    noticeTitle = json['notice_title'];
    noticeDate = json['notice_date'];
    noticeMessage = json['notice_message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['notice_title'] = noticeTitle;
    data['notice_date'] = noticeDate;
    data['notice_message'] = noticeMessage;
    return data;
  }
}
