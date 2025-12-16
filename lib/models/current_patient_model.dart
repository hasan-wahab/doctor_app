class CurrentPatientModel {
  CurrentPatientModel({
    required this.patient,
    required this.stats,
    required this.recentInvoices,
    required this.therapySessions,
  });

  final Patient? patient;
  final Stats? stats;
  final List<Invoice> recentInvoices;
  final List<TherapySession> therapySessions;

  factory CurrentPatientModel.fromJson(Map<String, dynamic> json){
    return CurrentPatientModel(
      patient: json["patient"] == null ? null : Patient.fromJson(json["patient"]),
      stats: json["stats"] == null ? null : Stats.fromJson(json["stats"]),
      recentInvoices: json["recent_invoices"] == null ? [] : List<Invoice>.from(json["recent_invoices"]!.map((x) => Invoice.fromJson(x))),
      therapySessions: json["therapy_sessions"] == null ? [] : List<TherapySession>.from(json["therapy_sessions"]!.map((x) => TherapySession.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "patient": patient?.toJson(),
    "stats": stats?.toJson(),
    "recent_invoices": recentInvoices.map((x) => x?.toJson()).toList(),
    "therapy_sessions": therapySessions.map((x) => x?.toJson()).toList(),
  };

}

class Patient {
  Patient({
    required this.id,
    required this.name,
    required this.email,
    required this.address,
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
    required this.walletBalance,
    required this.createdAt,
    required this.updatedAt,
    required this.createdBy,
    required this.updatedBy,
    required this.deletedAt,
    required this.userId,
    required this.visits,
    required this.packages,
    required this.user,
  });

  final int? id;
  final String? name;
  final String? email;
  final dynamic address;
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
  final dynamic cardUid;
  final int? walletBalance;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? createdBy;
  final int? updatedBy;
  final dynamic deletedAt;
  final int? userId;
  final List<LastVisitElement> visits;
  final List<Package> packages;
  final User? user;

  factory Patient.fromJson(Map<String, dynamic> json){
    return Patient(
      id: json["id"],
      name: json["name"],
      email: json["email"],
      address: json["address"],
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
      walletBalance: json["wallet_balance"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      createdBy: json["created_by"],
      updatedBy: json["updated_by"],
      deletedAt: json["deleted_at"],
      userId: json["user_id"],
      visits: json["visits"] == null ? [] : List<LastVisitElement>.from(json["visits"]!.map((x) => LastVisitElement.fromJson(x))),
      packages: json["packages"] == null ? [] : List<Package>.from(json["packages"]!.map((x) => Package.fromJson(x))),
      user: json["user"] == null ? null : User.fromJson(json["user"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "address": address,
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
    "wallet_balance": walletBalance,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "created_by": createdBy,
    "updated_by": updatedBy,
    "deleted_at": deletedAt,
    "user_id": userId,
    "visits": visits.map((x) => x?.toJson()).toList(),
    "packages": packages.map((x) => x?.toJson()).toList(),
    "user": user?.toJson(),
  };

}

class Package {
  Package({
    required this.id,
    required this.name,
    required this.sessions,
    required this.price,
    required this.createdBy,
    required this.updatedBy,
    required this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.pivot,
  });

  final int? id;
  final String? name;
  final int? sessions;
  final String? price;
  final int? createdBy;
  final int? updatedBy;
  final dynamic deletedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Pivot? pivot;

  factory Package.fromJson(Map<String, dynamic> json){
    return Package(
      id: json["id"],
      name: json["name"],
      sessions: json["sessions"],
      price: json["price"],
      createdBy: json["created_by"],
      updatedBy: json["updated_by"],
      deletedAt: json["deleted_at"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      pivot: json["pivot"] == null ? null : Pivot.fromJson(json["pivot"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "sessions": sessions,
    "price": price,
    "created_by": createdBy,
    "updated_by": updatedBy,
    "deleted_at": deletedAt,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "pivot": pivot?.toJson(),
  };

}

class Pivot {
  Pivot({
    required this.patientId,
    required this.packageId,
    required this.status,
    required this.sessionsUsed,
    required this.sessionsTotal,
    required this.price,
    required this.startsAt,
    required this.createdAt,
    required this.updatedAt,
  });

  final int? patientId;
  final int? packageId;
  final String? status;
  final int? sessionsUsed;
  final int? sessionsTotal;
  final int? price;
  final dynamic startsAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory Pivot.fromJson(Map<String, dynamic> json){
    return Pivot(
      patientId: json["patient_id"],
      packageId: json["package_id"],
      status: json["status"],
      sessionsUsed: json["sessions_used"],
      sessionsTotal: json["sessions_total"],
      price: json["price"],
      startsAt: json["starts_at"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
    "patient_id": patientId,
    "package_id": packageId,
    "status": status,
    "sessions_used": sessionsUsed,
    "sessions_total": sessionsTotal,
    "price": price,
    "starts_at": startsAt,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };

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
  final int? clinicId;
  final int? roomId;
  final int? departmentId;
  final int? designationId;
  final int? shiftId;
  final String? phone;
  final String? cnic;

  factory User.fromJson(Map<String, dynamic> json){
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

  Map<String, dynamic> toJson() => {
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

class LastVisitElement {
  LastVisitElement({
    required this.id,
    required this.parentVisitId,
    required this.patientId,
    required this.clinicId,
    required this.receptionistId,
    required this.assistantManagerId,
    required this.consultantId,
    required this.therapistId,
    required this.type,
    required this.status,
    required this.invoiceId,
    required this.consultationFee,
    required this.currentStage,
    required this.visitAt,
    required this.createdAt,
    required this.updatedAt,
    required this.receptionist,
    required this.assistantManager,
    required this.consultant,
    required this.therapist,
    required this.invoice,
    required this.consultantAssessment,
    required this.amAssessment,
  });

  final int? id;
  final dynamic parentVisitId;
  final int? patientId;
  final int? clinicId;
  final int? receptionistId;
  final int? assistantManagerId;
  final int? consultantId;
  final int? therapistId;
  final String? type;
  final dynamic status;
  final dynamic invoiceId;
  final int? consultationFee;
  final String? currentStage;
  final DateTime? visitAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final User? receptionist;
  final User? assistantManager;
  final User? consultant;
  final User? therapist;
  final Invoice? invoice;
  final ConsultantAssessment? consultantAssessment;
  final AmAssessment? amAssessment;

  factory LastVisitElement.fromJson(Map<String, dynamic> json){
    return LastVisitElement(
      id: json["id"],
      parentVisitId: json["parent_visit_id"],
      patientId: json["patient_id"],
      clinicId: json["clinic_id"],
      receptionistId: json["receptionist_id"],
      assistantManagerId: json["assistant_manager_id"],
      consultantId: json["consultant_id"],
      therapistId: json["therapist_id"],
      type: json["type"],
      status: json["status"],
      invoiceId: json["invoice_id"],
      consultationFee: json["consultation_fee"],
      currentStage: json["current_stage"],
      visitAt: DateTime.tryParse(json["visit_at"] ?? ""),
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      receptionist: json["receptionist"] == null ? null : User.fromJson(json["receptionist"]),
      assistantManager: json["assistant_manager"] == null ? null : User.fromJson(json["assistant_manager"]),
      consultant: json["consultant"] == null ? null : User.fromJson(json["consultant"]),
      therapist: json["therapist"] == null ? null : User.fromJson(json["therapist"]),
      invoice: json["invoice"] == null ? null : Invoice.fromJson(json["invoice"]),
      consultantAssessment: json["consultant_assessment"] == null ? null : ConsultantAssessment.fromJson(json["consultant_assessment"]),
      amAssessment: json["am_assessment"] == null ? null : AmAssessment.fromJson(json["am_assessment"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "parent_visit_id": parentVisitId,
    "patient_id": patientId,
    "clinic_id": clinicId,
    "receptionist_id": receptionistId,
    "assistant_manager_id": assistantManagerId,
    "consultant_id": consultantId,
    "therapist_id": therapistId,
    "type": type,
    "status": status,
    "invoice_id": invoiceId,
    "consultation_fee": consultationFee,
    "current_stage": currentStage,
    "visit_at": visitAt?.toIso8601String(),
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "receptionist": receptionist?.toJson(),
    "assistant_manager": assistantManager?.toJson(),
    "consultant": consultant?.toJson(),
    "therapist": therapist?.toJson(),
    "invoice": invoice?.toJson(),
    "consultant_assessment": consultantAssessment?.toJson(),
    "am_assessment": amAssessment?.toJson(),
  };

}

class AmAssessment {
  AmAssessment({
    required this.id,
    required this.visitId,
    required this.assistantManagerId,
    required this.occupation,
    required this.dailyActivities,
    required this.chiefComplaint,
    required this.complaintOnset,
    required this.onsetType,
    required this.painLocation,
    required this.painType,
    required this.painSeverity,
    required this.painRadiation,
    required this.aggravatingFactors,
    required this.relievingFactors,
    required this.symptomPattern,
    required this.symptomProgression,
    required this.functionalLimitations,
    required this.functionalImpact,
    required this.activitiesUnable,
    required this.pastSimilarSymptoms,
    required this.pastInjuriesSurgeries,
    required this.chronicConditions,
    required this.currentMedications,
    required this.jobDetails,
    required this.exerciseHabits,
    required this.smokingStatus,
    required this.alcoholStatus,
    required this.redFlags,
    required this.nightPain,
    required this.sleepPosition,
    required this.sleepSupports,
    required this.patientGoals,
    required this.additionalNotes,
    required this.consentGiven,
    required this.consultantId,
    required this.createdAt,
    required this.updatedAt,
  });

  final int? id;
  final int? visitId;
  final int? assistantManagerId;
  final dynamic occupation;
  final dynamic dailyActivities;
  final String? chiefComplaint;
  final dynamic complaintOnset;
  final dynamic onsetType;
  final dynamic painLocation;
  final dynamic painType;
  final dynamic painSeverity;
  final dynamic painRadiation;
  final dynamic aggravatingFactors;
  final dynamic relievingFactors;
  final dynamic symptomPattern;
  final dynamic symptomProgression;
  final List<String> functionalLimitations;
  final dynamic functionalImpact;
  final dynamic activitiesUnable;
  final dynamic pastSimilarSymptoms;
  final dynamic pastInjuriesSurgeries;
  final dynamic chronicConditions;
  final dynamic currentMedications;
  final dynamic jobDetails;
  final dynamic exerciseHabits;
  final dynamic smokingStatus;
  final dynamic alcoholStatus;
  final List<String> redFlags;
  final dynamic nightPain;
  final dynamic sleepPosition;
  final dynamic sleepSupports;
  final String? patientGoals;
  final dynamic additionalNotes;
  final bool? consentGiven;
  final int? consultantId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory AmAssessment.fromJson(Map<String, dynamic> json){
    return AmAssessment(
      id: json["id"],
      visitId: json["visit_id"],
      assistantManagerId: json["assistant_manager_id"],
      occupation: json["occupation"],
      dailyActivities: json["daily_activities"],
      chiefComplaint: json["chief_complaint"],
      complaintOnset: json["complaint_onset"],
      onsetType: json["onset_type"],
      painLocation: json["pain_location"],
      painType: json["pain_type"],
      painSeverity: json["pain_severity"],
      painRadiation: json["pain_radiation"],
      aggravatingFactors: json["aggravating_factors"],
      relievingFactors: json["relieving_factors"],
      symptomPattern: json["symptom_pattern"],
      symptomProgression: json["symptom_progression"],
      functionalLimitations: json["functional_limitations"] == null ? [] : List<String>.from(json["functional_limitations"]!.map((x) => x)),
      functionalImpact: json["functional_impact"],
      activitiesUnable: json["activities_unable"],
      pastSimilarSymptoms: json["past_similar_symptoms"],
      pastInjuriesSurgeries: json["past_injuries_surgeries"],
      chronicConditions: json["chronic_conditions"],
      currentMedications: json["current_medications"],
      jobDetails: json["job_details"],
      exerciseHabits: json["exercise_habits"],
      smokingStatus: json["smoking_status"],
      alcoholStatus: json["alcohol_status"],
      redFlags: json["red_flags"] == null ? [] : List<String>.from(json["red_flags"]!.map((x) => x)),
      nightPain: json["night_pain"],
      sleepPosition: json["sleep_position"],
      sleepSupports: json["sleep_supports"],
      patientGoals: json["patient_goals"],
      additionalNotes: json["additional_notes"],
      consentGiven: json["consent_given"],
      consultantId: json["consultant_id"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "visit_id": visitId,
    "assistant_manager_id": assistantManagerId,
    "occupation": occupation,
    "daily_activities": dailyActivities,
    "chief_complaint": chiefComplaint,
    "complaint_onset": complaintOnset,
    "onset_type": onsetType,
    "pain_location": painLocation,
    "pain_type": painType,
    "pain_severity": painSeverity,
    "pain_radiation": painRadiation,
    "aggravating_factors": aggravatingFactors,
    "relieving_factors": relievingFactors,
    "symptom_pattern": symptomPattern,
    "symptom_progression": symptomProgression,
    "functional_limitations": functionalLimitations.map((x) => x).toList(),
    "functional_impact": functionalImpact,
    "activities_unable": activitiesUnable,
    "past_similar_symptoms": pastSimilarSymptoms,
    "past_injuries_surgeries": pastInjuriesSurgeries,
    "chronic_conditions": chronicConditions,
    "current_medications": currentMedications,
    "job_details": jobDetails,
    "exercise_habits": exerciseHabits,
    "smoking_status": smokingStatus,
    "alcohol_status": alcoholStatus,
    "red_flags": redFlags.map((x) => x).toList(),
    "night_pain": nightPain,
    "sleep_position": sleepPosition,
    "sleep_supports": sleepSupports,
    "patient_goals": patientGoals,
    "additional_notes": additionalNotes,
    "consent_given": consentGiven,
    "consultant_id": consultantId,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };

}

class ConsultantAssessment {
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

  final int? id;
  final int? patientId;
  final int? visitId;
  final int? consultantId;
  final String? observationFindings;
  final String? palpationResults;
  final String? romAssessment;
  final String? neuroSpecialTests;
  final String? differentialDiagnoses;
  final String? finalDiagnosis;
  final int? freqPerWeek;
  final int? durationWeeks;
  final List<String> treatments;
  final String? medPainReliever;
  final String? medMuscleRelaxant;
  final String? medSupplements;
  final String? invXray;
  final String? invMri;
  final String? invBloodTests;
  final String? adviceActivity;
  final String? adviceErgonomics;
  final String? adviceHomeEx;
  final DateTime? nextReviewDate;
  final String? rehabGoals;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory ConsultantAssessment.fromJson(Map<String, dynamic> json){
    return ConsultantAssessment(
      id: json["id"],
      patientId: json["patient_id"],
      visitId: json["visit_id"],
      consultantId: json["consultant_id"],
      observationFindings: json["observation_findings"],
      palpationResults: json["palpation_results"],
      romAssessment: json["rom_assessment"],
      neuroSpecialTests: json["neuro_special_tests"],
      differentialDiagnoses: json["differential_diagnoses"],
      finalDiagnosis: json["final_diagnosis"],
      freqPerWeek: json["freq_per_week"],
      durationWeeks: json["duration_weeks"],
      treatments: json["treatments"] == null ? [] : List<String>.from(json["treatments"]!.map((x) => x)),
      medPainReliever: json["med_pain_reliever"],
      medMuscleRelaxant: json["med_muscle_relaxant"],
      medSupplements: json["med_supplements"],
      invXray: json["inv_xray"],
      invMri: json["inv_mri"],
      invBloodTests: json["inv_blood_tests"],
      adviceActivity: json["advice_activity"],
      adviceErgonomics: json["advice_ergonomics"],
      adviceHomeEx: json["advice_home_ex"],
      nextReviewDate: DateTime.tryParse(json["next_review_date"] ?? ""),
      rehabGoals: json["rehab_goals"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "patient_id": patientId,
    "visit_id": visitId,
    "consultant_id": consultantId,
    "observation_findings": observationFindings,
    "palpation_results": palpationResults,
    "rom_assessment": romAssessment,
    "neuro_special_tests": neuroSpecialTests,
    "differential_diagnoses": differentialDiagnoses,
    "final_diagnosis": finalDiagnosis,
    "freq_per_week": freqPerWeek,
    "duration_weeks": durationWeeks,
    "treatments": treatments.map((x) => x).toList(),
    "med_pain_reliever": medPainReliever,
    "med_muscle_relaxant": medMuscleRelaxant,
    "med_supplements": medSupplements,
    "inv_xray": invXray,
    "inv_mri": invMri,
    "inv_blood_tests": invBloodTests,
    "advice_activity": adviceActivity,
    "advice_ergonomics": adviceErgonomics,
    "advice_home_ex": adviceHomeEx,
    "next_review_date": nextReviewDate?.toIso8601String(),
    "rehab_goals": rehabGoals,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };

}

class Invoice {
  Invoice({
    required this.id,
    required this.patientId,
    required this.visitId,
    required this.therapySessionId,
    required this.type,
    required this.amount,
    required this.status,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    required this.visit,
  });

  final int? id;
  final int? patientId;
  final int? visitId;
  final dynamic therapySessionId;
  final String? type;
  final String? amount;
  final String? status;
  final int? createdBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final RecentInvoiceVisit? visit;

  factory Invoice.fromJson(Map<String, dynamic> json){
    return Invoice(
      id: json["id"],
      patientId: json["patient_id"],
      visitId: json["visit_id"],
      therapySessionId: json["therapy_session_id"],
      type: json["type"],
      amount: json["amount"],
      status: json["status"],
      createdBy: json["created_by"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      visit: json["visit"] == null ? null : RecentInvoiceVisit.fromJson(json["visit"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "patient_id": patientId,
    "visit_id": visitId,
    "therapy_session_id": therapySessionId,
    "type": type,
    "amount": amount,
    "status": status,
    "created_by": createdBy,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "visit": visit?.toJson(),
  };

}

class RecentInvoiceVisit {
  RecentInvoiceVisit({
    required this.id,
    required this.parentVisitId,
    required this.patientId,
    required this.clinicId,
    required this.receptionistId,
    required this.assistantManagerId,
    required this.consultantId,
    required this.therapistId,
    required this.type,
    required this.status,
    required this.invoiceId,
    required this.consultationFee,
    required this.currentStage,
    required this.visitAt,
    required this.createdAt,
    required this.updatedAt,
  });

  final int? id;
  final dynamic parentVisitId;
  final int? patientId;
  final int? clinicId;
  final int? receptionistId;
  final int? assistantManagerId;
  final int? consultantId;
  final int? therapistId;
  final String? type;
  final dynamic status;
  final dynamic invoiceId;
  final int? consultationFee;
  final String? currentStage;
  final DateTime? visitAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory RecentInvoiceVisit.fromJson(Map<String, dynamic> json){
    return RecentInvoiceVisit(
      id: json["id"],
      parentVisitId: json["parent_visit_id"],
      patientId: json["patient_id"],
      clinicId: json["clinic_id"],
      receptionistId: json["receptionist_id"],
      assistantManagerId: json["assistant_manager_id"],
      consultantId: json["consultant_id"],
      therapistId: json["therapist_id"],
      type: json["type"],
      status: json["status"],
      invoiceId: json["invoice_id"],
      consultationFee: json["consultation_fee"],
      currentStage: json["current_stage"],
      visitAt: DateTime.tryParse(json["visit_at"] ?? ""),
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "parent_visit_id": parentVisitId,
    "patient_id": patientId,
    "clinic_id": clinicId,
    "receptionist_id": receptionistId,
    "assistant_manager_id": assistantManagerId,
    "consultant_id": consultantId,
    "therapist_id": therapistId,
    "type": type,
    "status": status,
    "invoice_id": invoiceId,
    "consultation_fee": consultationFee,
    "current_stage": currentStage,
    "visit_at": visitAt?.toIso8601String(),
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };

}

class Stats {
  Stats({
    required this.totalVisits,
    required this.consultationVisits,
    required this.therapyVisits,
    required this.activePackages,
    required this.completedPackages,
    required this.totalSpent,
    required this.lastVisit,
    required this.nextAppointment,
  });

  final int? totalVisits;
  final int? consultationVisits;
  final int? therapyVisits;
  final int? activePackages;
  final int? completedPackages;
  final int? totalSpent;
  final LastVisitElement? lastVisit;
  final dynamic nextAppointment;

  factory Stats.fromJson(Map<String, dynamic> json){
    return Stats(
      totalVisits: json["total_visits"],
      consultationVisits: json["consultation_visits"],
      therapyVisits: json["therapy_visits"],
      activePackages: json["active_packages"],
      completedPackages: json["completed_packages"],
      totalSpent: json["total_spent"],
      lastVisit: json["last_visit"] == null ? null : LastVisitElement.fromJson(json["last_visit"]),
      nextAppointment: json["next_appointment"],
    );
  }

  Map<String, dynamic> toJson() => {
    "total_visits": totalVisits,
    "consultation_visits": consultationVisits,
    "therapy_visits": therapyVisits,
    "active_packages": activePackages,
    "completed_packages": completedPackages,
    "total_spent": totalSpent,
    "last_visit": lastVisit?.toJson(),
    "next_appointment": nextAppointment,
  };

}

class TherapySession {
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
    required this.sessionNumber,
    required this.createdAt,
    required this.updatedAt,
    required this.billedInvoiceId,
    required this.therapist,
    required this.visit,
  });

  final int? id;
  final int? patientId;
  final int? visitId;
  final int? therapistId;
  final int? patientPackageId;
  final DateTime? startTime;
  final DateTime? endTime;
  final int? durationSeconds;
  final DateTime? nextSessionDate;
  final String? notes;
  final dynamic sessionNumber;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic billedInvoiceId;
  final User? therapist;
  final RecentInvoiceVisit? visit;

  factory TherapySession.fromJson(Map<String, dynamic> json){
    return TherapySession(
      id: json["id"],
      patientId: json["patient_id"],
      visitId: json["visit_id"],
      therapistId: json["therapist_id"],
      patientPackageId: json["patient_package_id"],
      startTime: DateTime.tryParse(json["start_time"] ?? ""),
      endTime: DateTime.tryParse(json["end_time"] ?? ""),
      durationSeconds: json["duration_seconds"],
      nextSessionDate: DateTime.tryParse(json["next_session_date"] ?? ""),
      notes: json["notes"],
      sessionNumber: json["session_number"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      billedInvoiceId: json["billed_invoice_id"],
      therapist: json["therapist"] == null ? null : User.fromJson(json["therapist"]),
      visit: json["visit"] == null ? null : RecentInvoiceVisit.fromJson(json["visit"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "patient_id": patientId,
    "visit_id": visitId,
    "therapist_id": therapistId,
    "patient_package_id": patientPackageId,
    "start_time": startTime?.toIso8601String(),
    "end_time": endTime?.toIso8601String(),
    "duration_seconds": durationSeconds,
    "next_session_date": nextSessionDate?.toIso8601String(),
    "notes": notes,
    "session_number": sessionNumber,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "billed_invoice_id": billedInvoiceId,
    "therapist": therapist?.toJson(),
    "visit": visit?.toJson(),
  };

}
