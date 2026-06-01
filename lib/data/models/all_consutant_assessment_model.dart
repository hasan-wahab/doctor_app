// ─────────────────────────────────────────────────────────────
// all_consultant_assessment_model.dart (FIXED)
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
  // 🔥 FIX: dynamic because API sends [] OR {} depending on patient
  final List<dynamic> mmt;
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
          ? ClinicalFindings.fromJson(json['Clinical Findings & Diagnosis'])
          : null,

      sessionSettings: json['Session Settings'] != null
          ? SessionSettings.fromJson(json['Session Settings'])
          : null,

      advice: json['Advice'] != null
          ? AdviceModel.fromJson(json['Advice'])
          : null,

      specialTests:
          (json['Special Tests Examination'] as Map<String, dynamic>? ?? {})
              .map(
                (key, value) => MapEntry(
                  key,
                  (value as List).map((e) => SpecialTest.fromJson(e)).toList(),
                ),
              ),

      // 🔥 KEY FIX: MMT can be [] (List) OR {} (Map) — handle both safely
      mmt: _parseMmt(json['Manual Muscle Testing (MMT)']),

      muscleAssessments: (json['Muscle Assessments / Exercises'] as List? ?? [])
          .map((e) => MuscleAssessment.fromJson(e))
          .toList(),

      prescription: json['General Therapeutic Prescription'] != null
          ? GeneralTherapeuticPrescription.fromJson(
              json['General Therapeutic Prescription'],
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
      'Manual Muscle Testing (MMT)': mmt,
      'Muscle Assessments / Exercises': muscleAssessments
          .map((e) => e.toJson())
          .toList(),
      'General Therapeutic Prescription': prescription?.toJson(),
      'Selected Packages': selectedPackages,
    };
  }
}

// ─────────────────────────────────────────────────────────────
// 🔥 MMT SAFE PARSER
// API sends [] (empty List) OR {} (empty/filled Map)
// Both cases return empty List so UI never crashes
// ─────────────────────────────────────────────────────────────
List<dynamic> _parseMmt(dynamic value) {
  if (value == null) return [];
  if (value is List) return value; // normal case: []
  if (value is Map) return []; // edge case: {} → treat as empty
  return [];
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
      test: json['Test'],
      result: json['Result'],
      findings: json['Findings'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'Test': test, 'Result': result, 'Findings': findings};
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
      note: json['Note'],
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
    return SessionSettings(duration: json['Prescribed Session Duration']);
  }

  Map<String, dynamic> toJson() {
    return {'Prescribed Session Duration': duration};
  }
}

// ─────────────────────────────────────────────────────────────
// 🔹 Advice
// ─────────────────────────────────────────────────────────────
class AdviceModel {
  final List<dynamic> investigationsDone;
  final String? otherAdvice;

  AdviceModel({required this.investigationsDone, this.otherAdvice});

  factory AdviceModel.fromJson(Map<String, dynamic> json) {
    return AdviceModel(
      investigationsDone: json['Investigations Done'] ?? [],
      otherAdvice: json['Other Investigations / Advice'],
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
  final List<dynamic> manualTreatment;
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
      muscle: json['Muscle'],
      conditionStatus: List<String>.from(json['Condition / Status'] ?? []),
      manualTreatment: json['Manual Treatment'] ?? [],
      otherTreatment: json['Other Treatment'],
      prescribedExercises: (json['Prescribed Exercises'] as List? ?? [])
          .map((e) => Exercise.fromJson(e))
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
      'Prescribed Exercises': prescribedExercises
          .map((e) => e.toJson())
          .toList(),
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
    return Exercise(name: json['Name'], dosage: json['Dosage']);
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
      electrotherapy: json['Electrotherapy'],
      thermo: json['Thermo / Cryotherapy'],
      antiInflammatory: json['Anti-Inflammatory Modalities'],
      advanced: json['Advanced Techniques'],
      medications: json['Medications'],
      topicals: json['Topicals'],
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
