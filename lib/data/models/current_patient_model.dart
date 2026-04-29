// ============================================================
// CURRENT PATIENT MODEL — Single File | Full Null Safe
// Every field uses safe parsing — no as String? casts anywhere
// ============================================================

// ─────────────────────────────────────────────────────────────
// Helpers
// ─────────────────────────────────────────────────────────────

/// Safely converts any dynamic value to List<String>
List<String> _strList(dynamic v) {
  if (v == null) return [];
  if (v is List) return v.map((e) => e?.toString() ?? '').toList();
  return [];
}

/// Safely converts any value to String? — never crashes on List/int/bool
String? _str(dynamic v) {
  if (v == null) return null;
  if (v is String) return v.isEmpty ? null : v;
  if (v is List)
    return v.isEmpty ? null : v.map((e) => e?.toString() ?? '').join(', ');
  return v.toString();
}

/// Safely converts any value to double?
double? _dbl(dynamic v) {
  if (v == null) return null;
  return double.tryParse(v.toString());
}

/// Safely converts any value to int?
int? _int(dynamic v) {
  if (v == null) return null;
  if (v is int) return v;
  return int.tryParse(v.toString());
}

/// Safely converts any value to bool?
bool? _bool(dynamic v) {
  if (v == null) return null;
  if (v is bool) return v;
  if (v is int) return v == 1;
  if (v is String) return v.toLowerCase() == 'true' || v == '1';
  return null;
}

/// Display helper — returns 'No data' for null/empty values
String _display(dynamic v) {
  if (v == null) return 'No data';
  if (v is String && v.trim().isEmpty) return 'No data';
  if (v is List && v.isEmpty) return 'No data';
  if (v is List) return v.join(', ');
  return v.toString();
}

// ─────────────────────────────────────────────────────────────
// ROOT — CurrentPatientModel
// ─────────────────────────────────────────────────────────────
class CurrentPatientModel {
  final PatientModel? patient;
  final PatientStatsModel? stats;
  final List<InvoiceModel> recentInvoices;
  final List<TherapySessionModel> therapySessions;

  CurrentPatientModel({
    this.patient,
    this.stats,
    this.recentInvoices = const [],
    this.therapySessions = const [],
  });

