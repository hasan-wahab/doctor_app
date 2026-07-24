class HistoryTrackerModel {
  final int? visitId;
  final String? visitDate;
  final PatientInformationModel? patientInformation;
  final PainLocationModel? painLocation;
  final RegionInvolvedModel? regionInvolved;
  final ChiefComplaintModel? chiefComplaint;
  final PainDetailsModel? painDetails;
  final RadiatingPainModel? radiatingPain;
  final AssociatedSymptomsModel? associatedSymptoms;
  final MovementRelatedPainModel? movementRelatedPain;
  final OnsetAndCauseModel? onsetAndCause;
  final AggravatingFactorsModel? aggravatingFactors;
  final RelievingFactorsModel? relievingFactors;
  final FunctionalLimitationsModel? functionalLimitations;
  final GaitAnalysisModel? gaitAnalysis;
  final PastMedicalHistoryModel? pastMedicalHistory;
  final PreviousInvestigationsModel? previousInvestigations;
  final RedFlagsModel? redFlags;
  final FaceOnsetCourseModel? faceOnsetCourse;
  final FaceEyeInvolvementModel? faceEyeInvolvement;
  final SpeechEatingDrinkingModel? speechEatingDrinking;
  final FaceSpecificPainModel? faceSpecificPain;
  final HouseholdWorkModel? householdWork;
  final ForWomenOnlyModel? forWomenOnly;
  final ForMenOnlyModel? forMenOnly;

  HistoryTrackerModel({
    this.visitId,
    this.visitDate,
    this.patientInformation,
    this.painLocation,
    this.regionInvolved,
    this.chiefComplaint,
    this.painDetails,
    this.radiatingPain,
    this.associatedSymptoms,
    this.movementRelatedPain,
    this.onsetAndCause,
    this.aggravatingFactors,
    this.relievingFactors,
    this.functionalLimitations,
    this.gaitAnalysis,
    this.pastMedicalHistory,
    this.previousInvestigations,
    this.redFlags,
    this.faceOnsetCourse,
    this.faceEyeInvolvement,
    this.speechEatingDrinking,
    this.faceSpecificPain,
    this.householdWork,
    this.forWomenOnly,
    this.forMenOnly,
  });

  String get displayVisitId => visitId?.toString() ?? 'No data';
  String get displayVisitDate => visitDate ?? 'No data';

  factory HistoryTrackerModel.fromJson(Map<String, dynamic> json) {
    return HistoryTrackerModel(
      visitId: _parseInt(json['Visit ID']),
      visitDate: _parseString(json['Visit Date']),
      patientInformation: json['Patient Information'] != null
          ? PatientInformationModel.fromJson(
              json['Patient Information'] as Map<String, dynamic>,
            )
          : null,
      painLocation: json['Pain Location (3D Medical Dashboard)'] != null
          ? PainLocationModel.fromJson(
              json['Pain Location (3D Medical Dashboard)']
                  as Map<String, dynamic>,
            )
          : null,
      regionInvolved: json['Region Involved'] != null
          ? RegionInvolvedModel.fromJson(
              json['Region Involved'] as Map<String, dynamic>,
            )
          : null,
      chiefComplaint: json['Chief Complaint'] != null
          ? ChiefComplaintModel.fromJson(
              json['Chief Complaint'] as Map<String, dynamic>,
            )
          : null,
      painDetails: json['Pain Details'] != null
          ? PainDetailsModel.fromJson(
              json['Pain Details'] as Map<String, dynamic>,
            )
          : null,
      radiatingPain: json['Radiating Pain (MANDATORY)'] != null
          ? RadiatingPainModel.fromJson(
              json['Radiating Pain (MANDATORY)'] as Map<String, dynamic>,
            )
          : null,
      associatedSymptoms: json['Associated Symptoms'] != null
          ? AssociatedSymptomsModel.fromJson(
              json['Associated Symptoms'] as Map<String, dynamic>,
            )
          : null,
      movementRelatedPain: json['Movement-Related Pain / Difficulty'] != null
          ? MovementRelatedPainModel.fromJson(
              json['Movement-Related Pain / Difficulty']
                  as Map<String, dynamic>,
            )
          : null,
      onsetAndCause: json['Onset & Cause'] != null
          ? OnsetAndCauseModel.fromJson(
              json['Onset & Cause'] as Map<String, dynamic>,
            )
          : null,
      aggravatingFactors: json['Aggravating Factors'] != null
          ? AggravatingFactorsModel.fromJson(
              json['Aggravating Factors'] as Map<String, dynamic>,
            )
          : null,
      relievingFactors: json['Relieving Factors'] != null
          ? RelievingFactorsModel.fromJson(
              json['Relieving Factors'] as Map<String, dynamic>,
            )
          : null,
      functionalLimitations: json['Functional Limitations (ADL)'] != null
          ? FunctionalLimitationsModel.fromJson(
              json['Functional Limitations (ADL)'] as Map<String, dynamic>,
            )
          : null,
      gaitAnalysis: json['Gait & Movement Analysis'] != null
          ? GaitAnalysisModel.fromJson(
              json['Gait & Movement Analysis'] as Map<String, dynamic>,
            )
          : null,
      pastMedicalHistory:
          json['Past Medical History & Previous Treatment'] != null
          ? PastMedicalHistoryModel.fromJson(
              json['Past Medical History & Previous Treatment']
                  as Map<String, dynamic>,
            )
          : null,
      previousInvestigations: json['Previous Investigations & Reports'] != null
          ? PreviousInvestigationsModel.fromJson(
              json['Previous Investigations & Reports'] as Map<String, dynamic>,
            )
          : null,
      redFlags: json['Red Flags'] != null
          ? RedFlagsModel.fromJson(json['Red Flags'] as Map<String, dynamic>)
          : null,
      faceOnsetCourse: json['Face: Onset & Course'] != null
          ? FaceOnsetCourseModel.fromJson(
              json['Face: Onset & Course'] as Map<String, dynamic>,
            )
          : null,
      faceEyeInvolvement: json['Face: Eye Involvement'] != null
          ? FaceEyeInvolvementModel.fromJson(
              json['Face: Eye Involvement'] as Map<String, dynamic>,
            )
          : null,
      speechEatingDrinking: json['Speech, Eating & Drinking'] != null
          ? SpeechEatingDrinkingModel.fromJson(
              json['Speech, Eating & Drinking'] as Map<String, dynamic>,
            )
          : null,
      faceSpecificPain: json['Face-Specific Pain'] != null
          ? FaceSpecificPainModel.fromJson(
              json['Face-Specific Pain'] as Map<String, dynamic>,
            )
          : null,
      householdWork: json['Household Work'] != null
          ? HouseholdWorkModel.fromJson(
              json['Household Work'] as Map<String, dynamic>,
            )
          : null,
      forWomenOnly: json['For Women Only'] != null
          ? ForWomenOnlyModel.fromJson(
              json['For Women Only'] as Map<String, dynamic>,
            )
          : null,
      forMenOnly: json['For Men Only'] != null
          ? ForMenOnlyModel.fromJson(
              json['For Men Only'] as Map<String, dynamic>,
            )
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Visit ID': visitId,
      'Visit Date': visitDate,
      'Patient Information': patientInformation?.toJson(),
      'Pain Location (3D Medical Dashboard)': painLocation?.toJson(),
      'Region Involved': regionInvolved?.toJson(),
      'Chief Complaint': chiefComplaint?.toJson(),
      'Pain Details': painDetails?.toJson(),
      'Radiating Pain (MANDATORY)': radiatingPain?.toJson(),
      'Associated Symptoms': associatedSymptoms?.toJson(),
      'Movement-Related Pain / Difficulty': movementRelatedPain?.toJson(),
      'Onset & Cause': onsetAndCause?.toJson(),
      'Aggravating Factors': aggravatingFactors?.toJson(),
      'Relieving Factors': relievingFactors?.toJson(),
      'Functional Limitations (ADL)': functionalLimitations?.toJson(),
      'Gait & Movement Analysis': gaitAnalysis?.toJson(),
      'Past Medical History & Previous Treatment': pastMedicalHistory?.toJson(),
      'Previous Investigations & Reports': previousInvestigations?.toJson(),
      'Red Flags': redFlags?.toJson(),
      'Face: Onset & Course': faceOnsetCourse?.toJson(),
      'Face: Eye Involvement': faceEyeInvolvement?.toJson(),
      'Speech, Eating & Drinking': speechEatingDrinking?.toJson(),
      'Face-Specific Pain': faceSpecificPain?.toJson(),
      'Household Work': householdWork?.toJson(),
      'For Women Only': forWomenOnly?.toJson(),
      'For Men Only': forMenOnly?.toJson(),
    };
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Helpers
// ─────────────────────────────────────────────────────────────────────────────
List<String> _parseStringList(dynamic value) {
  if (value == null) return [];
  if (value is List) return value.map((e) => e?.toString() ?? '').toList();
  if (value is String && value.trim().isNotEmpty) return [value];
  return [];
}

String? _parseString(dynamic value) {
  if (value == null) return null;
  if (value is String) return value.isEmpty ? null : value;
  return value.toString();
}

int? _parseInt(dynamic value) {
  if (value == null) return null;
  if (value is int) return value;
  if (value is num) return value.toInt();
  return int.tryParse(value.toString());
}

// ─────────────────────────────────────────────────────────────────────────────
// 1. Patient Information
// ─────────────────────────────────────────────────────────────────────────────
class PatientInformationModel {
  final String? name;
  final String? age;
  final String? occupation;

  PatientInformationModel({this.name, this.age, this.occupation});

  String get displayName => name ?? 'No data';
  String get displayAge => age ?? 'No data';
  String get displayOccupation =>
      (occupation == null || occupation!.trim().isEmpty)
      ? 'No data'
      : occupation!;

  factory PatientInformationModel.fromJson(Map<String, dynamic> json) {
    return PatientInformationModel(
      name: _parseString(json['Name']),
      age: _parseString(json['Age']),
      occupation: _parseString(json['Occupation']),
    );
  }

  Map<String, dynamic> toJson() => {
    'Name': name,
    'Age': age,
    'Occupation': occupation,
  };
}

// ─────────────────────────────────────────────────────────────────────────────
// 2. Pain Location
// ─────────────────────────────────────────────────────────────────────────────
class PainLocationModel {
  final List<String> painLocation;

  PainLocationModel({required this.painLocation});

  String get displayPainLocation =>
      painLocation.isEmpty ? 'No data' : painLocation.join(', ');

  factory PainLocationModel.fromJson(Map<String, dynamic> json) {
    return PainLocationModel(
      painLocation: _parseStringList(json['pain_location']),
    );
  }

  Map<String, dynamic> toJson() => {'pain_location': painLocation};
}

// ─────────────────────────────────────────────────────────────────────────────
// 3. Region Involved
// Region / Side Affected can be String OR List from API.
// ─────────────────────────────────────────────────────────────────────────────
class RegionInvolvedModel {
  final List<String> region;
  final List<String> sideAffected;
  final String? deviation;

  RegionInvolvedModel({
    required this.region,
    required this.sideAffected,
    this.deviation,
  });

  String get displayRegion => region.isEmpty ? 'No data' : region.join(', ');
  String get displaySideAffected =>
      sideAffected.isEmpty ? 'No data' : sideAffected.join(', ');
  String get displayDeviation =>
      (deviation == null || deviation!.trim().isEmpty) ? 'No data' : deviation!;

  factory RegionInvolvedModel.fromJson(Map<String, dynamic> json) {
    return RegionInvolvedModel(
      region: _parseStringList(json['Region']),
      sideAffected: _parseStringList(json['Side Affected']),
      deviation: _parseString(json['Deviation']),
    );
  }

  Map<String, dynamic> toJson() => {
    'Region': region,
    'Side Affected': sideAffected,
    'Deviation': deviation,
  };
}

// ─────────────────────────────────────────────────────────────────────────────
// 4. Chief Complaint
// ─────────────────────────────────────────────────────────────────────────────
class ChiefComplaintModel {
  final List<String> complaints;
  final List<String> sideAffected;
  final String? deviation;

  ChiefComplaintModel({
    required this.complaints,
    required this.sideAffected,
    this.deviation,
  });

  String get displayDeviation =>
      (deviation == null || deviation!.trim().isEmpty) ? 'No data' : deviation!;

  factory ChiefComplaintModel.fromJson(Map<String, dynamic> json) {
    return ChiefComplaintModel(
      complaints: _parseStringList(json['Complaints']),
      sideAffected: _parseStringList(json['Side Affected']),
      deviation: _parseString(json['Deviation']),
    );
  }

  Map<String, dynamic> toJson() => {
    'Complaints': complaints,
    'Side Affected': sideAffected,
    'Deviation': deviation,
  };
}

// ─────────────────────────────────────────────────────────────────────────────
// 5. Pain Details
// ─────────────────────────────────────────────────────────────────────────────
class PainDetailsModel {
  final int? painIntensityVas;
  final List<String> typeOfPain;
  final String? painPattern;
  final List<String> painTiming;
  final String? duration;

  PainDetailsModel({
    this.painIntensityVas,
    required this.typeOfPain,
    this.painPattern,
    required this.painTiming,
    this.duration,
  });

  String get displayPainIntensity =>
      painIntensityVas != null ? painIntensityVas.toString() : 'No data';
  String get displayTypeOfPain =>
      typeOfPain.isEmpty ? 'No data' : typeOfPain.join(', ');
  String get displayPainPattern => painPattern ?? 'No data';
  String get displayDuration => duration ?? 'No data';

  factory PainDetailsModel.fromJson(Map<String, dynamic> json) {
    return PainDetailsModel(
      painIntensityVas: _parseInt(json['Pain Intensity (VAS 0-10)']),
      typeOfPain: _parseStringList(json['Type of Pain']),
      painPattern: _parseString(json['Pain Pattern']),
      painTiming: _parseStringList(json['Pain Timing']),
      duration: _parseString(json['Duration']),
    );
  }

  Map<String, dynamic> toJson() => {
    'Pain Intensity (VAS 0-10)': painIntensityVas,
    'Type of Pain': typeOfPain,
    'Pain Pattern': painPattern,
    'Pain Timing': painTiming,
    'Duration': duration,
  };
}

// ─────────────────────────────────────────────────────────────────────────────
// 6. Radiating Pain
// ─────────────────────────────────────────────────────────────────────────────
class RadiatingPainModel {
  final String? radiatingStatus;
  final List<String> radiationPath;
  final String? radiationSide;

  RadiatingPainModel({
    this.radiatingStatus,
    required this.radiationPath,
    this.radiationSide,
  });

  String get displayRadiatingStatus => radiatingStatus ?? 'No data';
  String get displayRadiationSide =>
      (radiationSide == null || radiationSide!.trim().isEmpty)
      ? 'No data'
      : radiationSide!;
  bool get hasRadiation => radiatingStatus?.toLowerCase() == 'yes';

  factory RadiatingPainModel.fromJson(Map<String, dynamic> json) {
    return RadiatingPainModel(
      radiatingStatus: _parseString(json['Radiating Status']),
      radiationPath: _parseStringList(json['Radiation Path']),
      radiationSide: _parseString(json['Radiation Side']),
    );
  }

  Map<String, dynamic> toJson() => {
    'Radiating Status': radiatingStatus,
    'Radiation Path': radiationPath,
    'Radiation Side': radiationSide,
  };
}

// ─────────────────────────────────────────────────────────────────────────────
// 7. Associated Symptoms
// ─────────────────────────────────────────────────────────────────────────────
class AssociatedSymptomsModel {
  final List<String> symptoms;

  AssociatedSymptomsModel({required this.symptoms});

  factory AssociatedSymptomsModel.fromJson(Map<String, dynamic> json) {
    return AssociatedSymptomsModel(
      symptoms: _parseStringList(json['Symptoms']),
    );
  }

  Map<String, dynamic> toJson() => {'Symptoms': symptoms};
}

// ─────────────────────────────────────────────────────────────────────────────
// 8. Movement-Related Pain
// ─────────────────────────────────────────────────────────────────────────────
class MovementRelatedPainModel {
  final List<String> movements;

  MovementRelatedPainModel({required this.movements});

  factory MovementRelatedPainModel.fromJson(Map<String, dynamic> json) {
    return MovementRelatedPainModel(
      movements: _parseStringList(json['Movements']),
    );
  }

  Map<String, dynamic> toJson() => {'Movements': movements};
}

// ─────────────────────────────────────────────────────────────────────────────
// 9. Onset & Cause
// ─────────────────────────────────────────────────────────────────────────────
class OnsetAndCauseModel {
  final String? howDidItStart;
  final List<String> possibleCause;

  OnsetAndCauseModel({this.howDidItStart, required this.possibleCause});

  String get displayHowDidItStart => howDidItStart ?? 'No data';
  String get displayPossibleCause =>
      possibleCause.isEmpty ? 'No data' : possibleCause.join(', ');

  factory OnsetAndCauseModel.fromJson(Map<String, dynamic> json) {
    return OnsetAndCauseModel(
      howDidItStart: _parseString(json['How did the pain start?']),
      possibleCause: _parseStringList(json['Possible Cause']),
    );
  }

  Map<String, dynamic> toJson() => {
    'How did the pain start?': howDidItStart,
    'Possible Cause': possibleCause,
  };
}

// ─────────────────────────────────────────────────────────────────────────────
// 10. Aggravating Factors
// ─────────────────────────────────────────────────────────────────────────────
class AggravatingFactorsModel {
  final List<String> factors;

  AggravatingFactorsModel({required this.factors});

  factory AggravatingFactorsModel.fromJson(Map<String, dynamic> json) {
    return AggravatingFactorsModel(factors: _parseStringList(json['Factors']));
  }

  Map<String, dynamic> toJson() => {'Factors': factors};
}

// ─────────────────────────────────────────────────────────────────────────────
// 11. Relieving Factors
// ─────────────────────────────────────────────────────────────────────────────
class RelievingFactorsModel {
  final List<String> factors;

  RelievingFactorsModel({required this.factors});

  factory RelievingFactorsModel.fromJson(Map<String, dynamic> json) {
    return RelievingFactorsModel(factors: _parseStringList(json['Factors']));
  }

  Map<String, dynamic> toJson() => {'Factors': factors};
}

// ─────────────────────────────────────────────────────────────────────────────
// 12. Functional Limitations (ADL)
// ─────────────────────────────────────────────────────────────────────────────
class FunctionalLimitationsModel {
  final List<String> limitedActivities;

  FunctionalLimitationsModel({required this.limitedActivities});

  factory FunctionalLimitationsModel.fromJson(Map<String, dynamic> json) {
    return FunctionalLimitationsModel(
      limitedActivities: _parseStringList(
        json['LIMITED Activity of Daily Living'],
      ),
    );
  }

  Map<String, dynamic> toJson() => {
    'LIMITED Activity of Daily Living': limitedActivities,
  };
}

// ─────────────────────────────────────────────────────────────────────────────
// 13. Gait & Movement Analysis
// ─────────────────────────────────────────────────────────────────────────────
class GaitAnalysisModel {
  final String? analysis;

  GaitAnalysisModel({this.analysis});

  String get displayAnalysis =>
      (analysis == null || analysis!.trim().isEmpty) ? 'No data' : analysis!;

  factory GaitAnalysisModel.fromJson(Map<String, dynamic> json) {
    return GaitAnalysisModel(analysis: _parseString(json['Analysis']));
  }

  Map<String, dynamic> toJson() => {'Analysis': analysis};
}

// ─────────────────────────────────────────────────────────────────────────────
// 14. Past Medical History & Previous Treatment
// ─────────────────────────────────────────────────────────────────────────────
class PastMedicalHistoryModel {
  final List<String> medicalHistory;
  final List<String> medicalHistoryDetails;
  final String? surgicalHistory;
  final List<String> previousTreatments;
  final Map<String, String?> treatmentResponses;

  PastMedicalHistoryModel({
    required this.medicalHistory,
    required this.medicalHistoryDetails,
    this.surgicalHistory,
    required this.previousTreatments,
    required this.treatmentResponses,
  });

  String get displaySurgicalHistory =>
      (surgicalHistory == null || surgicalHistory!.trim().isEmpty)
      ? 'No data'
      : surgicalHistory!;

  factory PastMedicalHistoryModel.fromJson(Map<String, dynamic> json) {
    final parsedResponses = <String, String?>{};
    final responsesRaw = json['Treatment Responses'];
    if (responsesRaw is Map) {
      responsesRaw.forEach((key, value) {
        parsedResponses[key.toString()] = value != null
            ? value.toString()
            : null;
      });
    }

    return PastMedicalHistoryModel(
      medicalHistory: _parseStringList(json['Medical History']),
      medicalHistoryDetails: _parseStringList(json['Medical History Details']),
      surgicalHistory: _parseString(json['Surgical History']),
      previousTreatments: _parseStringList(json['Previous Treatments']),
      treatmentResponses: parsedResponses,
    );
  }

  Map<String, dynamic> toJson() => {
    'Medical History': medicalHistory,
    'Medical History Details': medicalHistoryDetails,
    'Surgical History': surgicalHistory,
    'Previous Treatments': previousTreatments,
    'Treatment Responses': treatmentResponses,
  };
}

// ─────────────────────────────────────────────────────────────────────────────
// 15. Previous Investigations & Reports
// ─────────────────────────────────────────────────────────────────────────────
class PreviousInvestigationsModel {
  final List<String> investigationsDone;

  PreviousInvestigationsModel({required this.investigationsDone});

  factory PreviousInvestigationsModel.fromJson(Map<String, dynamic> json) {
    return PreviousInvestigationsModel(
      investigationsDone: _parseStringList(json['Investigations Done']),
    );
  }

  Map<String, dynamic> toJson() => {'Investigations Done': investigationsDone};
}

// ─────────────────────────────────────────────────────────────────────────────
// 16. Red Flags
// ─────────────────────────────────────────────────────────────────────────────
class RedFlagsModel {
  final List<String> flags;

  RedFlagsModel({required this.flags});

  bool get hasRedFlags => flags.isNotEmpty;

  factory RedFlagsModel.fromJson(Map<String, dynamic> json) {
    return RedFlagsModel(flags: _parseStringList(json['Flags']));
  }

  Map<String, dynamic> toJson() => {'Flags': flags};
}

// ─────────────────────────────────────────────────────────────────────────────
// 17. Face: Onset & Course  (NEW)
// ─────────────────────────────────────────────────────────────────────────────
class FaceOnsetCourseModel {
  final String? onset;
  final String? duration;
  final List<String> course;
  final String? coldExposure;

  FaceOnsetCourseModel({
    this.onset,
    this.duration,
    required this.course,
    this.coldExposure,
  });

  String get displayOnset =>
      (onset == null || onset!.trim().isEmpty) ? 'No data' : onset!;
  String get displayDuration =>
      (duration == null || duration!.trim().isEmpty) ? 'No data' : duration!;
  String get displayColdExposure =>
      (coldExposure == null || coldExposure!.trim().isEmpty)
      ? 'No data'
      : coldExposure!;

  factory FaceOnsetCourseModel.fromJson(Map<String, dynamic> json) {
    return FaceOnsetCourseModel(
      onset: _parseString(json['Onset']),
      duration: _parseString(json['Duration']),
      course: _parseStringList(json['Course']),
      coldExposure: _parseString(json['Cold Exposure']),
    );
  }

  Map<String, dynamic> toJson() => {
    'Onset': onset,
    'Duration': duration,
    'Course': course,
    'Cold Exposure': coldExposure,
  };
}

// ─────────────────────────────────────────────────────────────────────────────
// 18. Face: Eye Involvement  (NEW)
// ─────────────────────────────────────────────────────────────────────────────
class FaceEyeInvolvementModel {
  final String? eyeClosureFully;
  final int? eyeClosurePercent;
  final String? eyeDryness;
  final int? eyeDrynessPercent;

  FaceEyeInvolvementModel({
    this.eyeClosureFully,
    this.eyeClosurePercent,
    this.eyeDryness,
    this.eyeDrynessPercent,
  });

  String get displayEyeClosureFully =>
      (eyeClosureFully == null || eyeClosureFully!.trim().isEmpty)
      ? 'No data'
      : eyeClosureFully!;
  String get displayEyeClosurePercent =>
      eyeClosurePercent != null ? '$eyeClosurePercent%' : 'No data';
  String get displayEyeDryness =>
      (eyeDryness == null || eyeDryness!.trim().isEmpty)
      ? 'No data'
      : eyeDryness!;
  String get displayEyeDrynessPercent =>
      eyeDrynessPercent != null ? '$eyeDrynessPercent%' : 'No data';

  factory FaceEyeInvolvementModel.fromJson(Map<String, dynamic> json) {
    return FaceEyeInvolvementModel(
      eyeClosureFully: _parseString(json['Eye Closure Fully']),
      eyeClosurePercent: _parseInt(json['Eye Closure %']),
      eyeDryness: _parseString(json['Eye Dryness']),
      eyeDrynessPercent: _parseInt(json['Eye Dryness %']),
    );
  }

  Map<String, dynamic> toJson() => {
    'Eye Closure Fully': eyeClosureFully,
    'Eye Closure %': eyeClosurePercent,
    'Eye Dryness': eyeDryness,
    'Eye Dryness %': eyeDrynessPercent,
  };
}

// ─────────────────────────────────────────────────────────────────────────────
// 19. Speech, Eating & Drinking  (NEW)
// ─────────────────────────────────────────────────────────────────────────────
class SpeechEatingDrinkingModel {
  final List<String> assessment;

  SpeechEatingDrinkingModel({required this.assessment});

  factory SpeechEatingDrinkingModel.fromJson(Map<String, dynamic> json) {
    return SpeechEatingDrinkingModel(
      assessment: _parseStringList(json['Assessment']),
    );
  }

  Map<String, dynamic> toJson() => {'Assessment': assessment};
}

// ─────────────────────────────────────────────────────────────────────────────
// 20. Face-Specific Pain  (NEW)
// ─────────────────────────────────────────────────────────────────────────────
class FaceSpecificPainModel {
  final String? painPresent;
  final List<String> location;
  final int? intensity;

  FaceSpecificPainModel({
    this.painPresent,
    required this.location,
    this.intensity,
  });

  String get displayPainPresent =>
      (painPresent == null || painPresent!.trim().isEmpty)
      ? 'No data'
      : painPresent!;
  String get displayLocation =>
      location.isEmpty ? 'No data' : location.join(', ');
  String get displayIntensity =>
      intensity != null ? intensity.toString() : 'No data';

  factory FaceSpecificPainModel.fromJson(Map<String, dynamic> json) {
    return FaceSpecificPainModel(
      painPresent: _parseString(json['Pain Present']),
      location: _parseStringList(json['Location']),
      intensity: _parseInt(json['Intensity']),
    );
  }

  Map<String, dynamic> toJson() => {
    'Pain Present': painPresent,
    'Location': location,
    'Intensity': intensity,
  };
}

// ─────────────────────────────────────────────────────────────────────────────
// 21. Household Work  (NEW)
// ─────────────────────────────────────────────────────────────────────────────
class HouseholdWorkModel {
  final String? status;
  final List<String> tasks;

  HouseholdWorkModel({this.status, required this.tasks});

  bool get isActive => status?.toLowerCase() == 'yes';
  String get displayStatus => status ?? 'No data';
  String get displayTasks => tasks.isEmpty ? 'No data' : tasks.join(', ');

  factory HouseholdWorkModel.fromJson(Map<String, dynamic> json) {
    return HouseholdWorkModel(
      status: _parseString(json['Status']),
      tasks: _parseStringList(json['Tasks']),
    );
  }

  Map<String, dynamic> toJson() => {'Status': status, 'Tasks': tasks};
}

// ─────────────────────────────────────────────────────────────────────────────
// 22. For Women Only  (NEW)
// ─────────────────────────────────────────────────────────────────────────────
class ForWomenOnlyModel {
  final String? marriedSince;
  final String? hasChildren;
  final String? specialChild;
  final String? isPregnant;
  final String? pregnancyType;
  final String? previousPregnancy;
  final String? deliveryType;
  final String? cycleRegular;
  final String? cycleDescribe;
  final String? periodDiscomfort;
  final String? periodPainDescribe;
  final String? gyneConditions;
  final String? gyneDescribe;
  final String? intercoursePain;
  final String? hasIud;
  final String? urineLeakage;
  final String? nocturia;

  ForWomenOnlyModel({
    this.marriedSince,
    this.hasChildren,
    this.specialChild,
    this.isPregnant,
    this.pregnancyType,
    this.previousPregnancy,
    this.deliveryType,
    this.cycleRegular,
    this.cycleDescribe,
    this.periodDiscomfort,
    this.periodPainDescribe,
    this.gyneConditions,
    this.gyneDescribe,
    this.intercoursePain,
    this.hasIud,
    this.urineLeakage,
    this.nocturia,
  });

  String _d(String? v) => (v == null || v.trim().isEmpty) ? 'No data' : v;

  String get displayMarriedSince => _d(marriedSince);
  String get displayHasChildren => _d(hasChildren);
  String get displaySpecialChild => _d(specialChild);
  String get displayIsPregnant => _d(isPregnant);
  String get displayPregnancyType => _d(pregnancyType);
  String get displayPreviousPregnancy => _d(previousPregnancy);
  String get displayDeliveryType => _d(deliveryType);
  String get displayCycleRegular => _d(cycleRegular);
  String get displayCycleDescribe => _d(cycleDescribe);
  String get displayPeriodDiscomfort => _d(periodDiscomfort);
  String get displayPeriodPainDescribe => _d(periodPainDescribe);
  String get displayGyneConditions => _d(gyneConditions);
  String get displayGyneDescribe => _d(gyneDescribe);
  String get displayIntercoursePain => _d(intercoursePain);
  String get displayHasIud => _d(hasIud);
  String get displayUrineLeakage => _d(urineLeakage);
  String get displayNocturia => _d(nocturia);

  factory ForWomenOnlyModel.fromJson(Map<String, dynamic> json) {
    return ForWomenOnlyModel(
      marriedSince: _parseString(json['Married since']),
      hasChildren: _parseString(json['Has children']),
      specialChild: _parseString(json['Special child']),
      isPregnant: _parseString(json['Is pregnant']),
      pregnancyType: _parseString(json['Pregnancy type']),
      previousPregnancy: _parseString(json['Previous pregnancy']),
      deliveryType: _parseString(json['Delivery type']),
      cycleRegular: _parseString(json['Cycle regular']),
      cycleDescribe: _parseString(json['Cycle describe']),
      periodDiscomfort: _parseString(json['Period discomfort']),
      periodPainDescribe: _parseString(json['Period pain describe']),
      gyneConditions: _parseString(json['Gyne conditions']),
      gyneDescribe: _parseString(json['Gyne describe']),
      intercoursePain: _parseString(json['Intercourse pain']),
      hasIud: _parseString(json['Has IUD']),
      urineLeakage: _parseString(json['Urine leakage']),
      nocturia: _parseString(json['Nocturia']),
    );
  }

  Map<String, dynamic> toJson() => {
    'Married since': marriedSince,
    'Has children': hasChildren,
    'Special child': specialChild,
    'Is pregnant': isPregnant,
    'Pregnancy type': pregnancyType,
    'Previous pregnancy': previousPregnancy,
    'Delivery type': deliveryType,
    'Cycle regular': cycleRegular,
    'Cycle describe': cycleDescribe,
    'Period discomfort': periodDiscomfort,
    'Period pain describe': periodPainDescribe,
    'Gyne conditions': gyneConditions,
    'Gyne describe': gyneDescribe,
    'Intercourse pain': intercoursePain,
    'Has IUD': hasIud,
    'Urine leakage': urineLeakage,
    'Nocturia': nocturia,
  };
}

// ─────────────────────────────────────────────────────────────────────────────
// 23. For Men Only
// ─────────────────────────────────────────────────────────────────────────────
class ForMenOnlyModel {
  final String? urinationPain;
  final String? urineLeakage;
  final String? nocturia;
  final String? genitalNumbness;
  final String? bladderOrSexualWorsening;

  ForMenOnlyModel({
    this.urinationPain,
    this.urineLeakage,
    this.nocturia,
    this.genitalNumbness,
    this.bladderOrSexualWorsening,
  });

  String _d(String? v) => (v == null || v.trim().isEmpty) ? 'No data' : v;

  String get displayUrinationPain => _d(urinationPain);
  String get displayUrineLeakage => _d(urineLeakage);
  String get displayNocturia => _d(nocturia);
  String get displayGenitalNumbness => _d(genitalNumbness);
  String get displayBladderOrSexualWorsening => _d(bladderOrSexualWorsening);

  factory ForMenOnlyModel.fromJson(Map<String, dynamic> json) {
    return ForMenOnlyModel(
      urinationPain: _parseString(json['Urination pain']),
      urineLeakage: _parseString(json['Urine leakage']),
      nocturia: _parseString(json['Nocturia']),
      genitalNumbness: _parseString(json['Genital numbness']),
      bladderOrSexualWorsening: _parseString(json['Bladder/Sexual worsening']),
    );
  }

  Map<String, dynamic> toJson() => {
    'Urination pain': urinationPain,
    'Urine leakage': urineLeakage,
    'Nocturia': nocturia,
    'Genital numbness': genitalNumbness,
    'Bladder/Sexual worsening': bladderOrSexualWorsening,
  };
}
