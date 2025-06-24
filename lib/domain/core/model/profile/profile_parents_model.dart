class ProfileParentsModel {
  bool? success;
  Data? data;
  String? message;

  ProfileParentsModel({this.success, this.data, this.message});

  ProfileParentsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ?  Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = message;
    return data;
  }
}

class Data {
  ProfileParents? profileParents;
  ProfileParentsPermissions? showPermission;

  Data({this.profileParents, this.showPermission});

  Data.fromJson(Map<String, dynamic> json) {
    profileParents = json['profileParents'] != null ? ProfileParents.fromJson(json['profileParents']) : null;
    showPermission = json['show_permission'] != null ? ProfileParentsPermissions.fromJson(json['show_permission']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (profileParents != null) {
      data['profileParents'] = profileParents!.toJson();
    }
    if (showPermission != null) {
      data['show_permission'] = showPermission!.toJson();
    }
    return data;
  }
}

class ProfileParents {
  int? id;
  String? fathersName;
  String? fathersMobile;
  String? fathersOccupation;
  String? fathersPhoto;
  String? mothersName;
  String? mothersMobile;
  String? mothersOccupation;
  String? mothersPhoto;
  String? guardiansName;
  String? guardiansMobile;
  String? guardiansEmail;
  String? guardiansOccupation;
  String? guardiansRelation;
  String? guardiansPhoto;

  ProfileParents(
      {this.id,
        this.fathersName,
        this.fathersMobile,
        this.fathersOccupation,
        this.fathersPhoto,
        this.mothersName,
        this.mothersMobile,
        this.mothersOccupation,
        this.mothersPhoto,
        this.guardiansName,
        this.guardiansMobile,
        this.guardiansEmail,
        this.guardiansOccupation,
        this.guardiansRelation,
        this.guardiansPhoto});

  ProfileParents.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fathersName = json['fathers_name'];
    fathersMobile = json['fathers_mobile'];
    fathersOccupation = json['fathers_occupation'];
    fathersPhoto = json['fathers_photo'];
    mothersName = json['mothers_name'];
    mothersMobile = json['mothers_mobile'];
    mothersOccupation = json['mothers_occupation'];
    mothersPhoto = json['mothers_photo'];
    guardiansName = json['guardians_name'];
    guardiansMobile = json['guardians_mobile'];
    guardiansEmail = json['guardians_email'];
    guardiansOccupation = json['guardians_occupation'];
    guardiansRelation = json['guardians_relation'];
    guardiansPhoto = json['guardians_photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['id'] = id;
    data['fathers_name'] = fathersName;
    data['fathers_mobile'] = fathersMobile;
    data['fathers_occupation'] = fathersOccupation;
    data['fathers_photo'] = fathersPhoto;
    data['mothers_name'] = mothersName;
    data['mothers_mobile'] = mothersMobile;
    data['mothers_occupation'] = mothersOccupation;
    data['mothers_photo'] = mothersPhoto;
    data['guardians_name'] = guardiansName;
    data['guardians_mobile'] = guardiansMobile;
    data['guardians_email'] = guardiansEmail;
    data['guardians_occupation'] = guardiansOccupation;
    data['guardians_relation'] = guardiansRelation;
    data['guardians_photo'] = guardiansPhoto;
    return data;
  }
}

class ProfileParentsPermissions {
  int? session;
  int? studentClass;
  int? section;
  int? rollNumber;
  int? admissionNumber;
  int? firstName;
  int? lastName;
  int? gender;
  int? dateOfBirth;
  int? bloodGroup;
  int? emailAddress;
  int? caste;
  int? phoneNumber;
  int? religion;
  int? admissionDate;
  int? studentCategoryId;
  int? studentGroupId;
  int? height;
  int? weight;
  int? photo;
  int? fathersName;
  int? fathersOccupation;
  int? fathersPhone;
  int? fathersPhoto;
  int? mothersName;
  int? mothersOccupation;
  int? mothersPhone;
  int? mothersPhoto;
  int? guardiansName;
  int? guardiansEmail;
  int? guardiansPhoto;
  int? guardiansPhone;
  int? guardiansOccupation;
  int? guardiansAddress;
  int? currentAddress;
  int? permanentAddress;
  int? route;
  int? vehicle;
  int? dormitoryName;
  int? roomNumber;
  int? nationalIdNumber;
  int? localIdNumber;
  int? bankAccountNumber;
  int? bankName;
  int? previousSchoolDetails;
  int? additionalNotes;
  int? ifscCode;
  int? documentFile1;
  int? documentFile2;
  int? documentFile3;
  int? documentFile4;
  int? customField;

