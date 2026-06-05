// ─────────────────────────────────────────────────────────────────────────────
// all_therapist_model.dart
// Full null-safe model — fromJson / toJson
// App will NEVER crash on null fields
// ─────────────────────────────────────────────────────────────────────────────

// ─────────────────────────────────────────────────────────────────────────────
// Helpers
// ─────────────────────────────────────────────────────────────────────────────
List<String> _parseStringList(dynamic value) {
  if (value == null) return [];
  if (value is List) return value.map((e) => e?.toString() ?? '').toList();
  return [];
}

String _safe(dynamic value) {
  if (value == null) return 'No data';
  final str = value.toString().trim();
  return str.isEmpty ? 'No data' : str;
}

int? _parseInt(dynamic value) {
  if (value == null) return null;
  if (value is int) return value;
  if (value is num) return value.toInt();
  return int.tryParse(value.toString());
}

// 🔥 KEY FIX: sessions can be [] (List) OR {} (Map) depending on patient
// If List  → parse each item as TherapistSessionModel
// If Map   → parse each map value as TherapistSessionModel
// If null  → return []
List<TherapistSessionModel> _parseSessions(dynamic value) {
  if (value == null) return [];

  if (value is List) {
    return value
        .whereType<Map<String, dynamic>>()
        .map((e) => TherapistSessionModel.fromJson(e))
        .toList();
  }

  if (value is Map) {
    return value.values
        .whereType<Map<String, dynamic>>()
        .map((e) => TherapistSessionModel.fromJson(e))
        .toList();
  }

  return [];
}

// ─────────────────────────────────────────────────────────────────────────────
// 1. Modality
// ─────────────────────────────────────────────────────────────────────────────
class ModalityModel {
  final String? modality;
  final String? duration;

  ModalityModel({this.modality, this.duration});

  String get displayModality => _safe(modality);
  String get displayDuration => _safe(duration);

