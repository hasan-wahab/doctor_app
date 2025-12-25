import 'dart:convert';

class CurrentPatientModel {
  final Patient? patient;
  final Stats? stats;
  final List<RecentInvoice> recentInvoices;
  final List<TherapySession> therapySessions;

  CurrentPatientModel({
    this.patient,
    this.stats,
    this.recentInvoices = const [],
    this.therapySessions = const [],
  });

  factory CurrentPatientModel.fromJson(Map<String, dynamic> json) {
    return CurrentPatientModel(
      patient: json['patient'] != null
          ? Patient.fromJson(json['patient'])
          : null,
      stats: json['stats'] != null ? Stats.fromJson(json['stats']) : null,
      recentInvoices:
          (json['recent_invoices'] as List?)
              ?.map((e) => RecentInvoice.fromJson(e))
              .toList() ??
          [],
      therapySessions:
          (json['therapy_sessions'] as List?)
              ?.map((e) => TherapySession.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'patient': patient?.toJson(),
      'stats': stats?.toJson(),
      'recent_invoices': recentInvoices.map((e) => e.toJson()).toList(),
      'therapy_sessions': therapySessions.map((e) => e.toJson()).toList(),
    };
  }
}

// ==================== Patient ====================
class Patient {
  final int id;
  final String name;
  final String email;
  final String address;
  final String phone;
  final String cnic;
  final String gender;
  final DateTime? birthDate;
  final int age;
  final String bloodGroup;
  final String referBy;
  final String insurance;
  final String image;
  final String status;
  final String cardUid;
  final double walletBalance;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int createdBy;
  final int updatedBy;
  final DateTime? deletedAt;
  final int userId;
  final List<Visit> visits;
  final List<PatientPackage> packages;
  final User? user;

  Patient({
    this.id = 0,
    this.name = '',
    this.email = '',
    this.address = '',
    this.phone = '',
    this.cnic = '',
    this.gender = '',
    this.birthDate,
    this.age = 0,
    this.bloodGroup = '',
    this.referBy = '',
    this.insurance = '',
    this.image = '',
    this.status = '',
    this.cardUid = '',
    this.walletBalance = 0.0,
    this.createdAt,
    this.updatedAt,
    this.createdBy = 0,
    this.updatedBy = 0,
    this.deletedAt,
    this.userId = 0,
    this.visits = const [],
    this.packages = const [],
    this.user,
  });

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      id: json['id'] ?? 0,
      name: json['name']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      address: json['address']?.toString() ?? '',
      phone: json['phone']?.toString() ?? '',
      cnic: json['cnic']?.toString() ?? '',
      gender: json['gender']?.toString() ?? '',
      birthDate: json['birth_date'] != null
          ? DateTime.tryParse(json['birth_date'])
          : null,
      age: json['age'] ?? 0,
      bloodGroup: json['blood_group']?.toString() ?? '',
      referBy: json['refer_by']?.toString() ?? '',
      insurance: json['insurance']?.toString() ?? '',
      image: json['image']?.toString() ?? '',
      status: json['status']?.toString() ?? '',
      cardUid: json['card_uid']?.toString() ?? '',
      walletBalance: (json['wallet_balance'] as num?)?.toDouble() ?? 0.0,
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'])
          : null,
      createdBy: json['created_by'] ?? 0,
      updatedBy: json['updated_by'] ?? 0,
      deletedAt: json['deleted_at'] != null
          ? DateTime.tryParse(json['deleted_at'])
          : null,
      userId: json['user_id'] ?? 0,
      visits:
          (json['visits'] as List?)?.map((v) => Visit.fromJson(v)).toList() ??
          [],
      packages:
          (json['packages'] as List?)
              ?.map((p) => PatientPackage.fromJson(p))
              .toList() ??
          [],
      user: json['user'] != null ? User.fromJson(json['user']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'address': address,
      'phone': phone,
      'cnic': cnic,
      'gender': gender,
      'birth_date': birthDate?.toIso8601String(),
      'age': age,
      'blood_group': bloodGroup,
      'refer_by': referBy,
      'insurance': insurance,
      'image': image,
      'status': status,
      'card_uid': cardUid,
      'wallet_balance': walletBalance,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'created_by': createdBy,
      'updated_by': updatedBy,
      'deleted_at': deletedAt?.toIso8601String(),
      'user_id': userId,
      'visits': visits.map((v) => v.toJson()).toList(),
      'packages': packages.map((p) => p.toJson()).toList(),
      'user': user?.toJson(),
    };
  }
}

