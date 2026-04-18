// class LoginModel1 {
//   LoginModel1({
//     required this.accessToken,
//     required this.user,
//     required this.patientData,
//   });
//
//   final String? accessToken;
//   final User? user;
//   final PatientData? patientData;
//
//   factory LoginModel1.fromJson(Map<String, dynamic> json){
//     return LoginModel1(
//       accessToken: json["access_token"],
//       user: json["user"] == null ? null : User.fromJson(json["user"]),
//       patientData: json["patient_data"] == null ? null : PatientData.fromJson(json["patient_data"]),
//     );
//   }
//
// }
//
// class PatientData {
//   PatientData({
//     required this.patientInfo,
//     required this.statistics,
//     required this.therapySessionsCount,
//     required this.recentInvoicesCount,
//   });
//
//   final PatientInfo? patientInfo;
//   final Statistics? statistics;
//   final int? therapySessionsCount;
//   final int? recentInvoicesCount;
//
//   factory PatientData.fromJson(Map<String, dynamic> json){
//     return PatientData(
//       patientInfo: json["patient_info"] == null ? null : PatientInfo.fromJson(json["patient_info"]),
//       statistics: json["statistics"] == null ? null : Statistics.fromJson(json["statistics"]),
//       therapySessionsCount: json["therapy_sessions_count"],
//       recentInvoicesCount: json["recent_invoices_count"],
//     );
//   }
//
// }
//
// class PatientInfo {
//   PatientInfo({
//     required this.id,
//     required this.name,
//     required this.email,
//     required this.phone,
//     required this.cnic,
//     required this.gender,
//     required this.birthDate,
//     required this.age,
//     required this.bloodGroup,
//     required this.referBy,
//     required this.insurance,
//     required this.image,
//     required this.status,
//     required this.cardUid,
//     required this.address,
//   });
//
//   final int? id;
//   final String? name;
//   final String? email;
//   final String? phone;
//   final String? cnic;
//   final String? gender;
//   final dynamic birthDate;
//   final int? age;
//   final String? bloodGroup;
//   final String? referBy;
//   final String? insurance;
//   final String? image;
//   final String? status;
//   final String? cardUid;
//   final dynamic address;
//
//   factory PatientInfo.fromJson(Map<String, dynamic> json){
//     return PatientInfo(
//       id: json["id"],
//       name: json["name"],
//       email: json["email"],
//       phone: json["phone"],
//       cnic: json["cnic"],
//       gender: json["gender"],
//       birthDate: json["birth_date"],
//       age: json["age"],
//       bloodGroup: json["blood_group"],
//       referBy: json["refer_by"],
//       insurance: json["insurance"],
//       image: json["image"],
//       status: json["status"],
//       cardUid: json["card_uid"],
//       address: json["address"],
//     );
//   }
//
// }
//
// class Statistics {
//   Statistics({
//     required this.totalVisits,
//     required this.activePackages,
//     required this.totalSpent,
//     required this.totalTherapySessions,
//     required this.lastVisitDate,
//     required this.nextAppointmentDate,
//   });
//
//   final int? totalVisits;
//   final int? activePackages;
//   final int? totalSpent;
//   final int? totalTherapySessions;
//   final dynamic lastVisitDate;
//   final dynamic nextAppointmentDate;
//
//   factory Statistics.fromJson(Map<String, dynamic> json){
//     return Statistics(
//       totalVisits: json["total_visits"],
//       activePackages: json["active_packages"],
//       totalSpent: json["total_spent"],
//       totalTherapySessions: json["total_therapy_sessions"],
//       lastVisitDate: json["last_visit_date"],
//       nextAppointmentDate: json["next_appointment_date"],
//     );
//   }
//
// }
//
// class User {
//   User({
//     required this.id,
//     required this.name,
//     required this.username,
//     required this.email,
//     required this.emailVerifiedAt,
//     required this.profilePicture,
//     required this.isLogin,
//     required this.userType,
//     required this.createdBy,
//     required this.updatedBy,
//     required this.deletedAt,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.clinicId,
//     required this.roomId,
//     required this.departmentId,
//     required this.designationId,
//     required this.shiftId,
//     required this.phone,
//     required this.cnic,
//   });
//
//   final int? id;
//   final String? name;
//   final String? username;
//   final String? email;
//   final dynamic emailVerifiedAt;
//   final String? profilePicture;
//   final int? isLogin;
//   final int? userType;
//   final int? createdBy;
//   final int? updatedBy;
//   final dynamic deletedAt;
//   final DateTime? createdAt;
//   final DateTime? updatedAt;
//   final dynamic clinicId;
//   final dynamic roomId;
//   final dynamic departmentId;
//   final dynamic designationId;
//   final dynamic shiftId;
//   final String? phone;
//   final String? cnic;
//
//   factory User.fromJson(Map<String, dynamic> json){
//     return User(
//       id: json["id"],
//       name: json["name"],
//       username: json["username"],
//       email: json["email"],
//       emailVerifiedAt: json["email_verified_at"],
//       profilePicture: json["profile_picture"],
//       isLogin: json["is_login"],
//       userType: json["user_type"],
//       createdBy: json["created_by"],
//       updatedBy: json["updated_by"],
//       deletedAt: json["deleted_at"],
//       createdAt: DateTime.tryParse(json["created_at"] ?? ""),
//       updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
//       clinicId: json["clinic_id"],
//       roomId: json["room_id"],
//       departmentId: json["department_id"],
//       designationId: json["designation_id"],
//       shiftId: json["shift_id"],
//       phone: json["phone"],
//       cnic: json["cnic"],
//     );
//   }
//
// }
class LoginModel1 {
  LoginModel1({
    required this.accessToken,
    required this.user,
    required this.patientData,
  });

