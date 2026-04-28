// ============================================================
// SESSION MODEL - Single File | All Separate Classes | Full Null Safe
// ============================================================

// ─────────────────────────────────────────────────────────────────────────────
// Helper — safely parse any dynamic value to List<String>
// ─────────────────────────────────────────────────────────────────────────────
List<String> _parseStringList(dynamic value) {
  if (value == null) return [];
  if (value is List) return value.map((e) => e?.toString() ?? '').toList();
  return [];
}

String _display(dynamic value) {
  if (value == null) return 'No data';
  if (value is String && value.trim().isEmpty) return 'No data';
  if (value is List && value.isEmpty) return 'No data';
  if (value is List) return value.join(', ');
  return value.toString();
}

// ─────────────────────────────────────────────────────────────────────────────
// Main SessionModel
// ─────────────────────────────────────────────────────────────────────────────
class ConsultantAssessmentModel {
  final ClinicalFindingsModel? clinicalFindings;
  final SessionSettingsModel? sessionSettings;
  final AdviceModel? advice;
  final List<String> specialTestsExamination;
  final List<String> manualMuscleTesting;
  final List<MuscleAssessmentModel> muscleAssessments;
  final GeneralTherapeuticPrescriptionModel? generalTherapeuticPrescription;
  final List<String> selectedPackages;

  ConsultantAssessmentModel({
    this.clinicalFindings,
    this.sessionSettings,
    this.advice,
    this.specialTestsExamination = const [],
    this.manualMuscleTesting = const [],
    this.muscleAssessments = const [],
    this.generalTherapeuticPrescription,
    this.selectedPackages = const [],
  });

  String get displaySpecialTests => _display(specialTestsExamination);
  String get displayManualMuscleTesting => _display(manualMuscleTesting);
  String get displaySelectedPackages => _display(selectedPackages);

  factory ConsultantAssessmentModel.fromJson(Map<String, dynamic> json) {
    return ConsultantAssessmentModel(
      clinicalFindings: json['Clinical Findings & Diagnosis'] != null
          ? ClinicalFindingsModel.fromJson(
              json['Clinical Findings & Diagnosis'] as Map<String, dynamic>,
            )
          : null,
      sessionSettings: json['Session Settings'] != null
          ? SessionSettingsModel.fromJson(
              json['Session Settings'] as Map<String, dynamic>,
            )
          : null,
      advice: json['Advice'] != null
          ? AdviceModel.fromJson(json['Advice'] as Map<String, dynamic>)
          : null,
      specialTestsExamination: _parseStringList(
        json['Special Tests Examination'],
      ),
      manualMuscleTesting: _parseStringList(
        json['Manual Muscle Testing (MMT)'],
      ),
      muscleAssessments:
          (json['Muscle Assessments / Exercises'] as List<dynamic>? ?? [])
              .map(
                (e) =>
                    MuscleAssessmentModel.fromJson(e as Map<String, dynamic>),
              )
              .toList(),
      generalTherapeuticPrescription:
          json['General Therapeutic Prescription'] != null
          ? GeneralTherapeuticPrescriptionModel.fromJson(
              json['General Therapeutic Prescription'] as Map<String, dynamic>,
            )
          : null,
      selectedPackages: _parseStringList(json['Selected Packages']),
    );
  }

  Map<String, dynamic> toJson() => {
    'Clinical Findings & Diagnosis': clinicalFindings?.toJson(),
    'Session Settings': sessionSettings?.toJson(),
    'Advice': advice?.toJson(),
    'Special Tests Examination': specialTestsExamination,
    'Manual Muscle Testing (MMT)': manualMuscleTesting,
    'Muscle Assessments / Exercises': muscleAssessments
        .map((e) => e.toJson())
        .toList(),
    'General Therapeutic Prescription': generalTherapeuticPrescription
        ?.toJson(),
    'Selected Packages': selectedPackages,
  };
}

// ─────────────────────────────────────────────────────────────────────────────
// 1. Clinical Findings & Diagnosis
// ─────────────────────────────────────────────────────────────────────────────
class ClinicalFindingsModel {
  final List<String> diagnosis;
  final String? note;

  ClinicalFindingsModel({this.diagnosis = const [], this.note});

  String get displayDiagnosis => _display(diagnosis);
  String get displayNote => _display(note);

