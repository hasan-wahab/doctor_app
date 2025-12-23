import 'dart:convert';class CurrentPatientModel {
  final Patient patient;
  final Stats stats;
  final List<RecentInvoice> recentInvoices;
  final List<TherapySession> therapySessions;

  CurrentPatientModel({
    required this.patient,
    required this.stats,
    required this.recentInvoices,
    required this.therapySessions,
  });

  factory CurrentPatientModel.fromJson(Map<String, dynamic> json) {
    return CurrentPatientModel(
      patient: Patient.fromJson(json['patient']),
      stats: Stats.fromJson(json['stats']),
      recentInvoices: (json['recent_invoices'] as List?)
          ?.map((e) => RecentInvoice.fromJson(e))
          .toList() ??
          [],
      therapySessions: (json['therapy_sessions'] as List?)
          ?.map((e) => TherapySession.fromJson(e))
          .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'patient': patient.toJson(),
      'stats': stats.toJson(),
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
  final String? address;
  final String phone;
  final String cnic;
  final String gender;
  final DateTime birthDate;
  final int age;
  final String bloodGroup;
  final String? referBy;
  final String? insurance;
  final String? image;
  final String status;
  final String? cardUid;
  final double walletBalance;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int createdBy;
  final int updatedBy;
  final DateTime? deletedAt;
  final int userId;
  final List<Visit> visits;
  final List<PatientPackage> packages;
  final User user;

  Patient({
    required this.id,
    required this.name,
    required this.email,
    this.address,
    required this.phone,
    required this.cnic,
    required this.gender,
    required this.birthDate,
    required this.age,
    required this.bloodGroup,
    this.referBy,
    this.insurance,
    this.image,
    required this.status,
    this.cardUid,
    required this.walletBalance,
    required this.createdAt,
    required this.updatedAt,
    required this.createdBy,
    required this.updatedBy,
    this.deletedAt,
    required this.userId,
    required this.visits,
    required this.packages,
    required this.user,
  });

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      address: json['address'],
      phone: json['phone'],
      cnic: json['cnic'],
      gender: json['gender'],
      birthDate: DateTime.parse(json['birth_date']),
      age: json['age'],
      bloodGroup: json['blood_group'],
      referBy: json['refer_by'],
      insurance: json['insurance'],
      image: json['image'],
      status: json['status'],
      cardUid: json['card_uid'],
      walletBalance: json['wallet_balance'] is int
          ? (json['wallet_balance'] as int).toDouble()
          : (json['wallet_balance'] ?? 0.0).toDouble(),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      createdBy: json['created_by'],
      updatedBy: json['updated_by'],
      deletedAt: json['deleted_at'] == null
          ? null
          : DateTime.parse(json['deleted_at']),
      userId: json['user_id'],
      visits: (json['visits'] as List?)
          ?.map((v) => Visit.fromJson(v))
          .toList() ??
          [],
      packages: (json['packages'] as List?)
          ?.map((p) => PatientPackage.fromJson(p))
          .toList() ??
          [],
      user: User.fromJson(json['user']),
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
      'birth_date': birthDate.toIso8601String(),
      'age': age,
      'blood_group': bloodGroup,
      'refer_by': referBy,
      'insurance': insurance,
      'image': image,
      'status': status,
      'card_uid': cardUid,
      'wallet_balance': walletBalance,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'created_by': createdBy,
      'updated_by': updatedBy,
      'deleted_at': deletedAt?.toIso8601String(),
      'user_id': userId,
      'visits': visits.map((v) => v.toJson()).toList(),
      'packages': packages.map((p) => p.toJson()).toList(),
      'user': user.toJson(),
    };
  }
}

// ==================== Visit (FIXED HERE) ====================
class Visit {
  final int id;
  final int? parentVisitId;
  final int patientId;
  final int? clinicId;
  final int receptionistId;
  final int? assistantManagerId;
  final int? consultantId;
  final int? therapistId;
  final String type;
  final String? status;
  final int? invoiceId;
  final double? consultationFee;
  final String currentStage;
  final DateTime visitAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  // Changed to nullable because API is sending null or missing key
  final User? receptionist;

