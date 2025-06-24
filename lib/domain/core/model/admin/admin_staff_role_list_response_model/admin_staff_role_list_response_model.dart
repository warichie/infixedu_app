class AdminStaffRoleListResponseModel {
  bool? success;
  StaffRoleListData? data;
  String? message;

  AdminStaffRoleListResponseModel({this.success, this.data, this.message});

  AdminStaffRoleListResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? StaffRoleListData.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = message;
    return data;
  }
}

class StaffRoleListData {
  List<StaffRolesData>? roles;

  StaffRoleListData({this.roles});

  StaffRoleListData.fromJson(Map<String, dynamic> json) {
    if (json['roles'] != null) {
      roles = <StaffRolesData>[];
      json['roles'].forEach((v) {
        roles!.add(StaffRolesData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (roles != null) {
      data['roles'] = roles!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StaffRolesData {
  int? id;
  String? name;
  String? type;
  int? activeStatus;
  String? createdBy;
  String? updatedBy;
  String? createdAt;
  String? updatedAt;
  int? schoolId;
  int? isSaas;

  StaffRolesData(
      {this.id,
        this.name,
        this.type,
        this.activeStatus,
        this.createdBy,
        this.updatedBy,
        this.createdAt,
        this.updatedAt,
        this.schoolId,
        this.isSaas});

  StaffRolesData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    activeStatus = json['active_status'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    schoolId = json['school_id'];
    isSaas = json['is_saas'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['type'] = type;
    data['active_status'] = activeStatus;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['school_id'] = schoolId;
    data['is_saas'] = isSaas;
    return data;
  }
}
