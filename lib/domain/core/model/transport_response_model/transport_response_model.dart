class TransportResponseModel {
  bool? success;
  List<TransportDataList>? data;
  String? message;

  TransportResponseModel({this.success, this.data, this.message});

  TransportResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <TransportDataList>[];
      json['data'].forEach((v) {
        data!.add(TransportDataList.fromJson(v));
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

class TransportDataList {
  int? id;
  String? route;
  String? vehicle;
  String? status;
  String? vehicleModel;
  int? made;
  String? driverName;
  String? driverLicense;
  String? driverContact;

  TransportDataList(
      {this.id,
        this.route,
        this.vehicle,
        this.status,
        this.vehicleModel,
        this.made,
        this.driverName,
        this.driverLicense,
        this.driverContact});

  TransportDataList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    route = json['route'];
    vehicle = json['vehicle'];
    status = json['status'];
    vehicleModel = json['vehicle_model'];
    made = json['made'];
    driverName = json['driver_name'];
    driverLicense = json['driver_license'];
    driverContact = json['driver_contact'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['route'] = route;
    data['vehicle'] = vehicle;
    data['status'] = status;
    data['vehicle_model'] = vehicleModel;
    data['made'] = made;
    data['driver_name'] = driverName;
    data['driver_license'] = driverLicense;
    data['driver_contact'] = driverContact;
    return data;
  }
}
