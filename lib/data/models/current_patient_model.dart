class CurrentPatientModel {
  final Patient patient;
  final Stats stats;
  final List<InvoiceRecord> recentInvoices;
  final List<TherapySession> therapySessions;

  const CurrentPatientModel({
    this.patient = const Patient(),
    this.stats = const Stats(),
    this.recentInvoices = const [],
    this.therapySessions = const [],
  });

  factory CurrentPatientModel.fromJson(Map<String, dynamic>? json) {
    final data = json ?? {};
    return CurrentPatientModel(
      patient: Patient.fromJson(_asMap(data['patient'])),
      stats: Stats.fromJson(_asMap(data['stats'])),
      recentInvoices: _asListMap(
        data['recent_invoices'],
      ).map(InvoiceRecord.fromJson).toList(),
      therapySessions: _asListMap(
        data['therapy_sessions'],
      ).map(TherapySession.fromJson).toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'patient': patient.toJson(),
    'stats': stats.toJson(),
    'recent_invoices': recentInvoices.map((e) => e.toJson()).toList(),
    'therapy_sessions': therapySessions.map((e) => e.toJson()).toList(),
  };
}

class Patient {
  final int id;
  final String name;
  final String fatherHusbandName;
  final String email;
  final String address;
  final String city;
  final String cityOther;
  final String passportNo;
  final String phone;
  final String occupation;
  final String emergencyContactPhone;
  final String cnic;
  final String gender;
  final String maritalStatus;
  final String birthDate;
  final int age;
  final String bloodGroup;
  final List<String> languages;
  final String languagesOther;
  final String referBy;
  final String insurance;
  final String image;
  final String status;
  final String cardUid;
  final double walletBalance;
  final String insurancePanel;
  final String createdAt;
  final String updatedAt;
  final int createdBy;
  final int updatedBy;
  final String deletedAt;
  final int userId;
  final String imageUrl;
  final String cityLabel;
  final List<String> languagesLabels;
  final String maritalStatusLabel;
  final List<Visit> visits;
  final List<PatientPackage> packages;
  final AppUser user;

  const Patient({
    this.id = 0,
    this.name = '',
    this.fatherHusbandName = '',
    this.email = '',
    this.address = '',
    this.city = '',
    this.cityOther = '',
    this.passportNo = '',
    this.phone = '',
    this.occupation = '',
    this.emergencyContactPhone = '',
    this.cnic = '',
    this.gender = '',
    this.maritalStatus = '',
    this.birthDate = '',
    this.age = 0,
    this.bloodGroup = '',
    this.languages = const [],
    this.languagesOther = '',
    this.referBy = '',
    this.insurance = '',
    this.image = '',
    this.status = '',
    this.cardUid = '',
    this.walletBalance = 0,
    this.insurancePanel = '',
    this.createdAt = '',
    this.updatedAt = '',
    this.createdBy = 0,
    this.updatedBy = 0,
    this.deletedAt = '',
    this.userId = 0,
    this.imageUrl = '',
    this.cityLabel = '',
    this.languagesLabels = const [],
    this.maritalStatusLabel = '',
    this.visits = const [],
    this.packages = const [],
    this.user = const AppUser(),
  });

  factory Patient.fromJson(Map<String, dynamic>? json) {
    final data = json ?? {};
    return Patient(
      id: _asInt(data['id']),
      name: _asString(data['name']),
      fatherHusbandName: _asString(data['father_husband_name']),
      email: _asString(data['email']),
      address: _asString(data['address']),
      city: _asString(data['city']),
      cityOther: _asString(data['city_other']),
      passportNo: _asString(data['passport_no']),
      phone: _asString(data['phone']),
      occupation: _asString(data['occupation']),
      emergencyContactPhone: _asString(data['emergency_contact_phone']),
      cnic: _asString(data['cnic']),
      gender: _asString(data['gender']),
      maritalStatus: _asString(data['marital_status']),
      birthDate: _asString(data['birth_date']),
      age: _asInt(data['age']),
      bloodGroup: _asString(data['blood_group']),
      languages: _asStringList(data['languages']),
      languagesOther: _asString(data['languages_other']),
      referBy: _asString(data['refer_by']),
      insurance: _asString(data['insurance']),
      image: _asString(data['image']),
      status: _asString(data['status']),
      cardUid: _asString(data['card_uid']),
      walletBalance: _asDouble(data['wallet_balance']),
      insurancePanel: _asString(data['insurance_panel']),
      createdAt: _asString(data['created_at']),
      updatedAt: _asString(data['updated_at']),
      createdBy: _asInt(data['created_by']),
      updatedBy: _asInt(data['updated_by']),
      deletedAt: _asString(data['deleted_at']),
      userId: _asInt(data['user_id']),
      imageUrl: _asString(data['image_url']),
      cityLabel: _asString(data['city_label']),
      languagesLabels: _asStringList(data['languages_labels']),
      maritalStatusLabel: _asString(data['marital_status_label']),
      visits: _asListMap(data['visits']).map(Visit.fromJson).toList(),
      packages: _asListMap(
        data['packages'],
      ).map(PatientPackage.fromJson).toList(),
      user: AppUser.fromJson(_asMap(data['user'])),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'father_husband_name': fatherHusbandName,
    'email': email,
    'address': address,
    'city': city,
    'city_other': cityOther,
    'passport_no': passportNo,
    'phone': phone,
    'occupation': occupation,
    'emergency_contact_phone': emergencyContactPhone,
    'cnic': cnic,
    'gender': gender,
    'marital_status': maritalStatus,
    'birth_date': birthDate,
    'age': age,
    'blood_group': bloodGroup,
    'languages': languages,
    'languages_other': languagesOther,
    'refer_by': referBy,
    'insurance': insurance,
    'image': image,
    'status': status,
    'card_uid': cardUid,
    'wallet_balance': walletBalance,
    'insurance_panel': insurancePanel,
    'created_at': createdAt,
    'updated_at': updatedAt,
    'created_by': createdBy,
    'updated_by': updatedBy,
    'deleted_at': deletedAt,
    'user_id': userId,
    'image_url': imageUrl,
    'city_label': cityLabel,
    'languages_labels': languagesLabels,
    'marital_status_label': maritalStatusLabel,
    'visits': visits.map((e) => e.toJson()).toList(),
    'packages': packages.map((e) => e.toJson()).toList(),
    'user': user.toJson(),
  };
}

class Visit {
  final int id;
  final int parentVisitId;
  final int patientId;
  final int clinicId;
  final int receptionistId;
  final int assistantManagerId;
  final int historyTakerId;
  final int consultantId;
  final int therapistId;
  final int requestedTherapistId;
  final int dryNeedlerId;
  final bool pendingDryNeedling;
  final String type;
  final String status;
  final int invoiceId;
  final double consultationFee;
  final String currentStage;
  final String requestType;
  final String requestNote;
  final String visitAt;
  final String giftPicture;
  final String createdAt;
  final String updatedAt;

  final AppUser receptionist;
  final AppUser assistantManager;
  final AppUser consultant;
  final AppUser therapist;
  final InvoiceRecord invoice;

  final Map<String, dynamic> consultantAssessment;
  final Map<String, dynamic> amAssessment;
  final Map<String, dynamic> historyTaking;

  const Visit({
    this.id = 0,
    this.parentVisitId = 0,
    this.patientId = 0,
    this.clinicId = 0,
    this.receptionistId = 0,
    this.assistantManagerId = 0,
    this.historyTakerId = 0,
    this.consultantId = 0,
    this.therapistId = 0,
    this.requestedTherapistId = 0,
    this.dryNeedlerId = 0,
    this.pendingDryNeedling = false,
    this.type = '',
    this.status = '',
    this.invoiceId = 0,
    this.consultationFee = 0,
    this.currentStage = '',
    this.requestType = '',
    this.requestNote = '',
    this.visitAt = '',
    this.giftPicture = '',
    this.createdAt = '',
    this.updatedAt = '',
    this.receptionist = const AppUser(),
    this.assistantManager = const AppUser(),
    this.consultant = const AppUser(),
    this.therapist = const AppUser(),
    this.invoice = const InvoiceRecord(),
    this.consultantAssessment = const {},
    this.amAssessment = const {},
    this.historyTaking = const {},
  });

  factory Visit.fromJson(Map<String, dynamic>? json) {
    final data = json ?? {};
    return Visit(
      id: _asInt(data['id']),
      parentVisitId: _asInt(data['parent_visit_id']),
      patientId: _asInt(data['patient_id']),
      clinicId: _asInt(data['clinic_id']),
      receptionistId: _asInt(data['receptionist_id']),
      assistantManagerId: _asInt(data['assistant_manager_id']),
      historyTakerId: _asInt(data['history_taker_id']),
      consultantId: _asInt(data['consultant_id']),
      therapistId: _asInt(data['therapist_id']),
      requestedTherapistId: _asInt(data['requested_therapist_id']),
      dryNeedlerId: _asInt(data['dry_needler_id']),
      pendingDryNeedling: _asBool(data['pending_dry_needling']),
      type: _asString(data['type']),
      status: _asString(data['status']),
      invoiceId: _asInt(data['invoice_id']),
      consultationFee: _asDouble(data['consultation_fee']),
      currentStage: _asString(data['current_stage']),
      requestType: _asString(data['request_type']),
      requestNote: _asString(data['request_note']),
      visitAt: _asString(data['visit_at']),
      giftPicture: _asString(data['gift_picture']),
      createdAt: _asString(data['created_at']),
      updatedAt: _asString(data['updated_at']),
      receptionist: AppUser.fromJson(_asMap(data['receptionist'])),
      assistantManager: AppUser.fromJson(_asMap(data['assistant_manager'])),
      consultant: AppUser.fromJson(_asMap(data['consultant'])),
      therapist: AppUser.fromJson(_asMap(data['therapist'])),
      invoice: InvoiceRecord.fromJson(_asMap(data['invoice'])),
      consultantAssessment: _asMap(data['consultant_assessment']),
      amAssessment: _asMap(data['am_assessment']),
      historyTaking: _asMap(data['history_taking']),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'parent_visit_id': parentVisitId,
    'patient_id': patientId,
    'clinic_id': clinicId,
    'receptionist_id': receptionistId,
    'assistant_manager_id': assistantManagerId,
    'history_taker_id': historyTakerId,
    'consultant_id': consultantId,
    'therapist_id': therapistId,
    'requested_therapist_id': requestedTherapistId,
    'dry_needler_id': dryNeedlerId,
    'pending_dry_needling': pendingDryNeedling,
    'type': type,
    'status': status,
    'invoice_id': invoiceId,
    'consultation_fee': consultationFee,
    'current_stage': currentStage,
    'request_type': requestType,
    'request_note': requestNote,
    'visit_at': visitAt,
    'gift_picture': giftPicture,
    'created_at': createdAt,
    'updated_at': updatedAt,
    'receptionist': receptionist.toJson(),
    'assistant_manager': assistantManager.toJson(),
    'consultant': consultant.toJson(),
    'therapist': therapist.toJson(),
    'invoice': invoice.toJson(),
    'consultant_assessment': consultantAssessment,
    'am_assessment': amAssessment,
    'history_taking': historyTaking,
  };
}

class AppUser {
  final int id;
  final String name;
  final String username;
  final String email;
  final String profilePicture;
  final int isLogin;
  final int userType;
  final int createdBy;
  final int updatedBy;
  final String deletedAt;
  final String createdAt;
  final String updatedAt;
  final int clinicId;
  final int roomId;
  final int departmentId;
  final int designationId;
  final int shiftId;
  final String phone;
  final String cnic;
  final String deviceId;
  final Map<String, dynamic> detail;

  const AppUser({
    this.id = 0,
    this.name = '',
    this.username = '',
    this.email = '',
    this.profilePicture = '',
    this.isLogin = 0,
    this.userType = 0,
    this.createdBy = 0,
    this.updatedBy = 0,
    this.deletedAt = '',
    this.createdAt = '',
    this.updatedAt = '',
    this.clinicId = 0,
    this.roomId = 0,
    this.departmentId = 0,
    this.designationId = 0,
    this.shiftId = 0,
    this.phone = '',
    this.cnic = '',
    this.deviceId = '',
    this.detail = const {},
  });

  factory AppUser.fromJson(Map<String, dynamic>? json) {
    final data = json ?? {};
    return AppUser(
      id: _asInt(data['id']),
      name: _asString(data['name']),
      username: _asString(data['username']),
      email: _asString(data['email']),
      profilePicture: _asString(data['profile_picture']),
      isLogin: _asInt(data['is_login']),
      userType: _asInt(data['user_type']),
      createdBy: _asInt(data['created_by']),
      updatedBy: _asInt(data['updated_by']),
      deletedAt: _asString(data['deleted_at']),
      createdAt: _asString(data['created_at']),
      updatedAt: _asString(data['updated_at']),
      clinicId: _asInt(data['clinic_id']),
      roomId: _asInt(data['room_id']),
      departmentId: _asInt(data['department_id']),
      designationId: _asInt(data['designation_id']),
      shiftId: _asInt(data['shift_id']),
      phone: _asString(data['phone']),
      cnic: _asString(data['cnic']),
      deviceId: _asString(data['device_id']),
      detail: _asMap(data['detail']),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'username': username,
    'email': email,
    'profile_picture': profilePicture,
    'is_login': isLogin,
    'user_type': userType,
    'created_by': createdBy,
    'updated_by': updatedBy,
    'deleted_at': deletedAt,
    'created_at': createdAt,
    'updated_at': updatedAt,
    'clinic_id': clinicId,
    'room_id': roomId,
    'department_id': departmentId,
    'designation_id': designationId,
    'shift_id': shiftId,
    'phone': phone,
    'cnic': cnic,
    'device_id': deviceId,
    'detail': detail,
  };
}

class PatientPackage {
  final int id;
  final String name;
  final int sessions;
  final String price;
  final String image;
  final int createdBy;
  final int updatedBy;
  final String deletedAt;
  final String createdAt;
  final String updatedAt;
  final Map<String, dynamic> pivot;

  const PatientPackage({
    this.id = 0,
    this.name = '',
    this.sessions = 0,
    this.price = '',
    this.image = '',
    this.createdBy = 0,
    this.updatedBy = 0,
    this.deletedAt = '',
    this.createdAt = '',
    this.updatedAt = '',
    this.pivot = const {},
  });

  factory PatientPackage.fromJson(Map<String, dynamic>? json) {
    final data = json ?? {};
    return PatientPackage(
      id: _asInt(data['id']),
      name: _asString(data['name']),
      sessions: _asInt(data['sessions']),
      price: _asString(data['price']),
      image: _asString(data['image']),
      createdBy: _asInt(data['created_by']),
      updatedBy: _asInt(data['updated_by']),
      deletedAt: _asString(data['deleted_at']),
      createdAt: _asString(data['created_at']),
      updatedAt: _asString(data['updated_at']),
      pivot: _asMap(data['pivot']),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'sessions': sessions,
    'price': price,
    'image': image,
    'created_by': createdBy,
    'updated_by': updatedBy,
    'deleted_at': deletedAt,
    'created_at': createdAt,
    'updated_at': updatedAt,
    'pivot': pivot,
  };
}

class Stats {
  final int totalVisits;
  final int consultationVisits;
  final int therapyVisits;
  final int activePackages;
  final int completedPackages;
  final String totalSpend;
  final double totalAmount;
  final double totalSpent;
  final Visit lastVisit;
  final Map<String, dynamic> nextAppointment;

  const Stats({
    this.totalVisits = 0,
    this.consultationVisits = 0,
    this.therapyVisits = 0,
    this.activePackages = 0,
    this.completedPackages = 0,
    this.totalSpend = '',
    this.totalAmount = 0,
    this.totalSpent = 0,
    this.lastVisit = const Visit(),
    this.nextAppointment = const {},
  });

  factory Stats.fromJson(Map<String, dynamic>? json) {
    final data = json ?? {};
    return Stats(
      totalVisits: _asInt(data['total_visits']),
      consultationVisits: _asInt(data['consultation_visits']),
      therapyVisits: _asInt(data['therapy_visits']),
      activePackages: _asInt(data['active_packages']),
      completedPackages: _asInt(data['completed_packages']),
      totalSpend: _asString(data['total_spend']),
      totalAmount: _asDouble(data['total_amount']),
      totalSpent: _asDouble(data['total_spent']),
      lastVisit: Visit.fromJson(_asMap(data['last_visit'])),
      nextAppointment: _asMap(data['next_appointment']),
    );
  }

  Map<String, dynamic> toJson() => {
    'total_visits': totalVisits,
    'consultation_visits': consultationVisits,
    'therapy_visits': therapyVisits,
    'active_packages': activePackages,
    'completed_packages': completedPackages,
    'total_spend': totalSpend,
    'total_amount': totalAmount,
    'total_spent': totalSpent,
    'last_visit': lastVisit.toJson(),
    'next_appointment': nextAppointment,
  };
}

class InvoiceRecord {
  final int id;
  final int patientId;
  final int visitId;
  final int therapySessionId;
  final String type;
  final String amount;
  final String status;
  final int createdBy;
  final int insurancePanelId;
  final String insurancePolicy;
  final double insuranceDiscountAmount;
  final String createdAt;
  final String updatedAt;
  final double paidAmount;
  final double balance;
  final String computedStatus;
  final Map<String, dynamic> visit;
  final List<PaymentRecord> payments;

  const InvoiceRecord({
    this.id = 0,
    this.patientId = 0,
    this.visitId = 0,
    this.therapySessionId = 0,
    this.type = '',
    this.amount = '',
    this.status = '',
    this.createdBy = 0,
    this.insurancePanelId = 0,
    this.insurancePolicy = '',
    this.insuranceDiscountAmount = 0,
    this.createdAt = '',
    this.updatedAt = '',
    this.paidAmount = 0,
    this.balance = 0,
    this.computedStatus = '',
    this.visit = const {},
    this.payments = const [],
  });

  factory InvoiceRecord.fromJson(Map<String, dynamic>? json) {
    final data = json ?? {};
    return InvoiceRecord(
      id: _asInt(data['id']),
      patientId: _asInt(data['patient_id']),
      visitId: _asInt(data['visit_id']),
      therapySessionId: _asInt(data['therapy_session_id']),
      type: _asString(data['type']),
      amount: _asString(data['amount']),
      status: _asString(data['status']),
      createdBy: _asInt(data['created_by']),
      insurancePanelId: _asInt(data['insurance_panel_id']),
      insurancePolicy: _asString(data['insurance_policy']),
      insuranceDiscountAmount: _asDouble(data['insurance_discount_amount']),
      createdAt: _asString(data['created_at']),
      updatedAt: _asString(data['updated_at']),
      paidAmount: _asDouble(data['paid_amount']),
      balance: _asDouble(data['balance']),
      computedStatus: _asString(data['computed_status']),
      visit: _asMap(data['visit']),
      payments: _asListMap(
        data['payments'],
      ).map(PaymentRecord.fromJson).toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'patient_id': patientId,
    'visit_id': visitId,
    'therapy_session_id': therapySessionId,
    'type': type,
    'amount': amount,
    'status': status,
    'created_by': createdBy,
    'insurance_panel_id': insurancePanelId,
    'insurance_policy': insurancePolicy,
    'insurance_discount_amount': insuranceDiscountAmount,
    'created_at': createdAt,
    'updated_at': updatedAt,
    'paid_amount': paidAmount,
    'balance': balance,
    'computed_status': computedStatus,
    'visit': visit,
    'payments': payments.map((e) => e.toJson()).toList(),
  };
}

class PaymentRecord {
  final int id;
  final int invoiceId;
  final int patientId;
  final int clinicId;
  final int createdBy;
  final String amount;
  final String method;
  final String tid;
  final String createdAt;
  final String updatedAt;
  final String type;

  const PaymentRecord({
    this.id = 0,
    this.invoiceId = 0,
    this.patientId = 0,
    this.clinicId = 0,
    this.createdBy = 0,
    this.amount = '',
    this.method = '',
    this.tid = '',
    this.createdAt = '',
    this.updatedAt = '',
    this.type = '',
  });

  factory PaymentRecord.fromJson(Map<String, dynamic>? json) {
    final data = json ?? {};
    return PaymentRecord(
      id: _asInt(data['id']),
      invoiceId: _asInt(data['invoice_id']),
      patientId: _asInt(data['patient_id']),
      clinicId: _asInt(data['clinic_id']),
      createdBy: _asInt(data['created_by']),
      amount: _asString(data['amount']),
      method: _asString(data['method']),
      tid: _asString(data['tid']),
      createdAt: _asString(data['created_at']),
      updatedAt: _asString(data['updated_at']),
      type: _asString(data['type']),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'invoice_id': invoiceId,
    'patient_id': patientId,
    'clinic_id': clinicId,
    'created_by': createdBy,
    'amount': amount,
    'method': method,
    'tid': tid,
    'created_at': createdAt,
    'updated_at': updatedAt,
    'type': type,
  };
}

class TherapySession {
  final int id;
  final int patientId;
  final int visitId;
  final int therapistId;
  final int patientPackageId;
  final String startTime;
  final String endTime;
  final int durationSeconds;
  final Map<String, dynamic> modalitiesData;
  final String nextSessionDate;
  final String notes;
  final String sessionDuration;
  final String visitDuration;
  final int sessionNumber;
  final String createdAt;
  final String updatedAt;
  final int billedInvoiceId;
  final AppUser therapist;
  final Map<String, dynamic> visit;

  const TherapySession({
    this.id = 0,
    this.patientId = 0,
    this.visitId = 0,
    this.therapistId = 0,
    this.patientPackageId = 0,
    this.startTime = '',
    this.endTime = '',
    this.durationSeconds = 0,
    this.modalitiesData = const {},
    this.nextSessionDate = '',
    this.notes = '',
    this.sessionDuration = '',
    this.visitDuration = '',
    this.sessionNumber = 0,
    this.createdAt = '',
    this.updatedAt = '',
    this.billedInvoiceId = 0,
    this.therapist = const AppUser(),
    this.visit = const {},
  });

  factory TherapySession.fromJson(Map<String, dynamic>? json) {
    final data = json ?? {};
    return TherapySession(
      id: _asInt(data['id']),
      patientId: _asInt(data['patient_id']),
      visitId: _asInt(data['visit_id']),
      therapistId: _asInt(data['therapist_id']),
      patientPackageId: _asInt(data['patient_package_id']),
      startTime: _asString(data['start_time']),
      endTime: _asString(data['end_time']),
      durationSeconds: _asInt(data['duration_seconds']),
      modalitiesData: _asMap(data['modalities_data']),
      nextSessionDate: _asString(data['next_session_date']),
      notes: _asString(data['notes']),
      sessionDuration: _asString(data['session_duration']),
      visitDuration: _asString(data['visit_duration']),
      sessionNumber: _asInt(data['session_number']),
      createdAt: _asString(data['created_at']),
      updatedAt: _asString(data['updated_at']),
      billedInvoiceId: _asInt(data['billed_invoice_id']),
      therapist: AppUser.fromJson(_asMap(data['therapist'])),
      visit: _asMap(data['visit']),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'patient_id': patientId,
    'visit_id': visitId,
    'therapist_id': therapistId,
    'patient_package_id': patientPackageId,
    'start_time': startTime,
    'end_time': endTime,
    'duration_seconds': durationSeconds,
    'modalities_data': modalitiesData,
    'next_session_date': nextSessionDate,
    'notes': notes,
    'session_duration': sessionDuration,
    'visit_duration': visitDuration,
    'session_number': sessionNumber,
    'created_at': createdAt,
    'updated_at': updatedAt,
    'billed_invoice_id': billedInvoiceId,
    'therapist': therapist.toJson(),
    'visit': visit,
  };
}

// ---------- Null-safe helpers ----------
String _asString(dynamic v) => v?.toString() ?? '';
int _asInt(dynamic v) {
  if (v == null) return 0;
  if (v is int) return v;
  return int.tryParse(v.toString()) ?? 0;
}

double _asDouble(dynamic v) {
  if (v == null) return 0;
  if (v is double) return v;
  if (v is int) return v.toDouble();
  return double.tryParse(v.toString()) ?? 0;
}

bool _asBool(dynamic v) {
  if (v is bool) return v;
  if (v is num) return v != 0;
  if (v is String) return v.toLowerCase() == 'true' || v == '1';
  return false;
}

List<String> _asStringList(dynamic v) {
  if (v is List) return v.map((e) => e?.toString() ?? '').toList();
  return const [];
}

List<Map<String, dynamic>> _asListMap(dynamic v) {
  if (v is List) {
    return v
        .map((e) => e is Map<String, dynamic> ? e : <String, dynamic>{})
        .toList();
  }
  return const [];
}

Map<String, dynamic> _asMap(dynamic v) {
  if (v is Map<String, dynamic>) return v;
  return <String, dynamic>{};
}
