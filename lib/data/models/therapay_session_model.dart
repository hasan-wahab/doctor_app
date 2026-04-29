// ============================================================
// THERAPY SESSIONS MODEL — Single File | Full Null Safe
// ============================================================

// ─────────────────────────────────────────────────────────────
// Helpers
// ─────────────────────────────────────────────────────────────
List<String> _strList(dynamic v) {
  if (v == null) return [];
  if (v is List) return v.map((e) => e?.toString() ?? '').toList();
  return [];
}

String? _str(dynamic v) {
  if (v == null) return null;
  if (v is String) return v.isEmpty ? null : v;
  if (v is List)
    return v.isEmpty ? null : v.map((e) => e?.toString() ?? '').join(', ');
  return v.toString();
}

int? _int(dynamic v) {
  if (v == null) return null;
  if (v is int) return v;
  return int.tryParse(v.toString());
}

String _display(dynamic v) {
  if (v == null) return 'No data';
  if (v is String && v.trim().isEmpty) return 'No data';
  if (v is List && v.isEmpty) return 'No data';
  if (v is List) return v.join(', ');
  return v.toString();
}

// ─────────────────────────────────────────────────────────────
// ROOT — TherapySessionsResponseModel
// ─────────────────────────────────────────────────────────────
class TherapySessionsResponseModel {
  final List<TherapySessionItemModel> sessions;
  final VisitSummaryModel? summary;

  TherapySessionsResponseModel({this.sessions = const [], this.summary});

  factory TherapySessionsResponseModel.fromJson(Map<String, dynamic> json) {
    return TherapySessionsResponseModel(
      sessions: (json['sessions'] as List<dynamic>? ?? [])
          .map(
            (e) => TherapySessionItemModel.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
      summary: json['summary'] != null
          ? VisitSummaryModel.fromJson(json['summary'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'sessions': sessions.map((e) => e.toJson()).toList(),
    'summary': summary?.toJson(),
  };
}

// ─────────────────────────────────────────────────────────────
// 1. TherapySessionItemModel
// ─────────────────────────────────────────────────────────────
class TherapySessionItemModel {
  final int? sessionNumber;
  final String? packageUsed;
  final String? therapist;
  final String? activeTime;
  final String? sessionDurationTotal;
  final List<ModalityModel> modalitiesPerformed;
  final String? nextSessionDate;
  final String? clinicalNotes;
  final String? createdAt;

  TherapySessionItemModel({
    this.sessionNumber,
    this.packageUsed,
    this.therapist,
    this.activeTime,
    this.sessionDurationTotal,
    this.modalitiesPerformed = const [],
    this.nextSessionDate,
    this.clinicalNotes,
    this.createdAt,
  });

  String get displaySessionNumber => _display(sessionNumber);
  String get displayPackageUsed => _display(packageUsed);
  String get displayTherapist => _display(therapist);
  String get displayActiveTime => _display(activeTime);
  String get displaySessionDurationTotal => _display(sessionDurationTotal);
  String get displayNextSessionDate => _display(nextSessionDate);
  String get displayClinicalNotes => _display(clinicalNotes);
  String get displayCreatedAt => _display(createdAt);

  factory TherapySessionItemModel.fromJson(Map<String, dynamic> json) {
    return TherapySessionItemModel(
      sessionNumber: _int(json['Session Number']),
      packageUsed: _str(json['Package Used']),
      therapist: _str(json['Therapist']),
      activeTime: _str(json['Active Time']),
      sessionDurationTotal: _str(json['Session Duration (Total)']),
      modalitiesPerformed:
          (json['Modalities Performed'] as List<dynamic>? ?? [])
              .map((e) => ModalityModel.fromJson(e as Map<String, dynamic>))
              .toList(),
      nextSessionDate: _str(json['Next Session Date']),
      clinicalNotes: _str(json['Clinical Notes']),
      createdAt: _str(json['Created At']),
    );
  }

  Map<String, dynamic> toJson() => {
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
}

// ─────────────────────────────────────────────────────────────
// 2. ModalityModel
// ─────────────────────────────────────────────────────────────
class ModalityModel {
  final String? modality;
  final String? duration;

  ModalityModel({this.modality, this.duration});

  String get displayModality => _display(modality);
  String get displayDuration => _display(duration);

  factory ModalityModel.fromJson(Map<String, dynamic> json) => ModalityModel(
    modality: _str(json['Modality']),
    duration: _str(json['Duration']),
  );

  Map<String, dynamic> toJson() => {'Modality': modality, 'Duration': duration};
}

// ─────────────────────────────────────────────────────────────
// 3. VisitSummaryModel
// ─────────────────────────────────────────────────────────────
class VisitSummaryModel {
  final VisitSummaryDetailModel? visitSummary;

  VisitSummaryModel({this.visitSummary});

  factory VisitSummaryModel.fromJson(Map<String, dynamic> json) =>
      VisitSummaryModel(
        visitSummary: json['Visit Summary'] is Map
            ? VisitSummaryDetailModel.fromJson(
                Map<String, dynamic>.from(json['Visit Summary'] as Map),
              )
            : null,
      );

  Map<String, dynamic> toJson() => {'Visit Summary': visitSummary?.toJson()};
}

// ─────────────────────────────────────────────────────────────
// 4. VisitSummaryDetailModel
// ─────────────────────────────────────────────────────────────
class VisitSummaryDetailModel {
  final String? clinic;
  final String? visitStatus;
  final String? currentStage;

  VisitSummaryDetailModel({this.clinic, this.visitStatus, this.currentStage});

  String get displayClinic => _display(clinic);
  String get displayVisitStatus => _display(visitStatus);
  String get displayCurrentStage => _display(currentStage);

  factory VisitSummaryDetailModel.fromJson(Map<String, dynamic> json) =>
      VisitSummaryDetailModel(
        clinic: _str(json['Clinic']),
        visitStatus: _str(json['Visit Status']),
        currentStage: _str(json['Current Stage']),
      );

  Map<String, dynamic> toJson() => {
    'Clinic': clinic,
    'Visit Status': visitStatus,
    'Current Stage': currentStage,
  };
}
