class SyllabusResponseModel {
  bool? success;
  List<SyllabusList>? data;
  String? message;

  SyllabusResponseModel({this.success, this.data, this.message});

  SyllabusResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <SyllabusList>[];
      json['data'].forEach((v) {
        data!.add(SyllabusList.fromJson(v));
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

class SyllabusList {
  int? id;
  String? uploadDate;
  String? contentTitle;
  String? description;
  String? uploadFile;

  SyllabusList({
    this.id,
    this.uploadDate,
    this.contentTitle,
    this.description,
    this.uploadFile,
  });

  SyllabusList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uploadDate = json['upload_date'];
    contentTitle = json['content_title'];
    description = json['description'];
    uploadFile = json['upload_file'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['upload_date'] = uploadDate;
    data['content_title'] = contentTitle;
    data['description'] = description;
    data['upload_file'] = uploadFile;
    return data;
  }
}
