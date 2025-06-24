class AdminVehicleListResponseModel {
  bool? success;
  List<AdminVehicleData>? data;
  String? message;

  AdminVehicleListResponseModel({this.success, this.data, this.message});

  AdminVehicleListResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <AdminVehicleData>[];
      json['data'].forEach((v) {
        data!.add(AdminVehicleData.fromJson(v));
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

class AdminVehicleData {
  int? id;
  String? vehicleModel;
  String? vehicleNo;
  int? madeYear;
  String? note;

  AdminVehicleData({this.id, this.vehicleModel, this.vehicleNo, this.madeYear, this.note});

  AdminVehicleData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vehicleModel = json['vehicle_model'];
    vehicleNo = json['vehicle_no'];
    madeYear = json['made_year'];
    note = json['note'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['vehicle_model'] = vehicleModel;
    data['vehicle_no'] = vehicleNo;
    data['made_year'] = madeYear;
    data['note'] = note;
    return data;
  }
}
