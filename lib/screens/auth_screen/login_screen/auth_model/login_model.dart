class LoginModel {
  bool? success;
  int? statusCode;
  String? message;
  Data? data;

  LoginModel({this.success, this.statusCode, this.message, this.data});

  LoginModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['status_code'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['status_code'] = this.statusCode;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? accessToken;
  User? user;

  Data({this.accessToken, this.user});

  Data.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['access_token'] = this.accessToken;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? username;
  String? email;
  Null? emailVerifiedAt;
  String? profilePicture;
  int? isLogin;
  int? userType;
  int? createdBy;
  int? updatedBy;
  Null? deletedAt;
  String? createdAt;
  String? updatedAt;
  Null? clinicId;
  Null? roomId;
  Null? departmentId;
  Null? designationId;
  Null? shiftId;
  String? phone;
  String? cnic;

  User({
    this.id,
    this.name,
    this.username,
    this.email,
    this.emailVerifiedAt,
    this.profilePicture,
    this.isLogin,
    this.userType,
    this.createdBy,
    this.updatedBy,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.clinicId,
    this.roomId,
    this.departmentId,
    this.designationId,
    this.shiftId,
    this.phone,
    this.cnic,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    username = json['username'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    profilePicture = json['profile_picture'];
    isLogin = json['is_login'];
    userType = json['user_type'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    clinicId = json['clinic_id'];
    roomId = json['room_id'];
    departmentId = json['department_id'];
    designationId = json['designation_id'];
    shiftId = json['shift_id'];
    phone = json['phone'];
    cnic = json['cnic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['username'] = this.username;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['profile_picture'] = this.profilePicture;
    data['is_login'] = this.isLogin;
    data['user_type'] = this.userType;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['clinic_id'] = this.clinicId;
    data['room_id'] = this.roomId;
    data['department_id'] = this.departmentId;
    data['designation_id'] = this.designationId;
    data['shift_id'] = this.shiftId;
    data['phone'] = this.phone;
    data['cnic'] = this.cnic;
    return data;
  }
}
