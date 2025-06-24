class AdminVehicleDriverResponseModel {
  bool? success;
  List<AdminVehicleDriverData>? data;
  String? message;

  AdminVehicleDriverResponseModel({this.success, this.data, this.message});

  AdminVehicleDriverResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <AdminVehicleDriverData>[];
      json['data'].forEach((v) {
        data!.add(AdminVehicleDriverData.fromJson(v));
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

/// Rename fullName -> name for dropdown
class AdminVehicleDriverData {
  int? id;
  String? name;

  AdminVehicleDriverData({this.id, this.name});

  AdminVehicleDriverData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['full_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['full_name'] = name;
    return data;
  }
}
