class AdminLibraryAddMemberRolesResponseModel {
  bool? success;
  List<AdminAddMemberRoleData>? data;
  String? message;

  AdminLibraryAddMemberRolesResponseModel(
      {this.success, this.data, this.message});

  AdminLibraryAddMemberRolesResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <AdminAddMemberRoleData>[];
      json['data'].forEach((v) {
        data!.add(AdminAddMemberRoleData.fromJson(v));
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

class AdminAddMemberRoleData {
  int? id;
  String? name;

  AdminAddMemberRoleData({this.id, this.name});

  AdminAddMemberRoleData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
