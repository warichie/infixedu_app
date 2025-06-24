import '../notice_list_response_model/notice_list_response_model.dart';

class StudentDocumentsDeleteModel {
  bool? status;
  Data? data;
  String? message;

  StudentDocumentsDeleteModel({
    this.status,
    this.data,
    this.message,
  });

  StudentDocumentsDeleteModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['data'] = this.data;
    data['message'] = message;
    return data;
  }
}
