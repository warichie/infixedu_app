class DormitoryResponseModel {
  bool? success;
  List<DormitoryData>? data;
  String? message;

  DormitoryResponseModel({this.success, this.data, this.message});

  DormitoryResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <DormitoryData>[];
      json['data'].forEach((v) {
        data!.add(DormitoryData.fromJson(v));
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

class DormitoryData {
  int? id;
  String? dormitoryName;
  String? roomNumber;
  String? roomType;
  int? numberOfBed;
  int? costPerBed;
  String? status;

  DormitoryData(
      {this.id,
        this.dormitoryName,
        this.roomNumber,
        this.roomType,
        this.numberOfBed,
        this.costPerBed,
        this.status});

  DormitoryData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dormitoryName = json['dormitory_name'];
    roomNumber = json['room_number'];
    roomType = json['room_type'];
    numberOfBed = json['number_of_bed'];
    costPerBed = json['cost_per_bed'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['dormitory_name'] = dormitoryName;
    data['room_number'] = roomNumber;
    data['room_type'] = roomType;
    data['number_of_bed'] = numberOfBed;
    data['cost_per_bed'] = costPerBed;
    data['status'] = status;
    return data;
  }
}
