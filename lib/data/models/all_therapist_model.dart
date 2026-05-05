// ─────────────────────────────────────────────────────────────────────────────
// all_therapist_model.dart
// Full null-safe model — fromJson / toJson
// App will NEVER crash on null fields
// ─────────────────────────────────────────────────────────────────────────────

// ─────────────────────────────────────────────────────────────────────────────
// Helper
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

  // ── Safe display getters ──────────────────────────────────────────────────
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
      nextSessionDate!.toLowerCase() != 'not scheduled';

  factory TherapistSessionModel.fromJson(Map<String, dynamic> json) {
    final List<ModalityModel> modalities =
        (json['Modalities Performed'] as List<dynamic>? ?? [])
            .whereType<Map<String, dynamic>>()
            .map((e) => ModalityModel.fromJson(e))
            .toList();

    return TherapistSessionModel(
      sessionId: json['Session ID'] as int?,
      sessionNumber: json['Session Number'] as int?,
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

  // ── Safe display getters ──────────────────────────────────────────────────
  String get displayVisitId => visitId?.toString() ?? 'No data';
  String get displayVisitDate => _safe(visitDate);
  String get displayClinic => _safe(clinic);
  String get displayVisitStatus => _safe(visitStatus);
  String get displayCurrentStage => _safe(currentStage);

  bool get isCompleted => currentStage?.toLowerCase() == 'completed';

  factory TherapistVisitSummaryModel.fromJson(Map<String, dynamic> json) {
    return TherapistVisitSummaryModel(
      visitId: json['Visit ID'] as int?,
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

  // ── Helpers ───────────────────────────────────────────────────────────────
  bool get hasSessions => sessions.isNotEmpty;
  int get sessionCount => sessions.length;
  TherapistVisitSummaryModel? get visitSummary => summary?.visitSummary;

  factory TherapistVisitGroupModel.fromJson(Map<String, dynamic> json) {
    final List<TherapistSessionModel> parsedSessions =
        (json['sessions'] as List<dynamic>? ?? [])
            .whereType<Map<String, dynamic>>()
            .map((e) => TherapistSessionModel.fromJson(e))
            .toList();

    return TherapistVisitGroupModel(
      sessions: parsedSessions,
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
// 6. AllTherapistModel — wraps the full list
// ─────────────────────────────────────────────────────────────────────────────
class AllTherapistModel {
  final List<TherapistVisitGroupModel> visitGroups;

  AllTherapistModel({required this.visitGroups});

  // ── Helpers ───────────────────────────────────────────────────────────────
  bool get isEmpty => visitGroups.isEmpty;
  int get totalGroups => visitGroups.length;

  /// Flat list of all sessions across all visit groups
  List<TherapistSessionModel> get allSessions =>
      visitGroups.expand((g) => g.sessions).toList();

  /// Total sessions count across all groups
  int get totalSessionCount => allSessions.length;

  /// All completed visit groups
  List<TherapistVisitGroupModel> get completedVisits =>
      visitGroups.where((g) => g.visitSummary?.isCompleted == true).toList();

  // ── fromJson — parses a JSON array ───────────────────────────────────────
  factory AllTherapistModel.fromJson(List<dynamic> jsonList) {
    final List<TherapistVisitGroupModel> parsed = jsonList
        .whereType<Map<String, dynamic>>()
        .map((e) => TherapistVisitGroupModel.fromJson(e))
        .toList();
    return AllTherapistModel(visitGroups: parsed);
  }

  // ── toJson — returns a JSON array ─────────────────────────────────────────
  List<Map<String, dynamic>> toJson() {
    return visitGroups.map((g) => g.toJson()).toList();
  }

  @override
  String toString() =>
      'AllTherapistModel(totalGroups: $totalGroups, totalSessions: $totalSessionCount)';
}

// ─────────────────────────────────────────────────────────────────────────────
// USAGE EXAMPLE
// ─────────────────────────────────────────────────────────────────────────────
//
//  import 'dart:convert';
//
//  final List<dynamic> rawList = jsonDecode(response.body);
//  final AllTherapistModel allTherapist = AllTherapistModel.fromJson(rawList);
//
//  print(allTherapist.totalGroups);                       // 2
//  print(allTherapist.totalSessionCount);                 // 2
//  print(allTherapist.completedVisits.length);            // 2
//
//  final TherapistVisitGroupModel group = allTherapist.visitGroups[0];
//  print(group.sessionCount);                             // 1
//  print(group.visitSummary?.displayVisitId);             // "128"
//  print(group.visitSummary?.displayClinic);              // "Clinic 1 Male"
//  print(group.visitSummary?.displayVisitStatus);         // "No data" (was "")
//  print(group.visitSummary?.isCompleted);                // true
//
//  final TherapistSessionModel session = group.sessions[0];
//  print(session.displaySessionId);                       // "81"
//  print(session.displayTherapist);                       // "DR ARSALAN JAMIL"
//  print(session.displayActiveTime);                      // "3.45 mins"
//  print(session.displaySessionDurationTotal);            // "00:03:27"
//  print(session.displayNextSessionDate);                 // "Not scheduled"
//  print(session.displayClinicalNotes);                   // "vjjghjghjh"
//  print(session.hasModalities);                          // true
//  print(session.isScheduled);                            // false
//
//  print(session.modalitiesPerformed.length);             // 4
//  print(session.modalitiesPerformed[0].displayModality); // "GEN ELECTRO IFC"
//  print(session.modalitiesPerformed[0].displayDuration); // "70m"
//
//  // empty modalities — no crash:
//  final TherapistSessionModel session2 = allTherapist.visitGroups[1].sessions[0];
//  print(session2.hasModalities);                         // false
//  print(session2.modalitiesPerformed.length);            // 0
//
//  // Back to JSON:
//  final List<Map<String, dynamic>> backToJson = allTherapist.toJson();
// ─────────────────────────────────────────────────────────────────────────────
