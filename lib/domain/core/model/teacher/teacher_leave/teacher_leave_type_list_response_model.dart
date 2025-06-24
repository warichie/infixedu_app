class TeacherLeaveTypeListResponseModel {
  bool? success;
  List<TeacherApplyLeaveTypeData>? data;
  String? message;

  TeacherLeaveTypeListResponseModel({this.success, this.data, this.message});

  TeacherLeaveTypeListResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <TeacherApplyLeaveTypeData>[];
      json['data'].forEach((v) {
        data!.add(TeacherApplyLeaveTypeData.fromJson(v));
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

class TeacherApplyLeaveTypeData {
  int? id;
  String? name;  /// change type to name for dropdown

  TeacherApplyLeaveTypeData({this.id, this.name});

  TeacherApplyLeaveTypeData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['type'] = name;
    return data;
  }
}
