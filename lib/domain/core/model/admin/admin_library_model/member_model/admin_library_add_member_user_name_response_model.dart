class AdminLibraryAddMemberUserNameResponseModel {
  bool? success;
  List<AdminAddMemberUserNameData>? data;
  String? message;

  AdminLibraryAddMemberUserNameResponseModel(
      {this.success, this.data, this.message});

  AdminLibraryAddMemberUserNameResponseModel.fromJson(
      Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <AdminAddMemberUserNameData>[];
      json['data'].forEach((v) {
        data!.add(AdminAddMemberUserNameData.fromJson(v));
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

class AdminAddMemberUserNameData {
  int? id;
  String? name; /// Changed it to name from full name for dropdown issue
  int? userId;

  AdminAddMemberUserNameData({this.id, this.name, this.userId});

  AdminAddMemberUserNameData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['full_name'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['full_name'] = name;
    data['user_id'] = userId;
    return data;
  }
}
