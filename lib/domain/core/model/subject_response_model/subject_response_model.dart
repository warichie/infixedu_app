class SubjectResponseModel {
  bool? status;
  List<SubjectListData>? data;
  String? message;

  SubjectResponseModel({this.status, this.data, this.message});

  SubjectResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['success'];
    if (json['data'] != null) {
      data = <SubjectListData>[];
      json['data'].forEach((v) {
        data!.add(SubjectListData.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    return data;
  }
}

class SubjectListData {
  int? id;
  String? subject;
  String? teacher;
  String? type;

  SubjectListData({this.id, this.subject, this.teacher, this.type});

  SubjectListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subject = json['subject'];
    teacher = json['teacher'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['subject'] = subject;
    data['teacher'] = teacher;
    data['type'] = type;
    return data;
  }
}