  factory CurrentPatientModel.fromJson(Map<String, dynamic> json) {
    return CurrentPatientModel(
      patient: json['patient'] != null
          ? PatientModel.fromJson(json['patient'] as Map<String, dynamic>)
          : null,
      stats: json['stats'] != null
          ? PatientStatsModel.fromJson(json['stats'] as Map<String, dynamic>)
          : null,
      recentInvoices: (json['recent_invoices'] as List<dynamic>? ?? [])
          .map((e) => InvoiceModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      therapySessions: (json['therapy_sessions'] as List<dynamic>? ?? [])
          .map((e) => TherapySessionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'patient': patient?.toJson(),
    'stats': stats?.toJson(),
    'recent_invoices': recentInvoices.map((e) => e.toJson()).toList(),
    'therapy_sessions': therapySessions.map((e) => e.toJson()).toList(),
  };
}

// ─────────────────────────────────────────────────────────────
// 1. PatientModel
// ─────────────────────────────────────────────────────────────
class PatientModel {
  final int? id;
  final String? name;
  final String? fatherHusbandName;
  final String? email;
  final String? address;
  final String? city;
  final String? cityOther;
  final String? passportNo;
  final String? phone;
  final String? occupation;
  final String? emergencyContactPhone;
  final String? cnic;
  final String? gender;
  final String? maritalStatus;
  final String? maritalStatusLabel;
  final String? birthDate;
  final int? age;
  final String? bloodGroup;
  final String? languages;
  final String? languagesOther;
  final String? referBy;
  final String? insurance;
  final String? imageUrl;
  final String? status;
  final String? cardUid;
  final double? walletBalance;
  final String? insurancePanel;
  final String? createdAt;
  final String? updatedAt;
  final List<String> languagesLabels;
  final List<VisitModel> visits;
  final List<PackageModel> packages;
  final UserModel? user;

  PatientModel({
    this.id,
    this.name,
    this.fatherHusbandName,
    this.email,
    this.address,
    this.city,
    this.cityOther,
    this.passportNo,
    this.phone,
    this.occupation,
    this.emergencyContactPhone,
    this.cnic,
    this.gender,
    this.maritalStatus,
    this.maritalStatusLabel,
    this.birthDate,
    this.age,
    this.bloodGroup,
    this.languages,
    this.languagesOther,
    this.referBy,
    this.insurance,
    this.imageUrl,
    this.status,
    this.cardUid,
    this.walletBalance,
    this.insurancePanel,
    this.createdAt,
    this.updatedAt,
    this.languagesLabels = const [],
    this.visits = const [],
    this.packages = const [],
    this.user,
  });

  String get displayId => _display(id);
  String get displayName => _display(name);
  String get displayFatherHusbandName => _display(fatherHusbandName);
  String get displayEmail => _display(email);
  String get displayAddress => _display(address);
  String get displayCity => _display(city);
  String get displayPhone => _display(phone);
  String get displayOccupation => _display(occupation);
  String get displayEmergencyContactPhone => _display(emergencyContactPhone);
  String get displayCnic => _display(cnic);
  String get displayGender => _display(gender);
  String get displayMaritalStatus =>
      _display(maritalStatusLabel ?? maritalStatus);
  String get displayBirthDate => _display(birthDate);
  String get displayAge => _display(age);
  String get displayBloodGroup => _display(bloodGroup);
  String get displayLanguages => _display(
    languagesLabels.isEmpty ? languages : languagesLabels.join(', '),
  );
  String get displayReferBy => _display(referBy);
  String get displayInsurance => _display(insurance);
  String get displayImageUrl => _display(imageUrl);
  String get displayStatus => _display(status);
  String get displayWalletBalance => _display(walletBalance);
  String get displayCreatedAt => _display(createdAt);

  factory PatientModel.fromJson(Map<String, dynamic> json) {
    return PatientModel(
      id: _int(json['id']),
      name: _str(json['name']),
      fatherHusbandName: _str(json['father_husband_name']),
      email: _str(json['email']),
      address: _str(json['address']),
      city: _str(json['city_label']) ?? _str(json['city']),
      cityOther: _str(json['city_other']),
      passportNo: _str(json['passport_no']),
      phone: _str(json['phone']),
      occupation: _str(json['occupation']),
      emergencyContactPhone: _str(json['emergency_contact_phone']),
      cnic: _str(json['cnic']),
      gender: _str(json['gender']),
      maritalStatus: _str(json['marital_status']),
      maritalStatusLabel: _str(json['marital_status_label']),
      birthDate: _str(json['birth_date']),
      age: _int(json['age']),
      bloodGroup: _str(json['blood_group']),
      languages: _str(json['languages']),
      languagesOther: _str(json['languages_other']),
      referBy: _str(json['refer_by']),
      insurance: _str(json['insurance']),
      imageUrl: _str(json['image_url']),
      status: _str(json['status']),
      cardUid: _str(json['card_uid']),
      walletBalance: _dbl(json['wallet_balance']),
      insurancePanel: _str(json['insurance_panel']),
      createdAt: _str(json['created_at']),
      updatedAt: _str(json['updated_at']),
      languagesLabels: _strList(json['languages_labels']),
      visits: (json['visits'] as List<dynamic>? ?? [])
          .map((e) => VisitModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      packages: (json['packages'] as List<dynamic>? ?? [])
          .map((e) => PackageModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      user: json['user'] != null
          ? UserModel.fromJson(json['user'] as Map<String, dynamic>)
          : null,
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
    'marital_status_label': maritalStatusLabel,
    'birth_date': birthDate,
    'age': age,
    'blood_group': bloodGroup,
    'languages': languages,
    'languages_other': languagesOther,
    'refer_by': referBy,
    'insurance': insurance,
    'image_url': imageUrl,
    'status': status,
    'card_uid': cardUid,
    'wallet_balance': walletBalance,
    'insurance_panel': insurancePanel,
    'created_at': createdAt,
    'updated_at': updatedAt,
    'languages_labels': languagesLabels,
    'visits': visits.map((e) => e.toJson()).toList(),
    'packages': packages.map((e) => e.toJson()).toList(),
    'user': user?.toJson(),
  };
}

// ─────────────────────────────────────────────────────────────
// 2. UserModel
// ─────────────────────────────────────────────────────────────
class UserModel {
  final int? id;
  final String? name;
  final String? username;
  final String? email;
  final String? profilePicture;
  final String? phone;
  final String? cnic;
  final int? userType;
  final int? isLogin;
  final String? createdAt;
  final String? updatedAt;

  UserModel({
    this.id,
    this.name,
    this.username,
    this.email,
    this.profilePicture,
    this.phone,
    this.cnic,
    this.userType,
    this.isLogin,
    this.createdAt,
    this.updatedAt,
  });

  String get displayId => _display(id);
  String get displayName => _display(name);
  String get displayUsername => _display(username);
  String get displayEmail => _display(email);
  String get displayPhone => _display(phone);
  String get displayCnic => _display(cnic);
  String get displayProfilePicture => _display(profilePicture);

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: _int(json['id']),
    name: _str(json['name']),
    username: _str(json['username']),
    email: _str(json['email']),
    profilePicture: _str(json['profile_picture']),
    phone: _str(json['phone']),
    cnic: _str(json['cnic']),
    userType: _int(json['user_type']),
    isLogin: _int(json['is_login']),
    createdAt: _str(json['created_at']),
    updatedAt: _str(json['updated_at']),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'username': username,
    'email': email,
    'profile_picture': profilePicture,
    'phone': phone,
    'cnic': cnic,
    'user_type': userType,
    'is_login': isLogin,
    'created_at': createdAt,
    'updated_at': updatedAt,
  };
}

// ─────────────────────────────────────────────────────────────
// 3. VisitModel
// ─────────────────────────────────────────────────────────────
class VisitModel {
  final int? id;
  final String? type;
  final String? currentStage;
  final String? visitAt;
  final double? consultationFee;
  final String? status;
  final UserModel? receptionist;
  final UserModel? assistantManager;
  final UserModel? consultant;
  final UserModel? therapist;
  final InvoiceModel? invoice;
  final ConsultantAssessmentModel? consultantAssessment;
  final HistoryTakingModel? historyTaking;

  VisitModel({
    this.id,
    this.type,
    this.currentStage,
    this.visitAt,
    this.consultationFee,
    this.status,
    this.receptionist,
    this.assistantManager,
    this.consultant,
    this.therapist,
    this.invoice,
    this.consultantAssessment,
    this.historyTaking,
  });

  String get displayId => _display(id);
  String get displayType => _display(type);
  String get displayCurrentStage => _display(currentStage);
  String get displayVisitAt => _display(visitAt);
  String get displayConsultationFee => _display(consultationFee);
  String get displayStatus => _display(status);

  factory VisitModel.fromJson(Map<String, dynamic> json) => VisitModel(
    id: _int(json['id']),
    type: _str(json['type']),
    currentStage: _str(json['current_stage']),
    visitAt: _str(json['visit_at']),
    consultationFee: _dbl(json['consultation_fee']),
    status: _str(json['status']),
    receptionist: json['receptionist'] is Map
        ? UserModel.fromJson(json['receptionist'] as Map<String, dynamic>)
        : null,
    assistantManager: json['assistant_manager'] is Map
        ? UserModel.fromJson(json['assistant_manager'] as Map<String, dynamic>)
        : null,
    consultant: json['consultant'] is Map
        ? UserModel.fromJson(json['consultant'] as Map<String, dynamic>)
        : null,
    therapist: json['therapist'] is Map
        ? UserModel.fromJson(json['therapist'] as Map<String, dynamic>)
        : null,
    invoice: json['invoice'] is Map
        ? InvoiceModel.fromJson(json['invoice'] as Map<String, dynamic>)
        : null,
    consultantAssessment: json['consultant_assessment'] is Map
        ? ConsultantAssessmentModel.fromJson(
            json['consultant_assessment'] as Map<String, dynamic>,
          )
        : null,
    historyTaking: json['history_taking'] is Map
        ? HistoryTakingModel.fromJson(
            json['history_taking'] as Map<String, dynamic>,
          )
        : null,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'type': type,
    'current_stage': currentStage,
    'visit_at': visitAt,
    'consultation_fee': consultationFee,
    'status': status,
    'receptionist': receptionist?.toJson(),
    'assistant_manager': assistantManager?.toJson(),
    'consultant': consultant?.toJson(),
    'therapist': therapist?.toJson(),
    'invoice': invoice?.toJson(),
    'consultant_assessment': consultantAssessment?.toJson(),
    'history_taking': historyTaking?.toJson(),
  };
}

// ─────────────────────────────────────────────────────────────
// 4. ConsultantAssessmentModel
// ─────────────────────────────────────────────────────────────
class ConsultantAssessmentModel {
  final int? id;
  final String? observationFindings;
  final String? palpationResults;
  final String? romAssessment;
  final String? neuroSpecialTests;
  final String? differentialDiagnoses;
  final String? finalDiagnosis;
  final String? finalDiagnosisOther;
  final String? sessionDuration;
  final String? skinIssues;
  final String? skinIssuesOther;
  final bool? skipMmt;
  final String? rehabGoals;
  final String? nextReviewDate;
  final MmtModel? mmt;
  final List<String> specialTests;
  final List<MuscleAssessmentModel> muscleAssessments;
  final GeneralTpModel? generalTp;
  final String? createdAt;
  final String? updatedAt;

  ConsultantAssessmentModel({
    this.id,
    this.observationFindings,
    this.palpationResults,
    this.romAssessment,
    this.neuroSpecialTests,
    this.differentialDiagnoses,
    this.finalDiagnosis,
    this.finalDiagnosisOther,
    this.sessionDuration,
    this.skinIssues,
    this.skinIssuesOther,
    this.skipMmt,
    this.rehabGoals,
    this.nextReviewDate,
    this.mmt,
    this.specialTests = const [],
    this.muscleAssessments = const [],
    this.generalTp,
    this.createdAt,
    this.updatedAt,
  });

  String get displayObservationFindings => _display(observationFindings);
  String get displayPalpationResults => _display(palpationResults);
  String get displayRomAssessment => _display(romAssessment);
  String get displayNeuroSpecialTests => _display(neuroSpecialTests);
  String get displayDifferentialDiagnoses => _display(differentialDiagnoses);
  String get displayFinalDiagnosis => _display(finalDiagnosis);
  String get displayFinalDiagnosisOther => _display(finalDiagnosisOther);
  String get displaySessionDuration => _display(sessionDuration);
  String get displaySkinIssues => _display(skinIssues);
  String get displaySkinIssuesOther => _display(skinIssuesOther);
  String get displaySkipMmt => _display(skipMmt);
  String get displayRehabGoals => _display(rehabGoals);
  String get displayNextReviewDate => _display(nextReviewDate);
  String get displaySpecialTests => _display(specialTests);

  factory ConsultantAssessmentModel.fromJson(Map<String, dynamic> json) {
    // muscle_assessments comes as Map<String, dynamic> not List
    final rawMuscles = json['muscle_assessments'];
    List<MuscleAssessmentModel> muscles = [];
    if (rawMuscles is Map) {
      muscles = rawMuscles.values
          .whereType<Map>()
          .map(
            (e) => MuscleAssessmentModel.fromJson(Map<String, dynamic>.from(e)),
          )
          .toList();
    }

    return ConsultantAssessmentModel(
      id: _int(json['id']),
      observationFindings: _str(json['observation_findings']),
      palpationResults: _str(json['palpation_results']),
      romAssessment: _str(json['rom_assessment']),
      neuroSpecialTests: _str(json['neuro_special_tests']),
      differentialDiagnoses: _str(json['differential_diagnoses']),
      finalDiagnosis: _str(json['final_diagnosis']),
      finalDiagnosisOther: _str(json['final_diagnosis_other']),
      sessionDuration: _str(json['session_duration']),
      skinIssues: _str(json['skin_issues']),
      skinIssuesOther: _str(json['skin_issues_other']),
      skipMmt: _bool(json['skip_mmt']),
      rehabGoals: _str(json['rehab_goals']),
      nextReviewDate: _str(json['next_review_date']),
      mmt: json['mmt'] is Map
          ? MmtModel.fromJson(json['mmt'] as Map<String, dynamic>)
          : null,
      specialTests: _strList(json['special_tests']),
      muscleAssessments: muscles,
      generalTp: json['general_tp'] is Map
          ? GeneralTpModel.fromJson(json['general_tp'] as Map<String, dynamic>)
          : null,
      createdAt: _str(json['created_at']),
      updatedAt: _str(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'observation_findings': observationFindings,
    'palpation_results': palpationResults,
    'rom_assessment': romAssessment,
    'neuro_special_tests': neuroSpecialTests,
    'differential_diagnoses': differentialDiagnoses,
    'final_diagnosis': finalDiagnosis,
    'final_diagnosis_other': finalDiagnosisOther,
    'session_duration': sessionDuration,
    'skin_issues': skinIssues,
    'skin_issues_other': skinIssuesOther,
    'skip_mmt': skipMmt,
    'rehab_goals': rehabGoals,
    'next_review_date': nextReviewDate,
    'mmt': mmt?.toJson(),
    'special_tests': specialTests,
    'muscle_assessments': {
      for (var m in muscleAssessments) m.muscleId ?? '': m.toJson(),
    },
    'general_tp': generalTp?.toJson(),
    'created_at': createdAt,
    'updated_at': updatedAt,
  };
}

// ─────────────────────────────────────────────────────────────
// 5. MmtModel
// ─────────────────────────────────────────────────────────────
class MmtModel {
  final MmtSectionModel? upper;
  final MmtSectionModel? lower;

  MmtModel({this.upper, this.lower});

  factory MmtModel.fromJson(Map<String, dynamic> json) => MmtModel(
    upper: json['upper'] is Map
        ? MmtSectionModel.fromJson(
            Map<String, dynamic>.from(json['upper'] as Map),
          )
        : null,
    lower: json['lower'] is Map
        ? MmtSectionModel.fromJson(
            Map<String, dynamic>.from(json['lower'] as Map),
          )
        : null,
  );

  Map<String, dynamic> toJson() => {
    'upper': upper?.toJson(),
    'lower': lower?.toJson(),
  };
}

// ─────────────────────────────────────────────────────────────
// 6. MmtLR + MmtSectionModel
// ─────────────────────────────────────────────────────────────
class MmtLR {
  final String? l;
  final String? r;

  MmtLR({this.l, this.r});

  String get displayL => _display(l);
  String get displayR => _display(r);

  factory MmtLR.fromJson(Map<String, dynamic> json) =>
      MmtLR(l: _str(json['l']), r: _str(json['r']));

  Map<String, dynamic> toJson() => {'l': l, 'r': r};
}

class MmtSectionModel {
  final Map<String, MmtLR> values;

  MmtSectionModel({required this.values});

  String displayField(String key) {
    final v = values[key];
    if (v == null) return 'No data';
    return 'L: ${v.displayL} | R: ${v.displayR}';
  }

  factory MmtSectionModel.fromJson(Map<String, dynamic> json) {
    final map = <String, MmtLR>{};
    json.forEach((key, value) {
      if (value is Map) {
        map[key] = MmtLR.fromJson(Map<String, dynamic>.from(value));
      }
    });
    return MmtSectionModel(values: map);
  }

  Map<String, dynamic> toJson() =>
      values.map((k, v) => MapEntry(k, v.toJson()));
}

// ─────────────────────────────────────────────────────────────
// 7. MuscleAssessmentModel
// ─────────────────────────────────────────────────────────────
class MuscleAssessmentModel {
  final String? muscleId;
  final String? muscleName;
  final List<String> conditions;
  final List<String> treatments;
  final String? treatmentOther;
  final List<String> exercises;
  final List<String> defaultExercises;
  final Map<String, ExerciseParamModel> exerciseParams;

  MuscleAssessmentModel({
    this.muscleId,
    this.muscleName,
    this.conditions = const [],
    this.treatments = const [],
    this.treatmentOther,
    this.exercises = const [],
    this.defaultExercises = const [],
    this.exerciseParams = const {},
  });

  String get displayMuscleId => _display(muscleId);
  String get displayMuscleName => _display(muscleName);
  String get displayConditions => _display(conditions);
  String get displayTreatments => _display(treatments);
  String get displayTreatmentOther => _display(treatmentOther);
  String get displayExercises => _display(exercises);
  String get displayDefaultExercises => _display(defaultExercises);

  factory MuscleAssessmentModel.fromJson(Map<String, dynamic> json) {
    final rawParams = json['exercise_params'];
    Map<String, ExerciseParamModel> params = {};
    if (rawParams is Map) {
      rawParams.forEach((k, v) {
        if (v is Map) {
          params[k.toString()] = ExerciseParamModel.fromJson(
            Map<String, dynamic>.from(v),
          );
        }
      });
    }

    return MuscleAssessmentModel(
      muscleId: _str(json['muscle_id']),
      muscleName: _str(json['muscle_name']),
      conditions: _strList(json['conditions']),
      treatments: _strList(json['treatments']),
      treatmentOther: _str(json['treatment_other']),
      exercises: _strList(json['exercises']),
      defaultExercises: _strList(json['default_exercises']),
      exerciseParams: params,
    );
  }

  Map<String, dynamic> toJson() => {
    'muscle_id': muscleId,
    'muscle_name': muscleName,
    'conditions': conditions,
    'treatments': treatments,
    'treatment_other': treatmentOther,
    'exercises': exercises,
    'default_exercises': defaultExercises,
    'exercise_params': exerciseParams.map((k, v) => MapEntry(k, v.toJson())),
  };
}

// ─────────────────────────────────────────────────────────────
// 8. ExerciseParamModel
// ─────────────────────────────────────────────────────────────
class ExerciseParamModel {
  final String? min;
  final String? days;
  final String? freq;
  final String? reps;

  ExerciseParamModel({this.min, this.days, this.freq, this.reps});

  String get displayMin => _display(min);
  String get displayDays => _display(days);
  String get displayFreq => _display(freq);
  String get displayReps => _display(reps);

  factory ExerciseParamModel.fromJson(Map<String, dynamic> json) =>
      ExerciseParamModel(
        min: _str(json['min']),
        days: _str(json['days']),
        freq: _str(json['freq']),
        reps: _str(json['reps']),
      );

  Map<String, dynamic> toJson() => {
    'min': min,
    'days': days,
    'freq': freq,
    'reps': reps,
  };
}

// ─────────────────────────────────────────────────────────────
// 9. GeneralTpModel
// ─────────────────────────────────────────────────────────────
class GeneralTpModel {
  final List<String> medications;
  final List<String> thermoCryo;
  final List<String> electroCurrents;
  final List<String> antiInflammatory;
  final List<String> topicalAnalgesic;
  final List<String> advanceTechniques;
  final String? topicalOthers;
  final String? electroPlacement;
  final Map<String, String?> thermoData;
  final Map<String, String?> electroData;
  final Map<String, String?> antiInflamData;
  final Map<String, String?> advanceTechData;

  GeneralTpModel({
    this.medications = const [],
    this.thermoCryo = const [],
    this.electroCurrents = const [],
    this.antiInflammatory = const [],
    this.topicalAnalgesic = const [],
    this.advanceTechniques = const [],
    this.topicalOthers,
    this.electroPlacement,
    this.thermoData = const {},
    this.electroData = const {},
    this.antiInflamData = const {},
    this.advanceTechData = const {},
  });

  String get displayMedications => _display(medications);
  String get displayThermoCryo => _display(thermoCryo);
  String get displayElectroCurrents => _display(electroCurrents);
  String get displayAntiInflammatory => _display(antiInflammatory);
  String get displayTopicalAnalgesic => _display(topicalAnalgesic);
  String get displayAdvanceTechniques => _display(advanceTechniques);
  String get displayTopicalOthers => _display(topicalOthers);
  String get displayElectroPlacement => _display(electroPlacement);

  String thermoTime(String key) => _display(thermoData[key]);
  String electroTime(String key) => _display(electroData[key]);
  String antiInflamTime(String key) => _display(antiInflamData[key]);
  String advanceTechTime(String key) => _display(advanceTechData[key]);

  static Map<String, String?> _parseTimeMap(dynamic raw) {
    if (raw == null || raw is! Map) return {};
    return Map.fromEntries(
      raw.entries.map((e) {
        final time = e.value is Map
            ? _str((e.value as Map)['time'])
            : _str(e.value);
        return MapEntry(e.key.toString(), time);
      }),
    );
  }

  factory GeneralTpModel.fromJson(Map<String, dynamic> json) => GeneralTpModel(
    medications: _strList(json['medications']),
    thermoCryo: _strList(json['thermo_cryo']),
    electroCurrents: _strList(json['electro_currents']),
    antiInflammatory: _strList(json['anti_inflammatory']),
    topicalAnalgesic: _strList(json['topical_analgesic']),
    advanceTechniques: _strList(json['advance_techniques']),
    topicalOthers: _str(json['topical_others']),
    electroPlacement: _str(json['electro_placement']),
    thermoData: _parseTimeMap(json['thermo_data']),
    electroData: _parseTimeMap(json['electro_data']),
    antiInflamData: _parseTimeMap(json['anti_inflam_data']),
    advanceTechData: _parseTimeMap(json['advance_tech_data']),
  );

  Map<String, dynamic> toJson() => {
    'medications': medications,
    'thermo_cryo': thermoCryo,
    'electro_currents': electroCurrents,
    'anti_inflammatory': antiInflammatory,
    'topical_analgesic': topicalAnalgesic,
    'advance_techniques': advanceTechniques,
    'topical_others': topicalOthers,
    'electro_placement': electroPlacement,
    'thermo_data': thermoData,
    'electro_data': electroData,
    'anti_inflam_data': antiInflamData,
    'advance_tech_data': advanceTechData,
  };
}

// ─────────────────────────────────────────────────────────────
// 10. HistoryTakingModel
// ─────────────────────────────────────────────────────────────
class HistoryTakingModel {
  final int? id;
  final String? occupation;
  final List<String> chiefComplaint;
  final String? complaintOnset;
  final String? onset;
  final List<String> possibleCause;
  final List<String> movementPain;
  final List<String> painLocation;
  final List<String> painType;
  final List<String> painTime;
  final int? painSeverity;
  final String? symptomPattern;
  final List<String> aggravatingFactors;
  final String? aggravatingSpecify;
  final List<String> relievingFactors;
  final String? relievingSpecify;
  final List<String> associatedSymptoms;
  final String? associatedSpecify;
  final List<String> adlLimitations;
  final List<String> previousInvestigations;
  final List<String> medicalHistory;
  final List<String> medicalHistoryDetails;
  final List<String> previousTreatments;
  final Map<String, String?> previousTreatmentResponses;
  final String? surgicalHistoryDetail;
  final List<String> redFlags;
  final String? painRadiatingStatus;
  final String? painRadiationSide;
  final String? sessionDuration;
  final bool? consentGiven;
  final String? createdAt;
  final String? updatedAt;
  // Male specific
  final String? maleUrinationPain;
  final String? maleUrineLeakage;
  final String? maleNocturia;
  final String? maleGenitalNumbness;
  final String? maleBladderSexualWorsening;

  HistoryTakingModel({
    this.id,
    this.occupation,
    this.chiefComplaint = const [],
    this.complaintOnset,
    this.onset,
    this.possibleCause = const [],
    this.movementPain = const [],
    this.painLocation = const [],
    this.painType = const [],
    this.painTime = const [],
    this.painSeverity,
    this.symptomPattern,
    this.aggravatingFactors = const [],
    this.aggravatingSpecify,
    this.relievingFactors = const [],
    this.relievingSpecify,
    this.associatedSymptoms = const [],
    this.associatedSpecify,
    this.adlLimitations = const [],
    this.previousInvestigations = const [],
    this.medicalHistory = const [],
    this.medicalHistoryDetails = const [],
    this.previousTreatments = const [],
    this.previousTreatmentResponses = const {},
    this.surgicalHistoryDetail,
    this.redFlags = const [],
    this.painRadiatingStatus,
    this.painRadiationSide,
    this.sessionDuration,
    this.consentGiven,
    this.createdAt,
    this.updatedAt,
    this.maleUrinationPain,
    this.maleUrineLeakage,
    this.maleNocturia,
    this.maleGenitalNumbness,
    this.maleBladderSexualWorsening,
  });

  String get displayOccupation => _display(occupation);
  String get displayChiefComplaint => _display(chiefComplaint);
  String get displayComplaintOnset => _display(complaintOnset);
  String get displayOnset => _display(onset);
  String get displayPossibleCause => _display(possibleCause);
  String get displayMovementPain => _display(movementPain);
  String get displayPainLocation => _display(painLocation);
  String get displayPainType => _display(painType);
  String get displayPainTime => _display(painTime);
  String get displayPainSeverity => _display(painSeverity);
  String get displaySymptomPattern => _display(symptomPattern);
  String get displayAggravatingFactors => _display(aggravatingFactors);
  String get displayRelievingFactors => _display(relievingFactors);
  String get displayAssociatedSymptoms => _display(associatedSymptoms);
  String get displayAdlLimitations => _display(adlLimitations);
  String get displayPreviousInvestigations => _display(previousInvestigations);
  String get displayMedicalHistory => _display(medicalHistory);
  String get displayPreviousTreatments => _display(previousTreatments);
  String get displaySurgicalHistoryDetail => _display(surgicalHistoryDetail);
  String get displayRedFlags => _display(redFlags);
  String get displayPainRadiatingStatus => _display(painRadiatingStatus);
  String get displayPainRadiationSide => _display(painRadiationSide);
  String get displaySessionDuration => _display(sessionDuration);
  String get displayConsentGiven => _display(consentGiven);
  String get displayMaleUrinationPain => _display(maleUrinationPain);
  String get displayMaleUrineLeakage => _display(maleUrineLeakage);
  String get displayMaleNocturia => _display(maleNocturia);
  String get displayMaleGenitalNumbness => _display(maleGenitalNumbness);
  String get displayMaleBladderSexualWorsening =>
      _display(maleBladderSexualWorsening);

  factory HistoryTakingModel.fromJson(Map<String, dynamic> json) {
    Map<String, String?> parsedResponses = {};
    final raw = json['previous_treatment_responses'];
    if (raw is Map) {
      raw.forEach((k, v) => parsedResponses[k.toString()] = _str(v));
    }

    return HistoryTakingModel(
      id: _int(json['id']),
      occupation: _str(json['occupation']),
      chiefComplaint: _strList(json['chief_complaint']),
      complaintOnset: _str(json['complaint_onset']),
      onset: _str(json['onset']),
      possibleCause: _strList(json['possible_cause']),
      movementPain: _strList(json['movement_pain']),
      painLocation: _strList(json['pain_location']),
      painType: _strList(json['pain_type']),
      painTime: _strList(json['pain_time']),
      painSeverity: _int(json['pain_severity']),
      symptomPattern: _str(json['symptom_pattern']),
      aggravatingFactors: _strList(json['aggravating_factors']),
      aggravatingSpecify: _str(json['aggravating_specify']),
      relievingFactors: _strList(json['relieving_factors']),
      relievingSpecify: _str(json['relieving_specify']),
      associatedSymptoms: _strList(json['associated_symptoms']),
      associatedSpecify: _str(json['associated_specify']),
      adlLimitations: _strList(json['adl_limitations']),
      previousInvestigations: _strList(json['previous_investigations']),
      medicalHistory: _strList(json['medical_history']),
      medicalHistoryDetails: _strList(json['medical_history_details']),
      previousTreatments: _strList(json['previous_treatments']),
      previousTreatmentResponses: parsedResponses,
      surgicalHistoryDetail: _str(json['surgical_history_detail']),
      redFlags: _strList(json['red_flags']),
      painRadiatingStatus: _str(json['pain_radiating_status']),
      painRadiationSide: _str(json['pain_radiation_side']),
      sessionDuration: _str(json['session_duration']),
      consentGiven: _bool(json['consent_given']),
      createdAt: _str(json['created_at']),
      updatedAt: _str(json['updated_at']),
      maleUrinationPain: _str(json['male_urination_pain']),
      maleUrineLeakage: _str(json['male_urine_leakage']),
      maleNocturia: _str(json['male_nocturia']),
      maleGenitalNumbness: _str(json['male_genital_numbness']),
      maleBladderSexualWorsening: _str(json['male_bladder_sexual_worsening']),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'occupation': occupation,
    'chief_complaint': chiefComplaint,
    'complaint_onset': complaintOnset,
    'onset': onset,
    'possible_cause': possibleCause,
    'movement_pain': movementPain,
    'pain_location': painLocation,
    'pain_type': painType,
    'pain_time': painTime,
    'pain_severity': painSeverity,
    'symptom_pattern': symptomPattern,
    'aggravating_factors': aggravatingFactors,
    'aggravating_specify': aggravatingSpecify,
    'relieving_factors': relievingFactors,
    'relieving_specify': relievingSpecify,
    'associated_symptoms': associatedSymptoms,
    'associated_specify': associatedSpecify,
    'adl_limitations': adlLimitations,
    'previous_investigations': previousInvestigations,
    'medical_history': medicalHistory,
    'medical_history_details': medicalHistoryDetails,
    'previous_treatments': previousTreatments,
    'previous_treatment_responses': previousTreatmentResponses,
    'surgical_history_detail': surgicalHistoryDetail,
    'red_flags': redFlags,
    'pain_radiating_status': painRadiatingStatus,
    'pain_radiation_side': painRadiationSide,
    'session_duration': sessionDuration,
    'consent_given': consentGiven,
    'created_at': createdAt,
    'updated_at': updatedAt,
    'male_urination_pain': maleUrinationPain,
    'male_urine_leakage': maleUrineLeakage,
    'male_nocturia': maleNocturia,
    'male_genital_numbness': maleGenitalNumbness,
    'male_bladder_sexual_worsening': maleBladderSexualWorsening,
  };
}

// ─────────────────────────────────────────────────────────────
// 11. PackageModel
// ─────────────────────────────────────────────────────────────
class PackageModel {
  final int? id;
  final String? name;
  final int? sessions;
  final double? price;
  final PackagePivotModel? pivot;

  PackageModel({this.id, this.name, this.sessions, this.price, this.pivot});

  String get displayId => _display(id);
  String get displayName => _display(name);
  String get displaySessions => _display(sessions);
  String get displayPrice => _display(price);

  factory PackageModel.fromJson(Map<String, dynamic> json) => PackageModel(
    id: _int(json['id']),
    name: _str(json['name']),
    sessions: _int(json['sessions']),
    price: _dbl(json['price']),
    pivot: json['pivot'] is Map
        ? PackagePivotModel.fromJson(
            Map<String, dynamic>.from(json['pivot'] as Map),
          )
        : null,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'sessions': sessions,
    'price': price,
    'pivot': pivot?.toJson(),
  };
}

// ─────────────────────────────────────────────────────────────
// 12. PackagePivotModel
// ─────────────────────────────────────────────────────────────
class PackagePivotModel {
  final String? status;
  final int? sessionsUsed;
  final int? sessionsTotal;
  final double? price;
  final String? startsAt;
  final String? createdAt;

  PackagePivotModel({
    this.status,
    this.sessionsUsed,
    this.sessionsTotal,
    this.price,
    this.startsAt,
    this.createdAt,
  });

  String get displayStatus => _display(status);
  String get displaySessionsUsed => _display(sessionsUsed);
  String get displaySessionsTotal => _display(sessionsTotal);
  String get displayPrice => _display(price);
  String get displayStartsAt => _display(startsAt);

  factory PackagePivotModel.fromJson(Map<String, dynamic> json) =>
      PackagePivotModel(
        status: _str(json['status']),
        sessionsUsed: _int(json['sessions_used']),
        sessionsTotal: _int(json['sessions_total']),
        price: _dbl(json['price']),
        startsAt: _str(json['starts_at']),
        createdAt: _str(json['created_at']),
      );

  Map<String, dynamic> toJson() => {
    'status': status,
    'sessions_used': sessionsUsed,
    'sessions_total': sessionsTotal,
    'price': price,
    'starts_at': startsAt,
    'created_at': createdAt,
  };
}

// ─────────────────────────────────────────────────────────────
// 13. InvoiceModel
// ─────────────────────────────────────────────────────────────
class InvoiceModel {
  final int? id;
  final String? type;
  final double? amount;
  final String? status;
  final double? discountAmount;
  final double? insuranceDiscountAmount;
  final String? createdAt;
  final String? updatedAt;
  final List<PaymentModel> payments;

  InvoiceModel({
    this.id,
    this.type,
    this.amount,
    this.status,
    this.discountAmount,
    this.insuranceDiscountAmount,
    this.createdAt,
    this.updatedAt,
    this.payments = const [],
  });

  String get displayId => _display(id);
  String get displayType => _display(type);
  String get displayAmount => _display(amount);
  String get displayStatus => _display(status);
  String get displayDiscountAmount => _display(discountAmount);
  String get displayCreatedAt => _display(createdAt);

  factory InvoiceModel.fromJson(Map<String, dynamic> json) => InvoiceModel(
    id: _int(json['id']),
    type: _str(json['type']),
    amount: _dbl(json['amount']),
    status: _str(json['computed_status']) ?? _str(json['status']),
    discountAmount: _dbl(json['discount_amount']),
    insuranceDiscountAmount: _dbl(json['insurance_discount_amount']),
    createdAt: _str(json['created_at']),
    updatedAt: _str(json['updated_at']),
    payments: (json['payments'] as List<dynamic>? ?? [])
        .map((e) => PaymentModel.fromJson(e as Map<String, dynamic>))
        .toList(),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'type': type,
    'amount': amount,
    'status': status,
    'discount_amount': discountAmount,
    'insurance_discount_amount': insuranceDiscountAmount,
    'created_at': createdAt,
    'updated_at': updatedAt,
    'payments': payments.map((e) => e.toJson()).toList(),
  };
}

// ─────────────────────────────────────────────────────────────
// 14. PaymentModel
// ─────────────────────────────────────────────────────────────
class PaymentModel {
  final int? id;
  final double? amount;
  final String? method;
  final String? type;
  final String? createdAt;

  PaymentModel({this.id, this.amount, this.method, this.type, this.createdAt});

  String get displayId => _display(id);
  String get displayAmount => _display(amount);
  String get displayMethod => _display(method);
  String get displayType => _display(type);
  String get displayCreatedAt => _display(createdAt);

  factory PaymentModel.fromJson(Map<String, dynamic> json) => PaymentModel(
    id: _int(json['id']),
    amount: _dbl(json['amount']),
    method: _str(json['method']),
    type: _str(json['type']),
    createdAt: _str(json['created_at']),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'amount': amount,
    'method': method,
    'type': type,
    'created_at': createdAt,
  };
}

// ─────────────────────────────────────────────────────────────
// 15. PatientStatsModel
// ─────────────────────────────────────────────────────────────
class PatientStatsModel {
  final int? totalVisits;
  final int? consultationVisits;
  final int? therapyVisits;
  final int? activePackages;
  final int? completedPackages;
  final double? totalSpend;
  final double? totalAmount;
  final double? totalSpent;

  PatientStatsModel({
    this.totalVisits,
    this.consultationVisits,
    this.therapyVisits,
    this.activePackages,
    this.completedPackages,
    this.totalSpend,
    this.totalAmount,
    this.totalSpent,
  });

  String get displayTotalVisits => _display(totalVisits);
  String get displayConsultationVisits => _display(consultationVisits);
  String get displayTherapyVisits => _display(therapyVisits);
  String get displayActivePackages => _display(activePackages);
  String get displayCompletedPackages => _display(completedPackages);
  String get displayTotalSpent =>
      _display(totalSpent ?? totalAmount ?? totalSpend);

  factory PatientStatsModel.fromJson(Map<String, dynamic> json) =>
      PatientStatsModel(
        totalVisits: _int(json['total_visits']),
        consultationVisits: _int(json['consultation_visits']),
        therapyVisits: _int(json['therapy_visits']),
        activePackages: _int(json['active_packages']),
        completedPackages: _int(json['completed_packages']),
        totalSpend: _dbl(json['total_spend']),
        totalAmount: _dbl(json['total_amount']),
        totalSpent: _dbl(json['total_spent']),
      );

  Map<String, dynamic> toJson() => {
    'total_visits': totalVisits,
    'consultation_visits': consultationVisits,
    'therapy_visits': therapyVisits,
    'active_packages': activePackages,
    'completed_packages': completedPackages,
    'total_spend': totalSpend,
    'total_amount': totalAmount,
    'total_spent': totalSpent,
  };
}

// ─────────────────────────────────────────────────────────────
// 16. TherapySessionModel
// ─────────────────────────────────────────────────────────────
class TherapySessionModel {
  final int? id;
  final int? patientId;
  final int? visitId;
  final String? startTime;
  final String? endTime;
  final int? durationSeconds;
  final String? sessionDuration;
  final String? notes;
  final String? nextSessionDate;
  final Map<String, dynamic> modalitiesData;
  final UserModel? therapist;
  final String? createdAt;
  final String? updatedAt;

  TherapySessionModel({
    this.id,
    this.patientId,
    this.visitId,
    this.startTime,
    this.endTime,
    this.durationSeconds,
    this.sessionDuration,
    this.notes,
    this.nextSessionDate,
    this.modalitiesData = const {},
    this.therapist,
    this.createdAt,
    this.updatedAt,
  });

  String get displayId => _display(id);
  String get displayStartTime => _display(startTime);
  String get displayEndTime => _display(endTime);
  String get displayDurationSeconds => _display(durationSeconds);
  String get displaySessionDuration => _display(sessionDuration);
  String get displayNotes => _display(notes);
  String get displayNextSessionDate => _display(nextSessionDate);

  factory TherapySessionModel.fromJson(Map<String, dynamic> json) =>
      TherapySessionModel(
        id: _int(json['id']),
        patientId: _int(json['patient_id']),
        visitId: _int(json['visit_id']),
        startTime: _str(json['start_time']),
        endTime: _str(json['end_time']),
        durationSeconds: _int(json['duration_seconds']),
        sessionDuration: _str(json['session_duration']),
        notes: _str(json['notes']),
        nextSessionDate: _str(json['next_session_date']),
        modalitiesData: json['modalities_data'] is Map
            ? Map<String, dynamic>.from(json['modalities_data'] as Map)
            : {},
        therapist: json['therapist'] is Map
            ? UserModel.fromJson(
                Map<String, dynamic>.from(json['therapist'] as Map),
              )
            : null,
        createdAt: _str(json['created_at']),
        updatedAt: _str(json['updated_at']),
      );

  Map<String, dynamic> toJson() => {
    'id': id,
    'patient_id': patientId,
    'visit_id': visitId,
    'start_time': startTime,
    'end_time': endTime,
    'duration_seconds': durationSeconds,
    'session_duration': sessionDuration,
    'notes': notes,
    'next_session_date': nextSessionDate,
    'modalities_data': modalitiesData,
    'therapist': therapist?.toJson(),
    'created_at': createdAt,
    'updated_at': updatedAt,
  };
}
