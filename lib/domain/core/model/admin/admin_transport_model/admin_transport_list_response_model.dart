class AdminTransportListResponseModel {
  bool? success;
  List<AdminTransportData>? data;
  String? message;

  AdminTransportListResponseModel({this.success, this.data, this.message});

  AdminTransportListResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <AdminTransportData>[];
      json['data'].forEach((v) {
        data!.add(AdminTransportData.fromJson(v));
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

class AdminTransportData {
  int? id;
  String? routeName;
  String? vehicleNo;
  int? madeYear;
  String? vehicleModel;
  String? driverName;
  String? drivingLicense;
  String? driverContactNo;

  AdminTransportData({
    this.id,
    this.routeName,
    this.vehicleNo,
    this.madeYear,
    this.vehicleModel,
    this.driverName,
    this.drivingLicense,
    this.driverContactNo,
  });

  AdminTransportData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    routeName = json['route_name'];
    vehicleNo = json['vehicle_no'];
    madeYear = json['made_year'];
    vehicleModel = json['vehicle_model'];
    driverName = json['driver_name'];
    drivingLicense = json['driving_license'];
    driverContactNo = json['driver_contact_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['route_name'] = routeName;
    data['vehicle_no'] = vehicleNo;
    data['made_year'] = madeYear;
    data['vehicle_model'] = vehicleModel;
    data['driver_name'] = driverName;
    data['driving_license'] = drivingLicense;
    data['driver_contact_no'] = driverContactNo;
    return data;
  }
}