  factory ClinicalFindingsModel.fromJson(Map<String, dynamic> json) {
    return ClinicalFindingsModel(
      diagnosis: _parseStringList(json['Diagnosis']),
      note: json['Note'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {'Diagnosis': diagnosis, 'Note': note};
}

// ─────────────────────────────────────────────────────────────────────────────
// 2. Session Settings
// ─────────────────────────────────────────────────────────────────────────────
class SessionSettingsModel {
  final String? prescribedSessionDuration;

  SessionSettingsModel({this.prescribedSessionDuration});

  String get displayPrescribedSessionDuration =>
      _display(prescribedSessionDuration);

  factory SessionSettingsModel.fromJson(Map<String, dynamic> json) {
    return SessionSettingsModel(
      prescribedSessionDuration: json['Prescribed Session Duration'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'Prescribed Session Duration': prescribedSessionDuration,
  };
}

// ─────────────────────────────────────────────────────────────────────────────
// 3. Advice
// ─────────────────────────────────────────────────────────────────────────────
class AdviceModel {
  final List<String> investigationsDone;
  final String? otherInvestigationsAdvice;

  AdviceModel({
    this.investigationsDone = const [],
    this.otherInvestigationsAdvice,
  });

  String get displayInvestigationsDone => _display(investigationsDone);
  String get displayOtherInvestigationsAdvice =>
      _display(otherInvestigationsAdvice);

  factory AdviceModel.fromJson(Map<String, dynamic> json) {
    return AdviceModel(
      investigationsDone: _parseStringList(json['Investigations Done']),
      otherInvestigationsAdvice:
          json['Other Investigations / Advice'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'Investigations Done': investigationsDone,
    'Other Investigations / Advice': otherInvestigationsAdvice,
  };
}

// ─────────────────────────────────────────────────────────────────────────────
// 4. Muscle Assessment / Exercises
// ─────────────────────────────────────────────────────────────────────────────
class MuscleAssessmentModel {
  final String? muscle;
  final List<String> conditionStatus;
  final List<String> manualTreatment;
  final String? otherTreatment;
  final List<PrescribedExerciseModel> prescribedExercises;
  final List<String> byDefaultExercises;

  MuscleAssessmentModel({
    this.muscle,
    this.conditionStatus = const [],
    this.manualTreatment = const [],
    this.otherTreatment,
    this.prescribedExercises = const [],
    this.byDefaultExercises = const [],
  });

  String get displayMuscle => _display(muscle);
  String get displayConditionStatus => _display(conditionStatus);
  String get displayManualTreatment => _display(manualTreatment);
  String get displayOtherTreatment => _display(otherTreatment);
  String get displayByDefaultExercises => _display(byDefaultExercises);

  factory MuscleAssessmentModel.fromJson(Map<String, dynamic> json) {
    return MuscleAssessmentModel(
      muscle: json['Muscle'] as String?,
      conditionStatus: _parseStringList(json['Condition / Status']),
      manualTreatment: _parseStringList(json['Manual Treatment']),
      otherTreatment: json['Other Treatment'] as String?,
      prescribedExercises:
          (json['Prescribed Exercises'] as List<dynamic>? ?? [])
              .map(
                (e) =>
                    PrescribedExerciseModel.fromJson(e as Map<String, dynamic>),
              )
              .toList(),
      byDefaultExercises: _parseStringList(json['By Default Exercises']),
    );
  }

  Map<String, dynamic> toJson() => {
    'Muscle': muscle,
    'Condition / Status': conditionStatus,
    'Manual Treatment': manualTreatment,
    'Other Treatment': otherTreatment,
    'Prescribed Exercises': prescribedExercises.map((e) => e.toJson()).toList(),
    'By Default Exercises': byDefaultExercises,
  };
}

// ─────────────────────────────────────────────────────────────────────────────
// 5. Prescribed Exercise
// ─────────────────────────────────────────────────────────────────────────────
class PrescribedExerciseModel {
  final String? name;
  final String? dosage;

  PrescribedExerciseModel({this.name, this.dosage});

  String get displayName => _display(name);
  String get displayDosage => _display(dosage);

  factory PrescribedExerciseModel.fromJson(Map<String, dynamic> json) {
    return PrescribedExerciseModel(
      name: json['Name'] as String?,
      dosage: json['Dosage'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {'Name': name, 'Dosage': dosage};
}

// ─────────────────────────────────────────────────────────────────────────────
// 6. General Therapeutic Prescription
// ─────────────────────────────────────────────────────────────────────────────
class GeneralTherapeuticPrescriptionModel {
  final String? electrotherapy;
  final String? thermoCryotherapy;
  final String? antiInflammatoryModalities;
  final String? advancedTechniques;
  final String? medications;
  final String? topicals;

  GeneralTherapeuticPrescriptionModel({
    this.electrotherapy,
    this.thermoCryotherapy,
    this.antiInflammatoryModalities,
    this.advancedTechniques,
    this.medications,
    this.topicals,
  });

  String get displayElectrotherapy => _display(electrotherapy);
  String get displayThermoCryotherapy => _display(thermoCryotherapy);
  String get displayAntiInflammatoryModalities =>
      _display(antiInflammatoryModalities);
  String get displayAdvancedTechniques => _display(advancedTechniques);
  String get displayMedications => _display(medications);
  String get displayTopicals => _display(topicals);

  factory GeneralTherapeuticPrescriptionModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return GeneralTherapeuticPrescriptionModel(
      electrotherapy: json['Electrotherapy'] as String?,
      thermoCryotherapy: json['Thermo / Cryotherapy'] as String?,
      antiInflammatoryModalities:
          json['Anti-Inflammatory Modalities'] as String?,
      advancedTechniques: json['Advanced Techniques'] as String?,
      medications: json['Medications'] as String?,
      topicals: json['Topicals'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'Electrotherapy': electrotherapy,
    'Thermo / Cryotherapy': thermoCryotherapy,
    'Anti-Inflammatory Modalities': antiInflammatoryModalities,
    'Advanced Techniques': advancedTechniques,
    'Medications': medications,
    'Topicals': topicals,
  };
}
