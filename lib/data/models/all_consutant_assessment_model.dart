// ─────────────────────────────────────────────────────────────
// all_consultant_assessment_model.dart
// Matches allConsultant assessments API response
// ─────────────────────────────────────────────────────────────

class AllConsultantAssessmentModel {
  final int? assessmentId;
  final int? visitId;
  final String? visitDate;
  final String? consultant;

  final ClinicalFindings? clinicalFindings;
  final SessionSettings? sessionSettings;
  final AdviceModel? advice;

  final Map<String, List<SpecialTest>> specialTests;
  final Map<String, List<MmtEntry>> mmt;
  final List<MuscleAssessment> muscleAssessments;
  final GeneralTherapeuticPrescription? prescription;
  final List<String> selectedPackages;

  AllConsultantAssessmentModel({
    this.assessmentId,
    this.visitId,
    this.visitDate,
    this.consultant,
    this.clinicalFindings,
    this.sessionSettings,
    this.advice,
    required this.specialTests,
    required this.mmt,
    required this.muscleAssessments,
    this.prescription,
    required this.selectedPackages,
  });

  factory AllConsultantAssessmentModel.fromJson(Map<String, dynamic> json) {
    return AllConsultantAssessmentModel(
      assessmentId: json['Assessment ID'],
      visitId: json['Visit ID'],
      visitDate: json['Visit Date'],
      consultant: json['Consultant'],
      clinicalFindings: json['Clinical Findings & Diagnosis'] != null
          ? ClinicalFindings.fromJson(
              Map<String, dynamic>.from(json['Clinical Findings & Diagnosis']),
            )
          : null,
      sessionSettings: json['Session Settings'] != null
          ? SessionSettings.fromJson(
              Map<String, dynamic>.from(json['Session Settings']),
            )
          : null,
      advice: json['Advice'] != null
          ? AdviceModel.fromJson(Map<String, dynamic>.from(json['Advice']))
          : null,
      specialTests: _parseSpecialTests(json['Special Tests Examination']),
      mmt: _parseMmt(json['Manual Muscle Testing (MMT)']),
      muscleAssessments: (json['Muscle Assessments / Exercises'] as List? ?? [])
          .map(
            (e) => MuscleAssessment.fromJson(Map<String, dynamic>.from(e)),
          )
          .toList(),
      prescription: json['General Therapeutic Prescription'] != null
          ? GeneralTherapeuticPrescription.fromJson(
              Map<String, dynamic>.from(
                json['General Therapeutic Prescription'],
              ),
            )
          : null,
      selectedPackages: List<String>.from(json['Selected Packages'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Assessment ID': assessmentId,
      'Visit ID': visitId,
      'Visit Date': visitDate,
      'Consultant': consultant,
      'Clinical Findings & Diagnosis': clinicalFindings?.toJson(),
      'Session Settings': sessionSettings?.toJson(),
      'Advice': advice?.toJson(),
      'Special Tests Examination': specialTests.map(
        (key, value) => MapEntry(key, value.map((e) => e.toJson()).toList()),
      ),
      'Manual Muscle Testing (MMT)': mmt.map(
        (key, value) => MapEntry(key, value.map((e) => e.toJson()).toList()),
      ),
      'Muscle Assessments / Exercises':
          muscleAssessments.map((e) => e.toJson()).toList(),
      'General Therapeutic Prescription': prescription?.toJson(),
      'Selected Packages': selectedPackages,
    };
  }
}

Map<String, List<SpecialTest>> _parseSpecialTests(dynamic value) {
  if (value == null) return {};
  if (value is! Map) return {};

  return Map<String, dynamic>.from(value).map((key, regionValue) {
    final list = regionValue is List ? regionValue : <dynamic>[];
    return MapEntry(
      key,
      list
          .whereType<Map>()
          .map((e) => SpecialTest.fromJson(Map<String, dynamic>.from(e)))
          .toList(),
    );
  });
}

/// API sends MMT as a Map of limb regions.
/// Legacy responses may still send [] — treat that as empty.
Map<String, List<MmtEntry>> _parseMmt(dynamic value) {
  if (value == null) return {};
  if (value is List) return {};
  if (value is! Map) return {};

  return Map<String, dynamic>.from(value).map((key, regionValue) {
    final list = regionValue is List ? regionValue : <dynamic>[];
    return MapEntry(
      key,
      list
          .whereType<Map>()
          .map((e) => MmtEntry.fromJson(Map<String, dynamic>.from(e)))
          .toList(),
    );
  });
}

// ─────────────────────────────────────────────────────────────
// 🔹 Special Test Model
// ─────────────────────────────────────────────────────────────
class SpecialTest {
  final String? test;
  final String? result;
  final String? findings;

  SpecialTest({this.test, this.result, this.findings});

  factory SpecialTest.fromJson(Map<String, dynamic> json) {
    return SpecialTest(
      test: json['Test']?.toString(),
      result: json['Result']?.toString(),
      findings: json['Findings']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'Test': test, 'Result': result, 'Findings': findings};
  }
}

// ─────────────────────────────────────────────────────────────
// 🔹 Manual Muscle Testing Entry
// ─────────────────────────────────────────────────────────────
class MmtEntry {
  final String? muscleMovement;
  final String? right;
  final String? left;

  MmtEntry({this.muscleMovement, this.right, this.left});

  factory MmtEntry.fromJson(Map<String, dynamic> json) {
    return MmtEntry(
      muscleMovement: json['Muscle / Movement']?.toString(),
      right: json['Right']?.toString(),
      left: json['Left']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Muscle / Movement': muscleMovement,
      'Right': right,
      'Left': left,
    };
  }
}

// ─────────────────────────────────────────────────────────────
// 🔹 Clinical Findings
// ─────────────────────────────────────────────────────────────
class ClinicalFindings {
  final List<String> diagnosis;
  final String? note;

  ClinicalFindings({required this.diagnosis, this.note});

  factory ClinicalFindings.fromJson(Map<String, dynamic> json) {
    return ClinicalFindings(
      diagnosis: List<String>.from(json['Diagnosis'] ?? []),
      note: json['Note']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'Diagnosis': diagnosis, 'Note': note};
  }
}

// ─────────────────────────────────────────────────────────────
// 🔹 Session Settings
// ─────────────────────────────────────────────────────────────
class SessionSettings {
  final String? duration;

  SessionSettings({this.duration});

  factory SessionSettings.fromJson(Map<String, dynamic> json) {
    return SessionSettings(
      duration: json['Prescribed Session Duration']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'Prescribed Session Duration': duration};
  }
}

// ─────────────────────────────────────────────────────────────
// 🔹 Advice
// ─────────────────────────────────────────────────────────────
class AdviceModel {
  final List<String> investigationsDone;
  final String? otherAdvice;

  AdviceModel({required this.investigationsDone, this.otherAdvice});

  factory AdviceModel.fromJson(Map<String, dynamic> json) {
    return AdviceModel(
      investigationsDone: List<String>.from(json['Investigations Done'] ?? []),
      otherAdvice: json['Other Investigations / Advice']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Investigations Done': investigationsDone,
      'Other Investigations / Advice': otherAdvice,
    };
  }
}

// ─────────────────────────────────────────────────────────────
// 🔹 Muscle Assessment
// ─────────────────────────────────────────────────────────────
class MuscleAssessment {
  final String? muscle;
  final List<String> conditionStatus;
  final List<String> manualTreatment;
  final String? otherTreatment;
  final List<Exercise> prescribedExercises;
  final List<String> defaultExercises;

  MuscleAssessment({
    this.muscle,
    required this.conditionStatus,
    required this.manualTreatment,
    this.otherTreatment,
    required this.prescribedExercises,
    required this.defaultExercises,
  });

  factory MuscleAssessment.fromJson(Map<String, dynamic> json) {
    return MuscleAssessment(
      muscle: json['Muscle']?.toString(),
      conditionStatus: List<String>.from(json['Condition / Status'] ?? []),
      manualTreatment: List<String>.from(json['Manual Treatment'] ?? []),
      otherTreatment: json['Other Treatment']?.toString(),
      prescribedExercises: (json['Prescribed Exercises'] as List? ?? [])
          .whereType<Map>()
          .map((e) => Exercise.fromJson(Map<String, dynamic>.from(e)))
          .toList(),
      defaultExercises: List<String>.from(json['By Default Exercises'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Muscle': muscle,
      'Condition / Status': conditionStatus,
      'Manual Treatment': manualTreatment,
      'Other Treatment': otherTreatment,
      'Prescribed Exercises':
          prescribedExercises.map((e) => e.toJson()).toList(),
      'By Default Exercises': defaultExercises,
    };
  }
}

// ─────────────────────────────────────────────────────────────
// 🔹 Exercise
// ─────────────────────────────────────────────────────────────
class Exercise {
  final String? name;
  final String? dosage;

  Exercise({this.name, this.dosage});

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      name: json['Name']?.toString(),
      dosage: json['Dosage']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'Name': name, 'Dosage': dosage};
  }
}

// ─────────────────────────────────────────────────────────────
// 🔹 General Therapeutic Prescription
// ─────────────────────────────────────────────────────────────
class GeneralTherapeuticPrescription {
  final String? electrotherapy;
  final String? thermo;
  final String? antiInflammatory;
  final String? advanced;
  final String? medications;
  final String? topicals;

  GeneralTherapeuticPrescription({
    this.electrotherapy,
    this.thermo,
    this.antiInflammatory,
    this.advanced,
    this.medications,
    this.topicals,
  });

  factory GeneralTherapeuticPrescription.fromJson(Map<String, dynamic> json) {
    return GeneralTherapeuticPrescription(
      electrotherapy: json['Electrotherapy']?.toString(),
      thermo: json['Thermo / Cryotherapy']?.toString(),
      antiInflammatory: json['Anti-Inflammatory Modalities']?.toString(),
      advanced: json['Advanced Techniques']?.toString(),
      medications: json['Medications']?.toString(),
      topicals: json['Topicals']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Electrotherapy': electrotherapy,
      'Thermo / Cryotherapy': thermo,
      'Anti-Inflammatory Modalities': antiInflammatory,
      'Advanced Techniques': advanced,
      'Medications': medications,
      'Topicals': topicals,
    };
  }
}
