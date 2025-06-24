class StudentAssignmentResponseModel {
  bool? success;
  List<StudentAssignmentData>? data;
  String? message;

  StudentAssignmentResponseModel({this.success, this.data, this.message});

  StudentAssignmentResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <StudentAssignmentData>[];
      json['data'].forEach((v) {
        data!.add(StudentAssignmentData.fromJson(v));
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

class StudentAssignmentData {
  int? id;
  String? uploadDate;
  String? contentTitle;
  String? availableFor;
  String? uploadFile;
  String? description;

  StudentAssignmentData(
      {this.id,
      this.uploadDate,
      this.contentTitle,
      this.availableFor,
      this.uploadFile,
      this.description});

  StudentAssignmentData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uploadDate = json['upload_date'];
    contentTitle = json['content_title'];
    availableFor = json['available_for'];
    uploadFile = json['upload_file'];
    description = json['description'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['upload_date'] = uploadDate;
    data['content_title'] = contentTitle;
    data['available_for'] = availableFor;
    data['upload_file'] = uploadFile;
    data['description'] = description;
    return data;
  }
}
