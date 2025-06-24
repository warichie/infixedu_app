class AdminContentListResponseModel {
  bool? success;
  List<AdminContentData>? data;
  String? message;

  AdminContentListResponseModel({this.success, this.data, this.message});

  AdminContentListResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <AdminContentData>[];
      json['data'].forEach((v) {
        data!.add(AdminContentData.fromJson(v));
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

class AdminContentData {
  int? id;
  String? contentTitle;
  String? contentType;
  String? uploadDate;
  String? availableFor;
  String? contentFile;
  String? uploadFile;

  AdminContentData({
    this.id,
    this.contentTitle,
    this.contentType,
    this.uploadDate,
    this.availableFor,
    this.contentFile,
    this.uploadFile,
  });

  AdminContentData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    contentTitle = json['content_title'];
    contentType = json['content_type'];
    uploadDate = json['upload_date'];
    availableFor = json['available_for'];
    contentFile = json['content_file'];
    uploadFile = json['upload_file'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['content_title'] = contentTitle;
    data['content_type'] = contentType;
    data['upload_date'] = uploadDate;
    data['available_for'] = availableFor;
    data['content_file'] = contentFile;
    data['upload_file'] = uploadFile;
    return data;
  }
}