  factory ModalityModel.fromJson(Map<String, dynamic> json) {
    return ModalityModel(
      modality: json['Modality'] as String?,
      duration: json['Duration'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {'Modality': modality, 'Duration': duration};

  @override
  String toString() =>
      'ModalityModel(modality: $modality, duration: $duration)';
}

// ─────────────────────────────────────────────────────────────────────────────
// 2. Session Item
// ─────────────────────────────────────────────────────────────────────────────
class TherapistSessionModel {
  final int? sessionId;
  final int? sessionNumber;
  final String? packageUsed;
  final String? therapist;
  final String? activeTime;
  final String? sessionDurationTotal;
  final List<ModalityModel> modalitiesPerformed;
  final String? nextSessionDate;
  final String? clinicalNotes;
  final String? createdAt;

  TherapistSessionModel({
    this.sessionId,
    this.sessionNumber,
    this.packageUsed,
    this.therapist,
    this.activeTime,
    this.sessionDurationTotal,
    required this.modalitiesPerformed,
    this.nextSessionDate,
    this.clinicalNotes,
    this.createdAt,
  });

  String get displaySessionId => sessionId?.toString() ?? 'No data';
  String get displaySessionNumber => sessionNumber?.toString() ?? 'No data';
  String get displayPackageUsed => _safe(packageUsed);
  String get displayTherapist => _safe(therapist);
  String get displayActiveTime => _safe(activeTime);
  String get displaySessionDurationTotal => _safe(sessionDurationTotal);
  String get displayNextSessionDate => _safe(nextSessionDate);
  String get displayClinicalNotes => _safe(clinicalNotes);
  String get displayCreatedAt => _safe(createdAt);

  bool get hasModalities => modalitiesPerformed.isNotEmpty;
  bool get isScheduled =>
      nextSessionDate != null &&
      nextSessionDate!.trim().isNotEmpty &&
      nextSessionDate!.toLowerCase() != 'no data';

  factory TherapistSessionModel.fromJson(Map<String, dynamic> json) {
    final List<ModalityModel> modalities =
        (json['Modalities Performed'] as List<dynamic>? ?? [])
            .whereType<Map<String, dynamic>>()
            .map((e) => ModalityModel.fromJson(e))
            .toList();

    return TherapistSessionModel(
      sessionId: _parseInt(json['Session ID']),
      sessionNumber: _parseInt(json['Session Number']),
      packageUsed: json['Package Used'] as String?,
      therapist: json['Therapist'] as String?,
      activeTime: json['Active Time'] as String?,
      sessionDurationTotal: json['Session Duration (Total)'] as String?,
      modalitiesPerformed: modalities,
      nextSessionDate: json['Next Session Date'] as String?,
      clinicalNotes: json['Clinical Notes'] as String?,
      createdAt: json['Created At'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'Session ID': sessionId,
    'Session Number': sessionNumber,
    'Package Used': packageUsed,
    'Therapist': therapist,
    'Active Time': activeTime,
    'Session Duration (Total)': sessionDurationTotal,
    'Modalities Performed': modalitiesPerformed.map((e) => e.toJson()).toList(),
    'Next Session Date': nextSessionDate,
    'Clinical Notes': clinicalNotes,
    'Created At': createdAt,
  };

  @override
  String toString() =>
      'TherapistSessionModel(sessionId: $sessionId, therapist: $therapist)';
}

// ─────────────────────────────────────────────────────────────────────────────
// 3. Visit Summary
// ─────────────────────────────────────────────────────────────────────────────
class TherapistVisitSummaryModel {
  final int? visitId;
  final String? visitDate;
  final String? clinic;
  final String? visitStatus;
  final String? currentStage;

  TherapistVisitSummaryModel({
    this.visitId,
    this.visitDate,
    this.clinic,
    this.visitStatus,
    this.currentStage,
  });

  String get displayVisitId => visitId?.toString() ?? 'No data';
  String get displayVisitDate => _safe(visitDate);
  String get displayClinic => _safe(clinic);
  String get displayVisitStatus => _safe(visitStatus);
  String get displayCurrentStage => _safe(currentStage);

  bool get isCompleted => currentStage?.toLowerCase() == 'completed';

  factory TherapistVisitSummaryModel.fromJson(Map<String, dynamic> json) {
    return TherapistVisitSummaryModel(
      visitId: _parseInt(json['Visit ID']),
      visitDate: json['Visit Date'] as String?,
      clinic: json['Clinic'] as String?,
      visitStatus: json['Visit Status'] as String?,
      currentStage: json['Current Stage'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'Visit ID': visitId,
    'Visit Date': visitDate,
    'Clinic': clinic,
    'Visit Status': visitStatus,
    'Current Stage': currentStage,
  };
}

// ─────────────────────────────────────────────────────────────────────────────
// 4. Summary wrapper
// ─────────────────────────────────────────────────────────────────────────────
class TherapistSummaryModel {
  final TherapistVisitSummaryModel? visitSummary;

  TherapistSummaryModel({this.visitSummary});

  factory TherapistSummaryModel.fromJson(Map<String, dynamic> json) {
    return TherapistSummaryModel(
      visitSummary: json['Visit Summary'] != null
          ? TherapistVisitSummaryModel.fromJson(
              json['Visit Summary'] as Map<String, dynamic>,
            )
          : null,
    );
  }

  Map<String, dynamic> toJson() => {'Visit Summary': visitSummary?.toJson()};
}

// ─────────────────────────────────────────────────────────────────────────────
// 5. Single therapist visit group (sessions + summary)
// ─────────────────────────────────────────────────────────────────────────────
class TherapistVisitGroupModel {
  final List<TherapistSessionModel> sessions;
  final TherapistSummaryModel? summary;

  TherapistVisitGroupModel({required this.sessions, this.summary});

  bool get hasSessions => sessions.isNotEmpty;
  int get sessionCount => sessions.length;
  TherapistVisitSummaryModel? get visitSummary => summary?.visitSummary;

  factory TherapistVisitGroupModel.fromJson(Map<String, dynamic> json) {
    return TherapistVisitGroupModel(
      // 🔥 KEY FIX: _parseSessions handles both [] and {} safely
      sessions: _parseSessions(json['sessions']),
      summary: json['summary'] != null
          ? TherapistSummaryModel.fromJson(
              json['summary'] as Map<String, dynamic>,
            )
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'sessions': sessions.map((e) => e.toJson()).toList(),
    'summary': summary?.toJson(),
  };

  @override
  String toString() =>
      'TherapistVisitGroupModel(sessionCount: $sessionCount, visitId: ${visitSummary?.visitId})';
}

// ─────────────────────────────────────────────────────────────────────────────
// 6. Optional API metadata: type_hints
// ─────────────────────────────────────────────────────────────────────────────
class AllTherapistTypeHintsModel {
  final List<String> arrays;
  final List<String> strings;
  final List<String> integers;

  AllTherapistTypeHintsModel({
    required this.arrays,
    required this.strings,
    required this.integers,
  });

  factory AllTherapistTypeHintsModel.fromJson(Map<String, dynamic> json) {
    return AllTherapistTypeHintsModel(
      arrays: _parseStringList(json['Arrays']),
      strings: _parseStringList(json['Strings']),
      integers: _parseStringList(json['Integers']),
    );
  }

  Map<String, dynamic> toJson() => {
    'Arrays': arrays,
    'Strings': strings,
    'Integers': integers,
  };
}

// ─────────────────────────────────────────────────────────────────────────────
// 7. AllTherapistModel — wraps the full response
// ─────────────────────────────────────────────────────────────────────────────
class AllTherapistModel {
  /// Server-reported total (e.g. visit count); may differ from [visitGroups].length.
  final int? total;
  final List<TherapistVisitGroupModel> visitGroups;
  final AllTherapistTypeHintsModel? typeHints;

  AllTherapistModel({
    required this.visitGroups,
    this.total,
    this.typeHints,
  });

  bool get isEmpty => visitGroups.isEmpty;
  int get totalGroups => visitGroups.length;

  List<TherapistSessionModel> get allSessions =>
      visitGroups.expand((g) => g.sessions).toList();

  int get totalSessionCount => allSessions.length;

  List<TherapistVisitGroupModel> get completedVisits =>
      visitGroups.where((g) => g.visitSummary?.isCompleted == true).toList();

  /// Full envelope: `{ "total", "visit_wise_sessions", "type_hints" }`,
  /// or a bare list (legacy cache / old API).
  factory AllTherapistModel.fromJson(dynamic json) {
    int? totalVal;
    AllTherapistTypeHintsModel? hintsVal;
    List<dynamic> list = [];

    if (json is List) {
      list = json;
    } else if (json is Map<String, dynamic>) {
      totalVal = _parseInt(json['total']);
      final hintsRaw = json['type_hints'];
      if (hintsRaw is Map<String, dynamic>) {
        hintsVal = AllTherapistTypeHintsModel.fromJson(hintsRaw);
      }
      final raw = json['visit_wise_sessions'];
      if (raw is List) {
        list = raw;
      }
    }

    final parsed = list
        .whereType<Map<String, dynamic>>()
        .map((e) => TherapistVisitGroupModel.fromJson(e))
        .toList();

    return AllTherapistModel(
      visitGroups: parsed,
      total: totalVal,
      typeHints: hintsVal,
    );
  }

  /// Persists full API shape for local cache round-trip.
  Map<String, dynamic> toJson() {
    return {
      if (total != null) 'total': total,
      'visit_wise_sessions': visitGroups.map((g) => g.toJson()).toList(),
      if (typeHints != null) 'type_hints': typeHints!.toJson(),
    };
  }

  @override
  String toString() =>
      'AllTherapistModel(total: $total, totalGroups: $totalGroups, '
      'totalSessions: $totalSessionCount)';
}
