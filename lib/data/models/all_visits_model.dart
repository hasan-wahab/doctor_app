// ─────────────────────────────────────────────────────────────────────────────
// all_visits_model.dart
// Full null-safe model — fromJson / toJson
// App will NEVER crash on null fields
// ─────────────────────────────────────────────────────────────────────────────

class VisitItemModel {
  final int? visitId;
  final String? type;
  final String? status;
  final String? stage;
  final String? date;
  final num? consultationFee;
  final String? doctor;
  final String? createdAt;

  VisitItemModel({
    this.visitId,
    this.type,
    this.status,
    this.stage,
    this.date,
    this.consultationFee,
    this.doctor,
    this.createdAt,
  });

  // ── Safe display getters — UI uses these, never raw nullable fields ──────
  String get displayVisitId => visitId?.toString() ?? 'No data';
  String get displayType =>
      (type != null && type!.trim().isNotEmpty) ? type! : 'No data';
  String get displayStatus =>
      (status != null && status!.trim().isNotEmpty) ? status! : 'No data';
  String get displayStage =>
      (stage != null && stage!.trim().isNotEmpty) ? stage! : 'No data';
  String get displayDate =>
      (date != null && date!.trim().isNotEmpty) ? date! : 'No data';
  String get displayConsultationFee =>
      consultationFee != null ? consultationFee.toString() : 'No data';
  String get displayDoctor =>
      (doctor != null && doctor!.trim().isNotEmpty) ? doctor! : 'No data';
  String get displayCreatedAt =>
      (createdAt != null && createdAt!.trim().isNotEmpty)
      ? createdAt!
      : 'No data';

  // ── Helpers ───────────────────────────────────────────────────────────────
  bool get isConsultation => type?.toLowerCase() == 'consultation';
  bool get isPackageSession => type?.toLowerCase() == 'package session';
  bool get isCompleted => stage?.toLowerCase() == 'completed';
  bool get hasFee => consultationFee != null;

  // ── fromJson ──────────────────────────────────────────────────────────────
  factory VisitItemModel.fromJson(Map<String, dynamic> json) {
    return VisitItemModel(
      visitId: json['Visit ID'] as int?,
      type: json['Type'] as String?,
      status: json['Status'] as String?,
      stage: json['Stage'] as String?,
      date: json['Date'] as String?,
      consultationFee: json['Consultation Fee'] as num?,
      doctor: json['Doctor'] as String?,
      createdAt: json['Created At'] as String?,
    );
  }

  // ── toJson ────────────────────────────────────────────────────────────────
  Map<String, dynamic> toJson() {
    return {
      'Visit ID': visitId,
      'Type': type,
      'Status': status,
      'Stage': stage,
      'Date': date,
      'Consultation Fee': consultationFee,
      'Doctor': doctor,
      'Created At': createdAt,
    };
  }

  // ── copyWith ──────────────────────────────────────────────────────────────
  VisitItemModel copyWith({
    int? visitId,
    String? type,
    String? status,
    String? stage,
    String? date,
    num? consultationFee,
    String? doctor,
    String? createdAt,
  }) {
    return VisitItemModel(
      visitId: visitId ?? this.visitId,
      type: type ?? this.type,
      status: status ?? this.status,
      stage: stage ?? this.stage,
      date: date ?? this.date,
      consultationFee: consultationFee ?? this.consultationFee,
      doctor: doctor ?? this.doctor,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  String toString() {
    return 'VisitItemModel(visitId: $visitId, type: $type, stage: $stage, doctor: $doctor)';
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// AllVisitsModel — wraps the full list
// ─────────────────────────────────────────────────────────────────────────────
class AllVisitsModel {
  final List<VisitItemModel> visits;

  AllVisitsModel({required this.visits});

  // ── Helpers ───────────────────────────────────────────────────────────────
  bool get isEmpty => visits.isEmpty;
  int get totalCount => visits.length;

  List<VisitItemModel> get consultations =>
      visits.where((v) => v.isConsultation).toList();

  List<VisitItemModel> get packageSessions =>
      visits.where((v) => v.isPackageSession).toList();

  List<VisitItemModel> get completedVisits =>
      visits.where((v) => v.isCompleted).toList();

  // ── fromJson — parses a JSON array ───────────────────────────────────────
  factory AllVisitsModel.fromJson(List<dynamic> jsonList) {
    final List<VisitItemModel> parsed = jsonList
        .whereType<Map<String, dynamic>>()
        .map((e) => VisitItemModel.fromJson(e))
        .toList();
    return AllVisitsModel(visits: parsed);
  }

  // ── toJson — returns a JSON array ─────────────────────────────────────────
  List<Map<String, dynamic>> toJson() {
    return visits.map((v) => v.toJson()).toList();
  }

  @override
  String toString() {
    return 'AllVisitsModel(totalCount: $totalCount)';
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// USAGE EXAMPLE
// ─────────────────────────────────────────────────────────────────────────────
//
//  import 'dart:convert';
//
//  final List<dynamic> rawList = jsonDecode(response.body);
//  final AllVisitsModel allVisits = AllVisitsModel.fromJson(rawList);
//
//  // Safe usage — never crashes:
//  print(allVisits.totalCount);                          // 2
//  print(allVisits.isEmpty);                             // false
//  print(allVisits.consultations.length);                // 1
//  print(allVisits.packageSessions.length);              // 1
//
//  final VisitItemModel first = allVisits.visits[0];
//  print(first.displayDoctor);                           // "DR ARSALAN JAMIL"
//  print(first.displayConsultationFee);                  // "No data" (was null)
//  print(first.displayStatus);                           // "No data" (was "")
//  print(first.isCompleted);                             // true
//  print(first.hasFee);                                  // false
//
//  // Back to JSON:
//  final List<Map<String, dynamic>> backToJson = allVisits.toJson();
// ─────────────────────────────────────────────────────────────────────────────