// ==================== Visit ====================
class Visit {
  final int id;
  final int parentVisitId;
  final int patientId;
  final int clinicId;
  final int receptionistId;
  final int assistantManagerId;
  final int consultantId;
  final int therapistId;
  final String type;
  final String status;
  final int invoiceId;
  final double consultationFee;
  final String currentStage;
  final DateTime? visitAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  final User? receptionist;
  final User? assistantManager;
  final User? consultant;
  final User? therapist;
  final Invoice? invoice;
  final ConsultantAssessment? consultantAssessment;
  final AssistantManagerAssessment? amAssessment;

  Visit({
    this.id = 0,
    this.parentVisitId = 0,
    this.patientId = 0,
    this.clinicId = 0,
    this.receptionistId = 0,
    this.assistantManagerId = 0,
    this.consultantId = 0,
    this.therapistId = 0,
    this.type = '',
    this.status = '',
    this.invoiceId = 0,
    this.consultationFee = 0.0,
    this.currentStage = '',
    this.visitAt,
    this.createdAt,
    this.updatedAt,
    this.receptionist,
    this.assistantManager,
    this.consultant,
    this.therapist,
    this.invoice,
    this.consultantAssessment,
    this.amAssessment,
  });

  factory Visit.fromJson(Map<String, dynamic> json) {
    return Visit(
      id: json['id'] ?? 0,
      parentVisitId: json['parent_visit_id'] ?? 0,
      patientId: json['patient_id'] ?? 0,
      clinicId: json['clinic_id'] ?? 0,
      receptionistId: json['receptionist_id'] ?? 0,
      assistantManagerId: json['assistant_manager_id'] ?? 0,
      consultantId: json['consultant_id'] ?? 0,
      therapistId: json['therapist_id'] ?? 0,
      type: json['type']?.toString() ?? '',
      status: json['status']?.toString() ?? '',
      invoiceId: json['invoice_id'] ?? 0,
      consultationFee: (json['consultation_fee'] as num?)?.toDouble() ?? 0.0,
      currentStage: json['current_stage']?.toString() ?? '',
      visitAt: json['visit_at'] != null
          ? DateTime.tryParse(json['visit_at'])
          : null,
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'])
          : null,

      receptionist: json['receptionist'] != null
          ? User.fromJson(json['receptionist'])
          : null,
      assistantManager: json['assistant_manager'] != null
          ? User.fromJson(json['assistant_manager'])
          : null,
      consultant: json['consultant'] != null
          ? User.fromJson(json['consultant'])
          : null,
      therapist: json['therapist'] != null
          ? User.fromJson(json['therapist'])
          : null,
      invoice: json['invoice'] != null
          ? Invoice.fromJson(json['invoice'])
          : null,
      consultantAssessment: json['consultant_assessment'] != null
          ? ConsultantAssessment.fromJson(json['consultant_assessment'])
          : null,
      amAssessment: json['am_assessment'] != null
          ? AssistantManagerAssessment.fromJson(json['am_assessment'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'parent_visit_id': parentVisitId,
      'patient_id': patientId,
      'clinic_id': clinicId,
      'receptionist_id': receptionistId,
      'assistant_manager_id': assistantManagerId,
      'consultant_id': consultantId,
      'therapist_id': therapistId,
      'type': type,
      'status': status,
      'invoice_id': invoiceId,
      'consultation_fee': consultationFee,
      'current_stage': currentStage,
      'visit_at': visitAt?.toIso8601String(),
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'receptionist': receptionist?.toJson(),
      'assistant_manager': assistantManager?.toJson(),
      'consultant': consultant?.toJson(),
      'therapist': therapist?.toJson(),
      'invoice': invoice?.toJson(),
      'consultant_assessment': consultantAssessment?.toJson(),
      'am_assessment': amAssessment?.toJson(),
    };
  }
}

// ==================== User ====================
class User {
  final int id;
  final String name;
  final String username;
  final String email;
  final DateTime? emailVerifiedAt;
  final String profilePicture;
  final int isLogin;
  final int userType;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int clinicId;
  final int roomId;
  final int departmentId;
  final int designationId;
  final int shiftId;
  final String phone;
  final String cnic;

  User({
    this.id = 0,
    this.name = '',
    this.username = '',
    this.email = '',
    this.emailVerifiedAt,
    this.profilePicture = '',
    this.isLogin = 0,
    this.userType = 0,
    this.createdAt,
    this.updatedAt,
    this.clinicId = 0,
    this.roomId = 0,
    this.departmentId = 0,
    this.designationId = 0,
    this.shiftId = 0,
    this.phone = '',
    this.cnic = '',
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? 0,
      name: json['name']?.toString() ?? '',
      username: json['username']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      emailVerifiedAt: json['email_verified_at'] != null
          ? DateTime.tryParse(json['email_verified_at'])
          : null,
      profilePicture: json['profile_picture']?.toString() ?? '',
      isLogin: json['is_login'] ?? 0,
      userType: json['user_type'] ?? 0,
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'])
          : null,
      clinicId: json['clinic_id'] ?? 0,
      roomId: json['room_id'] ?? 0,
      departmentId: json['department_id'] ?? 0,
      designationId: json['designation_id'] ?? 0,
      shiftId: json['shift_id'] ?? 0,
      phone: json['phone']?.toString() ?? '',
      cnic: json['cnic']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'username': username,
      'email': email,
      'email_verified_at': emailVerifiedAt?.toIso8601String(),
      'profile_picture': profilePicture,
      'is_login': isLogin,
      'user_type': userType,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'clinic_id': clinicId,
      'room_id': roomId,
      'department_id': departmentId,
      'designation_id': designationId,
      'shift_id': shiftId,
      'phone': phone,
      'cnic': cnic,
    };
  }
}

// ==================== PatientPackage & Pivot ====================
class PatientPackage {
  final int id;
  final String name;
  final int sessions;
  final String price;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Pivot? pivot;

  PatientPackage({
    this.id = 0,
    this.name = '',
    this.sessions = 0,
    this.price = '',
    this.createdAt,
    this.updatedAt,
    this.pivot,
  });

  factory PatientPackage.fromJson(Map<String, dynamic> json) {
    return PatientPackage(
      id: json['id'] ?? 0,
      name: json['name']?.toString() ?? '',
      sessions: json['sessions'] ?? 0,
      price: json['price']?.toString() ?? '',
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'])
          : null,
      pivot: json['pivot'] != null ? Pivot.fromJson(json['pivot']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'sessions': sessions,
      'price': price,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'pivot': pivot?.toJson(),
    };
  }
}

class Pivot {
  final int patientId;
  final int packageId;
  final String status;
  final int sessionsUsed;
  final int sessionsTotal;
  final int price;
  final DateTime? startsAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Pivot({
    this.patientId = 0,
    this.packageId = 0,
    this.status = '',
    this.sessionsUsed = 0,
    this.sessionsTotal = 0,
    this.price = 0,
    this.startsAt,
    this.createdAt,
    this.updatedAt,
  });

  factory Pivot.fromJson(Map<String, dynamic> json) {
    return Pivot(
      patientId: json['patient_id'] ?? 0,
      packageId: json['package_id'] ?? 0,
      status: json['status']?.toString() ?? '',
      sessionsUsed: json['sessions_used'] ?? 0,
      sessionsTotal: json['sessions_total'] ?? 0,
      price: json['price'] ?? 0,
      startsAt: json['starts_at'] != null
          ? DateTime.tryParse(json['starts_at'])
          : null,
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'patient_id': patientId,
      'package_id': packageId,
      'status': status,
      'sessions_used': sessionsUsed,
      'sessions_total': sessionsTotal,
      'price': price,
      'starts_at': startsAt?.toIso8601String(),
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}

// ==================== Stats ====================
class Stats {
  final int totalVisits;
  final int consultationVisits;
  final int therapyVisits;
  final int activePackages;
  final int completedPackages;
  final double totalSpend;
  final double totalAmount;
  final double totalSpent;
  final Visit? lastVisit;
  final dynamic nextAppointment;

  Stats({
    this.totalVisits = 0,
    this.consultationVisits = 0,
    this.therapyVisits = 0,
    this.activePackages = 0,
    this.completedPackages = 0,
    this.totalSpend = 0.0,
    this.totalAmount = 0.0,
    this.totalSpent = 0.0,
    this.lastVisit,
    this.nextAppointment,
  });

  factory Stats.fromJson(Map<String, dynamic> json) {
    return Stats(
      totalVisits: json['total_visits'] ?? 0,
      consultationVisits: json['consultation_visits'] ?? 0,
      therapyVisits: json['therapy_visits'] ?? 0,
      activePackages: json['active_packages'] ?? 0,
      completedPackages: json['completed_packages'] ?? 0,
      totalSpend: (json['total_spend'] is String)
          ? double.tryParse(json['total_spend']) ?? 0.0
          : (json['total_spend'] as num?)?.toDouble() ?? 0.0,
      totalAmount: (json['total_amount'] is String)
          ? double.tryParse(json['total_amount']) ?? 0.0
          : (json['total_amount'] as num?)?.toDouble() ?? 0.0,
      totalSpent: (json['total_spent'] is String)
          ? double.tryParse(json['total_spent']) ?? 0.0
          : (json['total_spent'] as num?)?.toDouble() ?? 0.0,
      lastVisit: json['last_visit'] != null
          ? Visit.fromJson(json['last_visit'])
          : null,
      nextAppointment: json['next_appointment'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total_visits': totalVisits,
      'consultation_visits': consultationVisits,
      'therapy_visits': therapyVisits,
      'active_packages': activePackages,
      'completed_packages': completedPackages,
      'total_spend': totalSpend,
      'total_amount': totalAmount,
      'total_spent': totalSpent,
      'last_visit': lastVisit?.toJson(),
      'next_appointment': nextAppointment,
    };
  }
}

// ==================== RecentInvoice ====================
class RecentInvoice {
  final int id;
  final int patientId;
  final int visitId;
  final dynamic therapySessionId;
  final String type;
  final String amount;
  final String status;
  final int createdBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int paidAmount;
  final int balance;
  final String computedStatus;
  final Visit? visit;
  final List<Payment> payments;

  RecentInvoice({
    this.id = 0,
    this.patientId = 0,
    this.visitId = 0,
    this.therapySessionId,
    this.type = '',
    this.amount = '',
    this.status = '',
    this.createdBy = 0,
    this.createdAt,
    this.updatedAt,
    this.paidAmount = 0,
    this.balance = 0,
    this.computedStatus = '',
    this.visit,
    this.payments = const [],
  });

  factory RecentInvoice.fromJson(Map<String, dynamic> json) {
    return RecentInvoice(
      id: json['id'] ?? 0,
      patientId: json['patient_id'] ?? 0,
      visitId: json['visit_id'] ?? 0,
      therapySessionId: json['therapy_session_id'],
      type: json['type']?.toString() ?? '',
      amount: json['amount']?.toString() ?? '',
      status: json['status']?.toString() ?? '',
      createdBy: json['created_by'] ?? 0,
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'])
          : null,
      paidAmount: json['paid_amount'] ?? 0,
      balance: json['balance'] ?? 0,
      computedStatus: json['computed_status']?.toString() ?? '',
      visit: json['visit'] != null ? Visit.fromJson(json['visit']) : null,
      payments:
          (json['payments'] as List?)
              ?.map((p) => Payment.fromJson(p))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'patient_id': patientId,
      'visit_id': visitId,
      'therapy_session_id': therapySessionId,
      'type': type,
      'amount': amount,
      'status': status,
      'created_by': createdBy,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'paid_amount': paidAmount,
      'balance': balance,
      'computed_status': computedStatus,
      'visit': visit?.toJson(),
      'payments': payments.map((p) => p.toJson()).toList(),
    };
  }
}

class Payment {
  final int id;
  final int invoiceId;
  final int patientId;
  final int createdBy;
  final String amount;
  final String method;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String type;

  Payment({
    this.id = 0,
    this.invoiceId = 0,
    this.patientId = 0,
    this.createdBy = 0,
    this.amount = '',
    this.method = '',
    this.createdAt,
    this.updatedAt,
    this.type = '',
  });

  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
      id: json['id'] ?? 0,
      invoiceId: json['invoice_id'] ?? 0,
      patientId: json['patient_id'] ?? 0,
      createdBy: json['created_by'] ?? 0,
      amount: json['amount']?.toString() ?? '',
      method: json['method']?.toString() ?? '',
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'])
          : null,
      type: json['type']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'invoice_id': invoiceId,
      'patient_id': patientId,
      'created_by': createdBy,
      'amount': amount,
      'method': method,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'type': type,
    };
  }
}

// ==================== Invoice ====================
class Invoice {
  final int id;
  final int patientId;
  final int visitId;
  final dynamic therapySessionId;
  final String type;
  final String amount;
  final String status;
  final int createdBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Invoice({
    this.id = 0,
    this.patientId = 0,
    this.visitId = 0,
    this.therapySessionId,
    this.type = '',
    this.amount = '',
    this.status = '',
    this.createdBy = 0,
    this.createdAt,
    this.updatedAt,
  });

  factory Invoice.fromJson(Map<String, dynamic> json) {
    return Invoice(
      id: json['id'] ?? 0,
      patientId: json['patient_id'] ?? 0,
      visitId: json['visit_id'] ?? 0,
      therapySessionId: json['therapy_session_id'],
      type: json['type']?.toString() ?? '',
      amount: json['amount']?.toString() ?? '',
      status: json['status']?.toString() ?? '',
      createdBy: json['created_by'] ?? 0,
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'patient_id': patientId,
      'visit_id': visitId,
      'therapy_session_id': therapySessionId,
      'type': type,
      'amount': amount,
      'status': status,
      'created_by': createdBy,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}

// ==================== TherapySession ====================
class TherapySession {
  final int id;
  final int patientId;
  final int visitId;
  final int therapistId;
  final int patientPackageId;
  final DateTime? startTime;
  final DateTime? endTime;
  final int durationSeconds;
  final DateTime? nextSessionDate;
  final String notes;
  final int sessionNumber;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic billedInvoiceId;
  final User? therapist;
  final Visit? visit;

  TherapySession({
    this.id = 0,
    this.patientId = 0,
    this.visitId = 0,
    this.therapistId = 0,
    this.patientPackageId = 0,
    this.startTime,
    this.endTime,
    this.durationSeconds = 0,
    this.nextSessionDate,
    this.notes = '',
    this.sessionNumber = 0,
    this.createdAt,
    this.updatedAt,
    this.billedInvoiceId,
    this.therapist,
    this.visit,
  });

  factory TherapySession.fromJson(Map<String, dynamic> json) {
    return TherapySession(
      id: json['id'] ?? 0,
      patientId: json['patient_id'] ?? 0,
      visitId: json['visit_id'] ?? 0,
      therapistId: json['therapist_id'] ?? 0,
      patientPackageId: json['patient_package_id'] ?? 0,
      startTime: json['start_time'] != null
          ? DateTime.tryParse(json['start_time'])
          : null,
      endTime: json['end_time'] != null
          ? DateTime.tryParse(json['end_time'])
          : null,
      durationSeconds: json['duration_seconds'] ?? 0,
      nextSessionDate: json['next_session_date'] != null
          ? DateTime.tryParse(json['next_session_date'])
          : null,
      notes: json['notes']?.toString() ?? '',
      sessionNumber: json['session_number'] ?? 0,
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'])
          : null,
      billedInvoiceId: json['billed_invoice_id'],
      therapist: json['therapist'] != null
          ? User.fromJson(json['therapist'])
          : null,
      visit: json['visit'] != null ? Visit.fromJson(json['visit']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'patient_id': patientId,
      'visit_id': visitId,
      'therapist_id': therapistId,
      'patient_package_id': patientPackageId,
      'start_time': startTime?.toIso8601String(),
      'end_time': endTime?.toIso8601String(),
      'duration_seconds': durationSeconds,
      'next_session_date': nextSessionDate?.toIso8601String(),
      'notes': notes,
      'session_number': sessionNumber,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'billed_invoice_id': billedInvoiceId,
      'therapist': therapist?.toJson(),
      'visit': visit?.toJson(),
    };
  }
}

// ==================== ConsultantAssessment ====================
class ConsultantAssessment {
  final int id;
  final int patientId;
  final int visitId;
  final int consultantId;
  final String observationFindings;
  final String palpationResults;
  final String romAssessment;
  final String neuroSpecialTests;
  final String differentialDiagnoses;
  final String finalDiagnosis;
  final int freqPerWeek;
  final int durationWeeks;
  final List<String> treatments;
  final String medPainReliever;
  final String medMuscleRelaxant;
  final String medSupplements;
  final String invXray;
  final String invMri;
  final String invBloodTests;
  final String adviceActivity;
  final String adviceErgonomics;
  final String adviceHomeEx;
  final DateTime? nextReviewDate;
  final String rehabGoals;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  ConsultantAssessment({
    this.id = 0,
    this.patientId = 0,
    this.visitId = 0,
    this.consultantId = 0,
    this.observationFindings = '',
    this.palpationResults = '',
    this.romAssessment = '',
    this.neuroSpecialTests = '',
    this.differentialDiagnoses = '',
    this.finalDiagnosis = '',
    this.freqPerWeek = 0,
    this.durationWeeks = 0,
    this.treatments = const [],
    this.medPainReliever = '',
    this.medMuscleRelaxant = '',
    this.medSupplements = '',
    this.invXray = '',
    this.invMri = '',
    this.invBloodTests = '',
    this.adviceActivity = '',
    this.adviceErgonomics = '',
    this.adviceHomeEx = '',
    this.nextReviewDate,
    this.rehabGoals = '',
    this.createdAt,
    this.updatedAt,
  });

  factory ConsultantAssessment.fromJson(Map<String, dynamic> json) {
    return ConsultantAssessment(
      id: json['id'] ?? 0,
      patientId: json['patient_id'] ?? 0,
      visitId: json['visit_id'] ?? 0,
      consultantId: json['consultant_id'] ?? 0,
      observationFindings: json['observation_findings']?.toString() ?? '',
      palpationResults: json['palpation_results']?.toString() ?? '',
      romAssessment: json['rom_assessment']?.toString() ?? '',
      neuroSpecialTests: json['neuro_special_tests']?.toString() ?? '',
      differentialDiagnoses: json['differential_diagnoses']?.toString() ?? '',
      finalDiagnosis: json['final_diagnosis']?.toString() ?? '',
      freqPerWeek: json['freq_per_week'] ?? 0,
      durationWeeks: json['duration_weeks'] ?? 0,
      treatments: List<String>.from(json['treatments'] ?? []),
      medPainReliever: json['med_pain_reliever']?.toString() ?? '',
      medMuscleRelaxant: json['med_muscle_relaxant']?.toString() ?? '',
      medSupplements: json['med_supplements']?.toString() ?? '',
      invXray: json['inv_xray']?.toString() ?? '',
      invMri: json['inv_mri']?.toString() ?? '',
      invBloodTests: json['inv_blood_tests']?.toString() ?? '',
      adviceActivity: json['advice_activity']?.toString() ?? '',
      adviceErgonomics: json['advice_ergonomics']?.toString() ?? '',
      adviceHomeEx: json['advice_home_ex']?.toString() ?? '',
      nextReviewDate: json['next_review_date'] != null
          ? DateTime.tryParse(json['next_review_date'])
          : null,
      rehabGoals: json['rehab_goals']?.toString() ?? '',
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'patient_id': patientId,
      'visit_id': visitId,
      'consultant_id': consultantId,
      'observation_findings': observationFindings,
      'palpation_results': palpationResults,
      'rom_assessment': romAssessment,
      'neuro_special_tests': neuroSpecialTests,
      'differential_diagnoses': differentialDiagnoses,
      'final_diagnosis': finalDiagnosis,
      'freq_per_week': freqPerWeek,
      'duration_weeks': durationWeeks,
      'treatments': treatments,
      'med_pain_reliever': medPainReliever,
      'med_muscle_relaxant': medMuscleRelaxant,
      'med_supplements': medSupplements,
      'inv_xray': invXray,
      'inv_mri': invMri,
      'inv_blood_tests': invBloodTests,
      'advice_activity': adviceActivity,
      'advice_ergonomics': adviceErgonomics,
      'advice_home_ex': adviceHomeEx,
      'next_review_date': nextReviewDate?.toIso8601String(),
      'rehab_goals': rehabGoals,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}

// ==================== AssistantManagerAssessment ====================
class AssistantManagerAssessment {
  final int id;
  final int visitId;
  final int assistantManagerId;
  final String occupation;
  final String dailyActivities;
  final String chiefComplaint;
  final List<String> functionalLimitations;
  final List<String> redFlags;
  final String patientGoals;
  final bool consentGiven;
  final int consultantId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  final String complaintOnset;
  final String onsetType;
  final String painLocation;
  final String painType;
  final String painSeverity;
  final String painRadiation;
  final String aggravatingFactors;
  final String relievingFactors;
  final String symptomPattern;
  final String symptomProgression;
  final String functionalImpact;
  final String activitiesUnable;
  final String pastSimilarSymptoms;
  final String pastInjuriesSurgeries;
  final String chronicConditions;
  final String currentMedications;
  final String jobDetails;
  final String exerciseHabits;
  final String smokingStatus;
  final String alcoholStatus;
  final String nightPain;
  final String sleepPosition;
  final String sleepSupports;
  final String additionalNotes;

  AssistantManagerAssessment({
    this.id = 0,
    this.visitId = 0,
    this.assistantManagerId = 0,
    this.occupation = '',
    this.dailyActivities = '',
    this.chiefComplaint = '',
    this.functionalLimitations = const [],
    this.redFlags = const [],
    this.patientGoals = '',
    this.consentGiven = false,
    this.consultantId = 0,
    this.createdAt,
    this.updatedAt,
    this.complaintOnset = '',
    this.onsetType = '',
    this.painLocation = '',
    this.painType = '',
    this.painSeverity = '',
    this.painRadiation = '',
    this.aggravatingFactors = '',
    this.relievingFactors = '',
    this.symptomPattern = '',
    this.symptomProgression = '',
    this.functionalImpact = '',
    this.activitiesUnable = '',
    this.pastSimilarSymptoms = '',
    this.pastInjuriesSurgeries = '',
    this.chronicConditions = '',
    this.currentMedications = '',
    this.jobDetails = '',
    this.exerciseHabits = '',
    this.smokingStatus = '',
    this.alcoholStatus = '',
    this.nightPain = '',
    this.sleepPosition = '',
    this.sleepSupports = '',
    this.additionalNotes = '',
  });

  factory AssistantManagerAssessment.fromJson(Map<String, dynamic> json) {
    return AssistantManagerAssessment(
      id: json['id'] ?? 0,
      visitId: json['visit_id'] ?? 0,
      assistantManagerId: json['assistant_manager_id'] ?? 0,
      occupation: json['occupation']?.toString() ?? '',
      dailyActivities: json['daily_activities']?.toString() ?? '',
      chiefComplaint: json['chief_complaint']?.toString() ?? '',
      functionalLimitations: List<String>.from(
        json['functional_limitations'] ?? [],
      ),
      redFlags: List<String>.from(json['red_flags'] ?? []),
      patientGoals: json['patient_goals']?.toString() ?? '',
      consentGiven: json['consent_given'] == 1 || json['consent_given'] == true,
      consultantId: json['consultant_id'] ?? 0,
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'])
          : null,
      complaintOnset: json['complaint_onset']?.toString() ?? '',
      onsetType: json['onset_type']?.toString() ?? '',
      painLocation: json['pain_location']?.toString() ?? '',
      painType: json['pain_type']?.toString() ?? '',
      painSeverity: json['pain_severity']?.toString() ?? '',
      painRadiation: json['pain_radiation']?.toString() ?? '',
      aggravatingFactors: json['aggravating_factors']?.toString() ?? '',
      relievingFactors: json['relieving_factors']?.toString() ?? '',
      symptomPattern: json['symptom_pattern']?.toString() ?? '',
      symptomProgression: json['symptom_progression']?.toString() ?? '',
      functionalImpact: json['functional_impact']?.toString() ?? '',
      activitiesUnable: json['activities_unable']?.toString() ?? '',
      pastSimilarSymptoms: json['past_similar_symptoms']?.toString() ?? '',
      pastInjuriesSurgeries: json['past_injuries_surgeries']?.toString() ?? '',
      chronicConditions: json['chronic_conditions']?.toString() ?? '',
      currentMedications: json['current_medications']?.toString() ?? '',
      jobDetails: json['job_details']?.toString() ?? '',
      exerciseHabits: json['exercise_habits']?.toString() ?? '',
      smokingStatus: json['smoking_status']?.toString() ?? '',
      alcoholStatus: json['alcohol_status']?.toString() ?? '',
      nightPain: json['night_pain']?.toString() ?? '',
      sleepPosition: json['sleep_position']?.toString() ?? '',
      sleepSupports: json['sleep_supports']?.toString() ?? '',
      additionalNotes: json['additional_notes']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'visit_id': visitId,
      'assistant_manager_id': assistantManagerId,
      'occupation': occupation,
      'daily_activities': dailyActivities,
      'chief_complaint': chiefComplaint,
      'functional_limitations': functionalLimitations,
      'red_flags': redFlags,
      'patient_goals': patientGoals,
      'consent_given': consentGiven,
      'consultant_id': consultantId,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'complaint_onset': complaintOnset,
      'onset_type': onsetType,
      'pain_location': painLocation,
      'pain_type': painType,
      'pain_severity': painSeverity,
      'pain_radiation': painRadiation,
      'aggravating_factors': aggravatingFactors,
      'relieving_factors': relievingFactors,
      'symptom_pattern': symptomPattern,
      'symptom_progression': symptomProgression,
      'functional_impact': functionalImpact,
      'activities_unable': activitiesUnable,
      'past_similar_symptoms': pastSimilarSymptoms,
      'past_injuries_surgeries': pastInjuriesSurgeries,
      'chronic_conditions': chronicConditions,
      'current_medications': currentMedications,
      'job_details': jobDetails,
      'exercise_habits': exerciseHabits,
      'smoking_status': smokingStatus,
      'alcohol_status': alcoholStatus,
      'night_pain': nightPain,
      'sleep_position': sleepPosition,
      'sleep_supports': sleepSupports,
      'additional_notes': additionalNotes,
    };
  }
}
