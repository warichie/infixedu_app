class AdminLibraryAddMemberParentsResponseModel {
  bool? success;
  List<AdminLibraryAddMemberParentsData>? data;
  String? message;

  AdminLibraryAddMemberParentsResponseModel(
      {this.success, this.data, this.message});

  AdminLibraryAddMemberParentsResponseModel.fromJson(
      Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <AdminLibraryAddMemberParentsData>[];
      json['data'].forEach((v) {
        data!.add(AdminLibraryAddMemberParentsData.fromJson(v));
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

class AdminLibraryAddMemberParentsData {
  int? id;
  String? name; /// changed parents name to name for using dropdown
  int? userId;

  AdminLibraryAddMemberParentsData({this.id, this.name, this.userId});

  AdminLibraryAddMemberParentsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['parent_name'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['parent_name'] = name;
    data['user_id'] = userId;
    return data;
  }
}
