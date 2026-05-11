class HistoryTrackerModel {
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
  final ForMenOnlyModel? forMenOnly;

  HistoryTrackerModel({
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
    this.forMenOnly,
  });

  factory HistoryTrackerModel.fromJson(Map<String, dynamic> json) {
    return HistoryTrackerModel(
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
      forMenOnly: json['For Men Only'] != null
          ? ForMenOnlyModel.fromJson(
        json['For Men Only'] as Map<String, dynamic>,
      )
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
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
      'For Men Only': forMenOnly?.toJson(),
    };
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Helper — safely parse any dynamic value to List<String>
// Returns empty list if null so UI never crashes
// ─────────────────────────────────────────────────────────────────────────────
List<String> _parseStringList(dynamic value) {
  if (value == null) return [];
  if (value is List) return value.map((e) => e?.toString() ?? '').toList();
  return [];
}

// ─────────────────────────────────────────────────────────────────────────────
// Helper — safely parse a field that could be String OR List<dynamic>
// If List  → joins with ", "
// If String → returns as-is
// If null  → returns null
// ─────────────────────────────────────────────────────────────────────────────
String? _parseStringOrList(dynamic value) {
  if (value == null) return null;
  if (value is String) return value;
  if (value is List) {
    final items = value.map((e) => e?.toString() ?? '').toList();
    return items.isEmpty ? null : items.join(', ');
  }
  return value.toString();
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
  String get displayOccupation => occupation ?? 'No data';

  factory PatientInformationModel.fromJson(Map<String, dynamic> json) {
    return PatientInformationModel(
      name: json['Name'] as String?,
      age: json['Age'] as String?,
      occupation: json['Occupation'] as String?,
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

  factory PainLocationModel.fromJson(Map<String, dynamic> json) {
    return PainLocationModel(
      painLocation: _parseStringList(json['pain_location']),
    );
  }

  Map<String, dynamic> toJson() => {'pain_location': painLocation};
}

// ─────────────────────────────────────────────────────────────────────────────
// 3. Region Involved
// FIX: 'Side Affected' can be null, String, or List<dynamic> from API.
//      Using _parseStringOrList() to handle all cases safely.
// ─────────────────────────────────────────────────────────────────────────────
class RegionInvolvedModel {
  final String? region;
  final String? sideAffected;   // may arrive as List → joined to String
  final String? deviation;

  RegionInvolvedModel({this.region, this.sideAffected, this.deviation});

  String get displayRegion => region ?? 'No data';
  String get displaySideAffected => sideAffected ?? 'No data';
  String get displayDeviation => deviation ?? 'No data';

  factory RegionInvolvedModel.fromJson(Map<String, dynamic> json) {
    return RegionInvolvedModel(
      region: _parseStringOrList(json['Region']),        // ← fix
      sideAffected: _parseStringOrList(json['Side Affected']),  // ← fix
      deviation: _parseStringOrList(json['Deviation']),  // ← fix
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

  String get displayDeviation => deviation ?? 'No data';

  factory ChiefComplaintModel.fromJson(Map<String, dynamic> json) {
    return ChiefComplaintModel(
      complaints: _parseStringList(json['Complaints']),
      sideAffected: _parseStringList(json['Side Affected']),
      deviation: json['Deviation'] as String?,
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
  String get displayPainPattern => painPattern ?? 'No data';
  String get displayDuration => duration ?? 'No data';

  factory PainDetailsModel.fromJson(Map<String, dynamic> json) {
    return PainDetailsModel(
      painIntensityVas: json['Pain Intensity (VAS 0-10)'] as int?,
      typeOfPain: _parseStringList(json['Type of Pain']),
      painPattern: json['Pain Pattern'] as String?,
      painTiming: _parseStringList(json['Pain Timing']),
      duration: json['Duration'] as String?,
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
  String get displayRadiationSide => radiationSide ?? 'No data';
  bool get hasRadiation => radiatingStatus?.toLowerCase() == 'yes';

  factory RadiatingPainModel.fromJson(Map<String, dynamic> json) {
    return RadiatingPainModel(
      radiatingStatus: json['Radiating Status'] as String?,
      radiationPath: _parseStringList(json['Radiation Path']),
      radiationSide: json['Radiation Side'] as String?,
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

  factory OnsetAndCauseModel.fromJson(Map<String, dynamic> json) {
    return OnsetAndCauseModel(
      howDidItStart: json['How did the pain start?'] as String?,
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

  String get displayAnalysis => analysis ?? 'No data';

  factory GaitAnalysisModel.fromJson(Map<String, dynamic> json) {
    return GaitAnalysisModel(analysis: json['Analysis'] as String?);
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

  String get displaySurgicalHistory => surgicalHistory ?? 'No data';

  factory PastMedicalHistoryModel.fromJson(Map<String, dynamic> json) {
    Map<String, String?> parsedResponses = {};
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
      surgicalHistory: json['Surgical History'] as String?,
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
// 17. For Men Only
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

  String get displayUrinationPain => urinationPain ?? 'No data';
  String get displayUrineLeakage => urineLeakage ?? 'No data';
  String get displayNocturia => nocturia ?? 'No data';
  String get displayGenitalNumbness => genitalNumbness ?? 'No data';
  String get displayBladderOrSexualWorsening =>
      bladderOrSexualWorsening ?? 'No data';

  factory ForMenOnlyModel.fromJson(Map<String, dynamic> json) {
    return ForMenOnlyModel(
      urinationPain: json['Urination pain'] as String?,
      urineLeakage: json['Urine leakage'] as String?,
      nocturia: json['Nocturia'] as String?,
      genitalNumbness: json['Genital numbness'] as String?,
      bladderOrSexualWorsening: json['Bladder/Sexual worsening'] as String?,
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