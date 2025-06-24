class StudentSectionListResponseModel {
  bool? success;
  List<SectionListData>? data;
  String? message;

  StudentSectionListResponseModel({this.success, this.data, this.message});

  StudentSectionListResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <SectionListData>[];
      json['data'].forEach((v) {
        data!.add(SectionListData.fromJson(v));
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

class SectionListData {
  int? id;
  String? name; /// sectionName => name

  SectionListData({this.id, this.name});

  SectionListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['section_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['section_name'] = name;
    return data;
  }
}
