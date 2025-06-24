class AdminLibraryAddMemberSectionResponseModel {
  bool? success;
  List<AdminAddMemberSectionData>? data;
  String? message;

  AdminLibraryAddMemberSectionResponseModel(
      {this.success, this.data, this.message});

  AdminLibraryAddMemberSectionResponseModel.fromJson(
      Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <AdminAddMemberSectionData>[];
      json['data'].forEach((v) {
        data!.add(AdminAddMemberSectionData.fromJson(v));
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

class AdminAddMemberSectionData {
  int? id;
  String? name; /// changed section section name to name

  AdminAddMemberSectionData({this.id, this.name});

  AdminAddMemberSectionData.fromJson(Map<String, dynamic> json) {
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