  final String? accessToken;
  final User? user;
  final PatientData? patientData;

  factory LoginModel1.fromJson(Map<String, dynamic> json) {
    return LoginModel1(
      accessToken: json["access_token"],
      user: json["user"] == null ? null : User.fromJson(json["user"]),
      patientData: json["patient_data"] == null
          ? null
          : PatientData.fromJson(json["patient_data"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "access_token": accessToken,
      "user": user?.toJson(),
      "patient_data": patientData?.toJson(),
    };
  }
}

class PatientData {
  PatientData({
    required this.patientInfo,
    required this.statistics,
    required this.therapySessionsCount,
    required this.recentInvoicesCount,
  });

  final PatientInfo? patientInfo;
  final Statistics? statistics;
  final int? therapySessionsCount;
  final int? recentInvoicesCount;

  factory PatientData.fromJson(Map<String, dynamic> json) {
    return PatientData(
      patientInfo: json["patient_info"] == null
          ? null
          : PatientInfo.fromJson(json["patient_info"]),
      statistics: json["statistics"] == null
          ? null
          : Statistics.fromJson(json["statistics"]),
      therapySessionsCount: json["therapy_sessions_count"],
      recentInvoicesCount: json["recent_invoices_count"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "patient_info": patientInfo?.toJson(),
      "statistics": statistics?.toJson(),
      "therapy_sessions_count": therapySessionsCount,
      "recent_invoices_count": recentInvoicesCount,
    };
  }
}

class PatientInfo {
  PatientInfo({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.cnic,
    required this.gender,
    required this.birthDate,
    required this.age,
    required this.bloodGroup,
    required this.referBy,
    required this.insurance,
    required this.image,
    required this.status,
    required this.cardUid,
    required this.address,
  });

  final int? id;
  final String? name;
  final String? email;
  final String? phone;
  final String? cnic;
  final String? gender;
  final dynamic birthDate;
  final int? age;
  final String? bloodGroup;
  final String? referBy;
  final String? insurance;
  final String? image;
  final String? status;
  final String? cardUid;
  final dynamic address;

  factory PatientInfo.fromJson(Map<String, dynamic> json) {
    return PatientInfo(
      id: json["id"],
      name: json["name"],
      email: json["email"],
      phone: json["phone"],
      cnic: json["cnic"],
      gender: json["gender"],
      birthDate: json["birth_date"],
      age: json["age"],
      bloodGroup: json["blood_group"],
      referBy: json["refer_by"],
      insurance: json["insurance"],
      image: json["image"],
      status: json["status"],
      cardUid: json["card_uid"],
      address: json["address"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "email": email,
      "phone": phone,
      "cnic": cnic,
      "gender": gender,
      "birth_date": birthDate,
      "age": age,
      "blood_group": bloodGroup,
      "refer_by": referBy,
      "insurance": insurance,
      "image": image,
      "status": status,
      "card_uid": cardUid,
      "address": address,
    };
  }
}

class Statistics {
  Statistics({
    required this.totalVisits,
    required this.activePackages,
    required this.totalSpent,
    required this.totalTherapySessions,
    required this.lastVisitDate,
    required this.nextAppointmentDate,
  });

  final int? totalVisits;
  final int? activePackages;
  final int? totalSpent;
  final int? totalTherapySessions;
  final dynamic lastVisitDate;
  final dynamic nextAppointmentDate;

  factory Statistics.fromJson(Map<String, dynamic> json) {
    return Statistics(
      totalVisits: json["total_visits"],
      activePackages: json["active_packages"],
      totalSpent: json["total_spent"],
      totalTherapySessions: json["total_therapy_sessions"],
      lastVisitDate: json["last_visit_date"],
      nextAppointmentDate: json["next_appointment_date"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "total_visits": totalVisits,
      "active_packages": activePackages,
      "total_spent": totalSpent,
      "total_therapy_sessions": totalTherapySessions,
      "last_visit_date": lastVisitDate,
      "next_appointment_date": nextAppointmentDate,
    };
  }
}

class User {
  User({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.emailVerifiedAt,
    required this.profilePicture,
    required this.isLogin,
    required this.userType,
    required this.createdBy,
    required this.updatedBy,
    required this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.clinicId,
    required this.roomId,
    required this.departmentId,
    required this.designationId,
    required this.shiftId,
    required this.phone,
    required this.cnic,
  });

  final int? id;
  final String? name;
  final String? username;
  final String? email;
  final dynamic emailVerifiedAt;
  final String? profilePicture;
  final int? isLogin;
  final int? userType;
  final int? createdBy;
  final int? updatedBy;
  final dynamic deletedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic clinicId;
  final dynamic roomId;
  final dynamic departmentId;
  final dynamic designationId;
  final dynamic shiftId;
  final String? phone;
  final String? cnic;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"],
      name: json["name"],
      username: json["username"],
      email: json["email"],
      emailVerifiedAt: json["email_verified_at"],
      profilePicture: json["profile_picture"],
      isLogin: json["is_login"],
      userType: json["user_type"],
      createdBy: json["created_by"],
      updatedBy: json["updated_by"],
      deletedAt: json["deleted_at"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      clinicId: json["clinic_id"],
      roomId: json["room_id"],
      departmentId: json["department_id"],
      designationId: json["designation_id"],
      shiftId: json["shift_id"],
      phone: json["phone"],
      cnic: json["cnic"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "username": username,
      "email": email,
      "email_verified_at": emailVerifiedAt,
      "profile_picture": profilePicture,
      "is_login": isLogin,
      "user_type": userType,
      "created_by": createdBy,
      "updated_by": updatedBy,
      "deleted_at": deletedAt,
      "created_at": createdAt?.toIso8601String(),
      "updated_at": updatedAt?.toIso8601String(),
      "clinic_id": clinicId,
      "room_id": roomId,
      "department_id": departmentId,
      "designation_id": designationId,
      "shift_id": shiftId,
      "phone": phone,
      "cnic": cnic,
    };
  }
}
