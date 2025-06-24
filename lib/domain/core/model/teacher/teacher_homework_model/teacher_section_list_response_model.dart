class TeacherSectionListResponseModel {
  bool? success;
  List<TeacherSectionListData>? data;
  String? message;

  TeacherSectionListResponseModel({this.success, this.data, this.message});

  TeacherSectionListResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <TeacherSectionListData>[];
      json['data'].forEach((v) {
        data!.add(TeacherSectionListData.fromJson(v));
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

class TeacherSectionListData {
  int? id;
  String? name;  /// Changed section name to name for dropdown

  TeacherSectionListData({this.id, this.name});

  TeacherSectionListData.fromJson(Map<String, dynamic> json) {
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