  ProfileParentsPermissions(
      {this.session, this.studentClass, this.section, this.rollNumber, this.admissionNumber, this.firstName, this.lastName, this.gender, this.dateOfBirth, this.bloodGroup, this.emailAddress, this.caste, this.phoneNumber, this.religion, this.admissionDate, this.studentCategoryId, this.studentGroupId, this.height, this.weight, this.photo, this.fathersName, this.fathersOccupation, this.fathersPhone, this.fathersPhoto, this.mothersName, this.mothersOccupation, this.mothersPhone, this.mothersPhoto, this.guardiansName, this.guardiansEmail, this.guardiansPhoto, this.guardiansPhone, this.guardiansOccupation, this.guardiansAddress, this.currentAddress, this.permanentAddress, this.route, this.vehicle, this.dormitoryName, this.roomNumber, this.nationalIdNumber, this.localIdNumber, this.bankAccountNumber, this.bankName, this.previousSchoolDetails, this.additionalNotes, this.ifscCode, this.documentFile1, this.documentFile2, this.documentFile3, this.documentFile4, this.customField});

  ProfileParentsPermissions.fromJson(Map<String, dynamic> json) {
    session = json['session'];
    studentClass = json['class'];
    section = json['section'];
    rollNumber = json['roll_number'];
    admissionNumber = json['admission_number'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    gender = json['gender'];
    dateOfBirth = json['date_of_birth'];
    bloodGroup = json['blood_group'];
    emailAddress = json['email_address'];
    caste = json['caste'];
    phoneNumber = json['phone_number'];
    religion = json['religion'];
    admissionDate = json['admission_date'];
    studentCategoryId = json['student_category_id'];
    studentGroupId = json['student_group_id'];
    height = json['height'];
    weight = json['weight'];
    photo = json['photo'];
    fathersName = json['fathers_name'];
    fathersOccupation = json['fathers_occupation'];
    fathersPhone = json['fathers_phone'];
    fathersPhoto = json['fathers_photo'];
    mothersName = json['mothers_name'];
    mothersOccupation = json['mothers_occupation'];
    mothersPhone = json['mothers_phone'];
    mothersPhoto = json['mothers_photo'];
    guardiansName = json['guardians_name'];
    guardiansEmail = json['guardians_email'];
    guardiansPhoto = json['guardians_photo'];
    guardiansPhone = json['guardians_phone'];
    guardiansOccupation = json['guardians_occupation'];
    guardiansAddress = json['guardians_address'];
    currentAddress = json['current_address'];
    permanentAddress = json['permanent_address'];
    route = json['route'];
    vehicle = json['vehicle'];
    dormitoryName = json['dormitory_name'];
    roomNumber = json['room_number'];
    nationalIdNumber = json['national_id_number'];
    localIdNumber = json['local_id_number'];
    bankAccountNumber = json['bank_account_number'];
    bankName = json['bank_name'];
    previousSchoolDetails = json['previous_school_details'];
    additionalNotes = json['additional_notes'];
    ifscCode = json['ifsc_code'];
    documentFile1 = json['document_file_1'];
    documentFile2 = json['document_file_2'];
    documentFile3 = json['document_file_3'];
    documentFile4 = json['document_file_4'];
    customField = json['custom_field'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['session'] = session;
    data['class'] = studentClass;
    data['section'] = section;
    data['roll_number'] = rollNumber;
    data['admission_number'] = admissionNumber;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['gender'] = gender;
    data['date_of_birth'] = dateOfBirth;
    data['blood_group'] = bloodGroup;
    data['email_address'] = emailAddress;
    data['caste'] = caste;
    data['phone_number'] = phoneNumber;
    data['religion'] = religion;
    data['admission_date'] = admissionDate;
    data['student_category_id'] = studentCategoryId;
    data['student_group_id'] = studentGroupId;
    data['height'] = height;
    data['weight'] = weight;
    data['photo'] = photo;
    data['fathers_name'] = fathersName;
    data['fathers_occupation'] = fathersOccupation;
    data['fathers_phone'] = fathersPhone;
    data['fathers_photo'] = fathersPhoto;
    data['mothers_name'] = mothersName;
    data['mothers_occupation'] = mothersOccupation;
    data['mothers_phone'] = mothersPhone;
    data['mothers_photo'] = mothersPhoto;
    data['guardians_name'] = guardiansName;
    data['guardians_email'] = guardiansEmail;
    data['guardians_photo'] = guardiansPhoto;
    data['guardians_phone'] = guardiansPhone;
    data['guardians_occupation'] = guardiansOccupation;
    data['guardians_address'] = guardiansAddress;
    data['current_address'] = currentAddress;
    data['permanent_address'] = permanentAddress;
    data['route'] = route;
    data['vehicle'] = vehicle;
    data['dormitory_name'] = dormitoryName;
    data['room_number'] = roomNumber;
    data['national_id_number'] = nationalIdNumber;
    data['local_id_number'] = localIdNumber;
    data['bank_account_number'] = bankAccountNumber;
    data['bank_name'] = bankName;
    data['previous_school_details'] = previousSchoolDetails;
    data['additional_notes'] = additionalNotes;
    data['ifsc_code'] = ifscCode;
    data['document_file_1'] = documentFile1;
    data['document_file_2'] = documentFile2;
    data['document_file_3'] = documentFile3;
    data['document_file_4'] = documentFile4;
    data['custom_field'] = customField;
    return data;
  }
}