  final User? assistantManager;
  final User? consultant;
  final User? therapist;
  final Invoice? invoice;
  final ConsultantAssessment? consultantAssessment;
  final AssistantManagerAssessment? amAssessment;

  Visit({
    required this.id,
    this.parentVisitId,
    required this.patientId,
    this.clinicId,
    required this.receptionistId,
    this.assistantManagerId,
    this.consultantId,
    this.therapistId,
    required this.type,
    this.status,
    this.invoiceId,
    this.consultationFee,
    required this.currentStage,
    required this.visitAt,
    required this.createdAt,
    required this.updatedAt,
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
      id: json['id'],
      parentVisitId: json['parent_visit_id'],
      patientId: json['patient_id'],
      clinicId: json['clinic_id'],
      receptionistId: json['receptionist_id'],
      assistantManagerId: json['assistant_manager_id'],
      consultantId: json['consultant_id'],
      therapistId: json['therapist_id'],
      type: json['type'],
      status: json['status'],
      invoiceId: json['invoice_id'],
      consultationFee: json['consultation_fee']?.toDouble(),
      currentStage: json['current_stage'],
      visitAt: DateTime.parse(json['visit_at']),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),

      // FIXED: Added Null Check here
      receptionist: json['receptionist'] != null
          ? User.fromJson(json['receptionist'])
          : null,

      assistantManager: json['assistant_manager'] == null
          ? null
          : User.fromJson(json['assistant_manager']),
      consultant:
      json['consultant'] == null ? null : User.fromJson(json['consultant']),
      therapist:
      json['therapist'] == null ? null : User.fromJson(json['therapist']),
      invoice:
      json['invoice'] == null ? null : Invoice.fromJson(json['invoice']),
      consultantAssessment: json['consultant_assessment'] == null
          ? null
          : ConsultantAssessment.fromJson(json['consultant_assessment']),
      amAssessment: json['am_assessment'] == null
          ? null
          : AssistantManagerAssessment.fromJson(json['am_assessment']),
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
      'visit_at': visitAt.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
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
  final String? profilePicture;
  final int isLogin;
  final int userType;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int? clinicId;
  final int? roomId;
  final int? departmentId;
  final int? designationId;
  final int? shiftId;
  final String? phone;
  final String? cnic;

  User({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    this.emailVerifiedAt,
    this.profilePicture,
    required this.isLogin,
    required this.userType,
    required this.createdAt,
    required this.updatedAt,
    this.clinicId,
    this.roomId,
    this.departmentId,
    this.designationId,
    this.shiftId,
    this.phone,
    this.cnic,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      username: json['username'],
      email: json['email'],
      emailVerifiedAt: json['email_verified_at'] == null
          ? null
          : DateTime.parse(json['email_verified_at']),
      profilePicture: json['profile_picture'],
      isLogin: json['is_login'],
      userType: json['user_type'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      clinicId: json['clinic_id'],
      roomId: json['room_id'],
      departmentId: json['department_id'],
      designationId: json['designation_id'],
      shiftId: json['shift_id'],
      phone: json['phone'],
      cnic: json['cnic'],
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
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
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
  final DateTime createdAt;
  final DateTime updatedAt;
  final Pivot pivot;

  PatientPackage({
    required this.id,
    required this.name,
    required this.sessions,
    required this.price,
    required this.createdAt,
    required this.updatedAt,
    required this.pivot,
  });

  factory PatientPackage.fromJson(Map<String, dynamic> json) {
    return PatientPackage(
      id: json['id'],
      name: json['name'],
      sessions: json['sessions'],
      price: json['price'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      pivot: Pivot.fromJson(json['pivot']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'sessions': sessions,
      'price': price,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'pivot': pivot.toJson(),
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
  final DateTime createdAt;
  final DateTime updatedAt;

  Pivot({
    required this.patientId,
    required this.packageId,
    required this.status,
    required this.sessionsUsed,
    required this.sessionsTotal,
    required this.price,
    this.startsAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Pivot.fromJson(Map<String, dynamic> json) {
    return Pivot(
      patientId: json['patient_id'],
      packageId: json['package_id'],
      status: json['status'],
      sessionsUsed: json['sessions_used'],
      sessionsTotal: json['sessions_total'],
      price: json['price'],
      startsAt:
      json['starts_at'] == null ? null : DateTime.parse(json['starts_at']),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
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
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
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
  final int totalSpent;
  final Visit? lastVisit;
  final dynamic nextAppointment;

  Stats({
    required this.totalVisits,
    required this.consultationVisits,
    required this.therapyVisits,
    required this.activePackages,
    required this.completedPackages,
    required this.totalSpent,
    this.lastVisit,
    this.nextAppointment,
  });

  factory Stats.fromJson(Map<String, dynamic> json) {
    return Stats(
      totalVisits: json['total_visits'],
      consultationVisits: json['consultation_visits'],
      therapyVisits: json['therapy_visits'],
      activePackages: json['active_packages'],
      completedPackages: json['completed_packages'],
      totalSpent: json['total_spent'],
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
      'total_spent': totalSpent,
      'last_visit': lastVisit?.toJson(),
      'next_appointment': nextAppointment,
    };
  }
}

// ==================== RecentInvoice & Payment ====================
class RecentInvoice {
  final int id;
  final int patientId;
  final int visitId;
  final dynamic therapySessionId;
  final String type;
  final String amount;
  final String status;
  final int createdBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int? paidAmount;
  final int? balance;
  final String? computedStatus;
  final Visit? visit;
  final List<Payment> payments;

  RecentInvoice({
    required this.id,
    required this.patientId,
    required this.visitId,
    this.therapySessionId,
    required this.type,
    required this.amount,
    required this.status,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    this.paidAmount,
    this.balance,
    this.computedStatus,
    this.visit,
    required this.payments,
  });

  factory RecentInvoice.fromJson(Map<String, dynamic> json) {
    return RecentInvoice(
      id: json['id'],
      patientId: json['patient_id'],
      visitId: json['visit_id'],
      therapySessionId: json['therapy_session_id'],
      type: json['type'],
      amount: json['amount'],
      status: json['status'],
      createdBy: json['created_by'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      paidAmount: json['paid_amount'],
      balance: json['balance'],
      computedStatus: json['computed_status'],
      // FIXED: Added Null Check here as well
      visit: json['visit'] != null ? Visit.fromJson(json['visit']) : null,
      payments: (json['payments'] as List?)
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
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
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
  final DateTime createdAt;
  final DateTime updatedAt;
  final String type;

  Payment({
    required this.id,
    required this.invoiceId,
    required this.patientId,
    required this.createdBy,
    required this.amount,
    required this.method,
    required this.createdAt,
    required this.updatedAt,
    required this.type,
  });

  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
      id: json['id'],
      invoiceId: json['invoice_id'],
      patientId: json['patient_id'],
      createdBy: json['created_by'],
      amount: json['amount'],
      method: json['method'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      type: json['type'],
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
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
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
  final DateTime createdAt;
  final DateTime updatedAt;

  Invoice({
    required this.id,
    required this.patientId,
    required this.visitId,
    this.therapySessionId,
    required this.type,
    required this.amount,
    required this.status,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Invoice.fromJson(Map<String, dynamic> json) {
    return Invoice(
      id: json['id'],
      patientId: json['patient_id'],
      visitId: json['visit_id'],
      therapySessionId: json['therapy_session_id'],
      type: json['type'],
      amount: json['amount'],
      status: json['status'],
      createdBy: json['created_by'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
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
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
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
  final DateTime startTime;
  final DateTime endTime;
  final int durationSeconds;
  final DateTime nextSessionDate;
  final String notes;
  final int? sessionNumber;
  final DateTime createdAt;
  final DateTime updatedAt;
  final dynamic billedInvoiceId;
  final User therapist;
  final Visit visit;

  TherapySession({
    required this.id,
    required this.patientId,
    required this.visitId,
    required this.therapistId,
    required this.patientPackageId,
    required this.startTime,
    required this.endTime,
    required this.durationSeconds,
    required this.nextSessionDate,
    required this.notes,
    this.sessionNumber,
    required this.createdAt,
    required this.updatedAt,
    this.billedInvoiceId,
    required this.therapist,
    required this.visit,
  });

  factory TherapySession.fromJson(Map<String, dynamic> json) {
    return TherapySession(
      id: json['id'],
      patientId: json['patient_id'],
      visitId: json['visit_id'],
      therapistId: json['therapist_id'],
      patientPackageId: json['patient_package_id'],
      startTime: DateTime.parse(json['start_time']),
      endTime: DateTime.parse(json['end_time']),
      durationSeconds: json['duration_seconds'],
      nextSessionDate: DateTime.parse(json['next_session_date']),
      notes: json['notes'],
      sessionNumber: json['session_number'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      billedInvoiceId: json['billed_invoice_id'],
      therapist: User.fromJson(json['therapist']),
      visit: Visit.fromJson(json['visit']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'patient_id': patientId,
      'visit_id': visitId,
      'therapist_id': therapistId,
      'patient_package_id': patientPackageId,
      'start_time': startTime.toIso8601String(),
      'end_time': endTime.toIso8601String(),
      'duration_seconds': durationSeconds,
      'next_session_date': nextSessionDate.toIso8601String(),
      'notes': notes,
      'session_number': sessionNumber,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'billed_invoice_id': billedInvoiceId,
      'therapist': therapist.toJson(),
      'visit': visit.toJson(),
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
  final DateTime nextReviewDate;
  final String rehabGoals;
  final DateTime createdAt;
  final DateTime updatedAt;

  ConsultantAssessment({
    required this.id,
    required this.patientId,
    required this.visitId,
    required this.consultantId,
    required this.observationFindings,
    required this.palpationResults,
    required this.romAssessment,
    required this.neuroSpecialTests,
    required this.differentialDiagnoses,
    required this.finalDiagnosis,
    required this.freqPerWeek,
    required this.durationWeeks,
    required this.treatments,
    required this.medPainReliever,
    required this.medMuscleRelaxant,
    required this.medSupplements,
    required this.invXray,
    required this.invMri,
    required this.invBloodTests,
    required this.adviceActivity,
    required this.adviceErgonomics,
    required this.adviceHomeEx,
    required this.nextReviewDate,
    required this.rehabGoals,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ConsultantAssessment.fromJson(Map<String, dynamic> json) {
    return ConsultantAssessment(
      id: json['id'],
      patientId: json['patient_id'],
      visitId: json['visit_id'],
      consultantId: json['consultant_id'],
      observationFindings: json['observation_findings'],
      palpationResults: json['palpation_results'],
      romAssessment: json['rom_assessment'],
      neuroSpecialTests: json['neuro_special_tests'],
      differentialDiagnoses: json['differential_diagnoses'],
      finalDiagnosis: json['final_diagnosis'],
      freqPerWeek: json['freq_per_week'],
      durationWeeks: json['duration_weeks'],
      treatments: List<String>.from(json['treatments'] ?? []),
      medPainReliever: json['med_pain_reliever'],
      medMuscleRelaxant: json['med_muscle_relaxant'],
      medSupplements: json['med_supplements'],
      invXray: json['inv_xray'],
      invMri: json['inv_mri'],
      invBloodTests: json['inv_blood_tests'],
      adviceActivity: json['advice_activity'],
      adviceErgonomics: json['advice_ergonomics'],
      adviceHomeEx: json['advice_home_ex'],
      nextReviewDate: DateTime.parse(json['next_review_date']),
      rehabGoals: json['rehab_goals'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
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
      'next_review_date': nextReviewDate.toIso8601String(),
      'rehab_goals': rehabGoals,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}

// ==================== AssistantManagerAssessment (FIXED) ====================
class AssistantManagerAssessment {
  final int id;
  final int visitId;
  final int assistantManagerId;
  final String? occupation;
  final String? dailyActivities;
  final String chiefComplaint;
  final List<String> functionalLimitations;
  final List<String> redFlags;
  final String patientGoals;
  final bool consentGiven;
  final int consultantId;
  final DateTime createdAt;
  final DateTime updatedAt;

  final String? complaintOnset;
  final String? onsetType;
  final String? painLocation;
  final String? painType;
  final String? painSeverity;
  final String? painRadiation;
  final String? aggravatingFactors;
  final String? relievingFactors;
  final String? symptomPattern;
  final String? symptomProgression;
  final String? functionalImpact;
  final String? activitiesUnable;
  final String? pastSimilarSymptoms;
  final String? pastInjuriesSurgeries;
  final String? chronicConditions;
  final String? currentMedications;
  final String? jobDetails;
  final String? exerciseHabits;
  final String? smokingStatus;
  final String? alcoholStatus;
  final String? nightPain;
  final String? sleepPosition;
  final String? sleepSupports;
  final String? additionalNotes;

  AssistantManagerAssessment({
    required this.id,
    required this.visitId,
    required this.assistantManagerId,
    this.occupation,
    this.dailyActivities,
    required this.chiefComplaint,
    required this.functionalLimitations,
    required this.redFlags,
    required this.patientGoals,
    required this.consentGiven,
    required this.consultantId,
    required this.createdAt,
    required this.updatedAt,
    this.complaintOnset,
    this.onsetType,
    this.painLocation,
    this.painType,
    this.painSeverity,
    this.painRadiation,
    this.aggravatingFactors,
    this.relievingFactors,
    this.symptomPattern,
    this.symptomProgression,
    this.functionalImpact,
    this.activitiesUnable,
    this.pastSimilarSymptoms,
    this.pastInjuriesSurgeries,
    this.chronicConditions,
    this.currentMedications,
    this.jobDetails,
    this.exerciseHabits,
    this.smokingStatus,
    this.alcoholStatus,
    this.nightPain,
    this.sleepPosition,
    this.sleepSupports,
    this.additionalNotes,
  });

  factory AssistantManagerAssessment.fromJson(Map<String, dynamic> json) {
    return AssistantManagerAssessment(
      id: json['id'],
      visitId: json['visit_id'],
      assistantManagerId: json['assistant_manager_id'],

      // FIX: .toString() lagaya hai taake number anay par crash na ho
      occupation: json['occupation']?.toString(),
      dailyActivities: json['daily_activities']?.toString(),
      chiefComplaint: json['chief_complaint']?.toString() ?? '',

      functionalLimitations:
      List<String>.from(json['functional_limitations'] ?? []),
      redFlags: List<String>.from(json['red_flags'] ?? []),

      patientGoals: json['patient_goals']?.toString() ?? '',

      // FIX: Consent ko sahi se handle kiya
      consentGiven: json['consent_given'] == 1 || json['consent_given'] == true,

      consultantId: json['consultant_id'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),

      // FIX: Sab string fields par .toString() laga diya
      complaintOnset: json['complaint_onset']?.toString(),
      onsetType: json['onset_type']?.toString(),
      painLocation: json['pain_location']?.toString(),
      painType: json['pain_type']?.toString(),
      painSeverity: json['pain_severity']?.toString(),
      painRadiation: json['pain_radiation']?.toString(),
      aggravatingFactors: json['aggravating_factors']?.toString(),
      relievingFactors: json['relieving_factors']?.toString(),
      symptomPattern: json['symptom_pattern']?.toString(),
      symptomProgression: json['symptom_progression']?.toString(),
      functionalImpact: json['functional_impact']?.toString(),
      activitiesUnable: json['activities_unable']?.toString(),
      pastSimilarSymptoms: json['past_similar_symptoms']?.toString(),
      pastInjuriesSurgeries: json['past_injuries_surgeries']?.toString(),
      chronicConditions: json['chronic_conditions']?.toString(),
      currentMedications: json['current_medications']?.toString(),
      jobDetails: json['job_details']?.toString(),
      exerciseHabits: json['exercise_habits']?.toString(),
      smokingStatus: json['smoking_status']?.toString(),
      alcoholStatus: json['alcohol_status']?.toString(),
      nightPain: json['night_pain']?.toString(),
      sleepPosition: json['sleep_position']?.toString(),
      sleepSupports: json['sleep_supports']?.toString(),
      additionalNotes: json['additional_notes']?.toString(),
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
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
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

