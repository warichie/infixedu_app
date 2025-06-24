// import 'dart:convert';
//
// import '../../utils/json_utils.dart';
//
// class ProfileModelUI {
//   num id;
//   String fullName;
//   String phoneNumber;
//   int roleId;
//   int schoolId;
//   String isAdministrator;
//   int rtlLtl;
//   String firstName;
//   String avatarUrl;
//   bool blockedByMe;
//
//
//   ProfileModelUI({
//     required this.id,
//     required this.fullName,
//     required this.phoneNumber,
//     required this.roleId,
//     required this.schoolId,
//     required this.isAdministrator,
//     required this.rtlLtl,
//     required this.firstName,
//     required this.avatarUrl,
//     required this.blockedByMe,
//   });
//
//   factory ProfileModelUI.fromJson(Map<String, dynamic> j) => ProfileModelUI(
//     id: getSafeValue<num>(j, 'id', 0),
//     fullName: getSafeValue<String>(j, 'full_name', ''),
//     phoneNumber: getSafeValue<String>(j, 'phone_number', ''),
//     roleId: getSafeValue<int>(j, 'role_id', 0),
//     schoolId: getSafeValue<int>(j, 'school_id', 0),
//     isAdministrator: getSafeValue<String>(j, 'is_administrator', ''),
//     rtlLtl: getSafeValue<int>(j, 'rtl_ltl', 0),
//     firstName: getSafeValue<String>(j, 'first_name', ''),
//     avatarUrl: getSafeValue<String>(j, 'avatar_url', ''),
//     blockedByMe: getSafeValue<bool>(j, 'blocked_by_me', false),
//   );
//
//   Map<String, dynamic> toJson() {
//     final data = <String, dynamic>{};
//     data['id'] = id;
//     data['full_name'] = fullName;
//     data['phone_number'] = phoneNumber;
//     data['role_id'] = roleId;
//     data['school_id'] = schoolId;
//     data['is_administrator'] = isAdministrator;
//     data['rtl_ltl'] = rtlLtl;
//     data['first_name'] = firstName;
//     data['avatar_url'] = avatarUrl;
//     data['blocked_by_me'] = blockedByMe;
//     return data;
//   }
//
//   @override
//   String toString() => const JsonEncoder.withIndent(' ').convert(toJson());
// }
//



// To parse this JSON data, do
//
//     final profileInfoModel = profileInfoModelFromJson(jsonString);

import 'dart:convert';

import '../../utils/json_utils.dart';

ProfileInfoModel profileInfoModelFromJson(String str) => ProfileInfoModel.fromJson(json.decode(str));

String profileInfoModelToJson(ProfileInfoModel data) => json.encode(data.toJson());

class ProfileInfoModel {
  bool success;
  Data data;
  String message;

  ProfileInfoModel({
    required this.success,
    required this.data,
    required this.message,
  });

  factory ProfileInfoModel.fromJson(Map<String, dynamic> json) => ProfileInfoModel(
    success: json["success"],
    data: Data.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data.toJson(),
    "message": message,
  };
}

class Data {
  int unreadNotifications;
  User user;
  String ttlRtlStatus;
  String accessToken;

  Data({
    required this.unreadNotifications,
    required this.user,
    required this.ttlRtlStatus,
    required this.accessToken,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    unreadNotifications: json["unread_notifications"],
    user: User.fromJson(json["user"]),
    ttlRtlStatus: json["TTL_RTL_status"],
    accessToken: json["accessToken"],
  );

  Map<String, dynamic> toJson() => {
    "unread_notifications": unreadNotifications,
    "user": user.toJson(),
    "TTL_RTL_status": ttlRtlStatus,
    "accessToken": accessToken,
  };
}

class User {
  int id;
  String fullName;
  String email;
  String phoneNumber;
  int roleId;
  int schoolId;
  String isAdministrator;
  int rtlLtl;
  String firstName;
  String avatarUrl;
  bool blockedByMe;
  int studentId;
  int parentId;
  int staffId;

  User({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.roleId,
    required this.schoolId,
    required this.isAdministrator,
    required this.rtlLtl,
    required this.firstName,
    required this.avatarUrl,
    required this.blockedByMe,
    required this.studentId,
    required this.parentId,
    required this.staffId,
  });

    factory User.fromJson(Map<String, dynamic> j) => User(
    id: getSafeValue<int>(j, 'id', 0),
    fullName: getSafeValue<String>(j, 'full_name', ''),
    email: getSafeValue<String>(j, 'email', ''),
    phoneNumber: getSafeValue<String>(j, 'phone_number', ''),
    roleId: getSafeValue<int>(j, 'role_id', 0),
    schoolId: getSafeValue<int>(j, 'school_id', 0),
    isAdministrator: getSafeValue<String>(j, 'is_administrator', ''),
    rtlLtl: getSafeValue<int>(j, 'rtl_ltl', 0),
    firstName: getSafeValue<String>(j, 'first_name', ''),
    avatarUrl: getSafeValue<String>(j, 'avatar_url', ''),
    blockedByMe: getSafeValue<bool>(j, 'blocked_by_me', false),
    studentId: getSafeValue<int>(j, 'student_id', 0),
    parentId: getSafeValue<int>(j, 'parent_id', 0),
    staffId: getSafeValue<int>(j, 'staff_id', 0),
  );

  // factory User.fromJson(Map<String, dynamic> json) => User(
  //   id: json["id"] ?? 0,
  //   fullName: json["full_name"] ?? '',
  //   phoneNumber: json["phone_number"] ?? '',
  //   roleId: json["role_id"] ?? '',
  //   schoolId: json["school_id"] ?? '',
  //   isAdministrator: json["is_administrator"] ?? '',
  //   rtlLtl: json["rtl_ltl"] ?? 0,
  //   firstName: json["first_name"] ?? '',
  //   avatarUrl: json["avatar_url"] ?? '',
  //   blockedByMe: json["blocked_by_me"] ?? '',
  //   studentId: json["student_id"] ?? '',
  // );

  Map<String, dynamic> toJson() => {
    "id": id,
    "full_name": fullName,
    "email": email,
    "phone_number": phoneNumber,
    "role_id": roleId,
    "school_id": schoolId,
    "is_administrator": isAdministrator,
    "rtl_ltl": rtlLtl,
    "first_name": firstName,
    "avatar_url": avatarUrl,
    "blocked_by_me": blockedByMe,
    "student_id": studentId,
    "parent_id": parentId,
    "staff_id": staffId,
  };
}
