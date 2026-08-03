// ─────────────────────────────────────────────────────────────────────────────
// all_visits_model.dart
// Full null-safe model — fromJson / toJson
// App will NEVER crash on null fields
// ─────────────────────────────────────────────────────────────────────────────

String? _str(dynamic v) {
  if (v == null) return null;
  final s = v.toString().trim();
  return s.isEmpty ? null : s;
}

int? _int(dynamic v) {
  if (v == null) return null;
  if (v is int) return v;
  if (v is num) return v.toInt();
  return int.tryParse(v.toString());
}

num? _num(dynamic v) {
  if (v == null) return null;
  if (v is num) return v;
  return num.tryParse(v.toString());
}

bool? _bool(dynamic v) {
  if (v == null) return null;
  if (v is bool) return v;
  if (v is num) return v != 0;
  final s = v.toString().toLowerCase().trim();
  if (s == 'true' || s == '1' || s == 'yes') return true;
  if (s == 'false' || s == '0' || s == 'no') return false;
  return null;
}

// ─────────────────────────────────────────────────────────────────────────────
// Review Answer Model
// ─────────────────────────────────────────────────────────────────────────────
class ReviewAnswerModel {
  final int? questionId;
  final String? question;
  final String? answer;

  ReviewAnswerModel({this.questionId, this.question, this.answer});

  String get displayQuestion =>
      (question != null && question!.trim().isNotEmpty) ? question! : 'No data';

  String get displayAnswer =>
      (answer != null && answer!.trim().isNotEmpty) ? answer! : 'No data';

  factory ReviewAnswerModel.fromJson(Map<String, dynamic> json) {
    return ReviewAnswerModel(
      questionId: _int(json['Question ID']),
      question: _str(json['Question']),
      answer: _str(json['Answer']),
    );
  }

  Map<String, dynamic> toJson() {
    return {'Question ID': questionId, 'Question': question, 'Answer': answer};
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Review Model
// ─────────────────────────────────────────────────────────────────────────────
class ReviewModel {
  final int? reviewId;
  final int? rating;
  final String? comment;
  final String? submittedAt;
  final List<ReviewAnswerModel>? answers;

  ReviewModel({
    this.reviewId,
    this.rating,
    this.comment,
    this.submittedAt,
    this.answers,
  });

  String get displayRating => rating != null ? rating.toString() : 'No data';

  String get displayComment =>
      (comment != null && comment!.trim().isNotEmpty) ? comment! : 'No data';

  String get displaySubmittedAt =>
      (submittedAt != null && submittedAt!.trim().isNotEmpty)
      ? submittedAt!
      : 'No data';

  bool get hasAnswers => (answers ?? []).isNotEmpty;

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      reviewId: _int(json['Review ID']),
      rating: _int(json['Rating']),
      comment: _str(json['Comment']),
      submittedAt: _str(json['Submitted At']),
      answers: (json['Answers'] as List?)
          ?.whereType<Map>()
          .map((e) => ReviewAnswerModel.fromJson(Map<String, dynamic>.from(e)))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Review ID': reviewId,
      'Rating': rating,
      'Comment': comment,
      'Submitted At': submittedAt,
      'Answers': answers?.map((e) => e.toJson()).toList(),
    };
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Assessments — History Taker
// ─────────────────────────────────────────────────────────────────────────────
class HistoryTakerAssessmentModel {
  final bool? done;
  final int? amAssessmentId;
  final int? historyTakingId;

  HistoryTakerAssessmentModel({
    this.done,
    this.amAssessmentId,
    this.historyTakingId,
  });

  bool get isDone => done == true;

  factory HistoryTakerAssessmentModel.fromJson(Map<String, dynamic> json) {
    return HistoryTakerAssessmentModel(
      done: _bool(json['Done']),
      amAssessmentId: _int(json['AM Assessment ID']),
      historyTakingId: _int(json['History Taking ID']),
    );
  }

  Map<String, dynamic> toJson() => {
    'Done': done,
    'AM Assessment ID': amAssessmentId,
    'History Taking ID': historyTakingId,
  };
}

// ─────────────────────────────────────────────────────────────────────────────
// Assessments — Consultant
// ─────────────────────────────────────────────────────────────────────────────
class ConsultantAssessmentModel {
  final bool? done;
  final int? assessmentId;

  ConsultantAssessmentModel({this.done, this.assessmentId});

  bool get isDone => done == true;

  factory ConsultantAssessmentModel.fromJson(Map<String, dynamic> json) {
    return ConsultantAssessmentModel(
      done: _bool(json['Done']),
      assessmentId: _int(json['Assessment ID']),
    );
  }

  Map<String, dynamic> toJson() => {
    'Done': done,
    'Assessment ID': assessmentId,
  };
}

// ─────────────────────────────────────────────────────────────────────────────
// Assessments — Reconsultation
// ─────────────────────────────────────────────────────────────────────────────
class ReconsultationAssessmentModel {
  final bool? done;
  final int? assessmentId;

  ReconsultationAssessmentModel({this.done, this.assessmentId});

  bool get isDone => done == true;

  factory ReconsultationAssessmentModel.fromJson(Map<String, dynamic> json) {
    return ReconsultationAssessmentModel(
      done: _bool(json['Done']),
      assessmentId: _int(json['Assessment ID']),
    );
  }

  Map<String, dynamic> toJson() => {
    'Done': done,
    'Assessment ID': assessmentId,
  };
}

// ─────────────────────────────────────────────────────────────────────────────
// Assessments — Therapist Sessions
// ─────────────────────────────────────────────────────────────────────────────
class TherapistSessionsAssessmentModel {
  final bool? done;
  final int? totalSessions;

  TherapistSessionsAssessmentModel({this.done, this.totalSessions});

  bool get isDone => done == true;

  factory TherapistSessionsAssessmentModel.fromJson(Map<String, dynamic> json) {
    return TherapistSessionsAssessmentModel(
      done: _bool(json['Done']),
      totalSessions: _int(json['Total Sessions']),
    );
  }

  Map<String, dynamic> toJson() => {
    'Done': done,
    'Total Sessions': totalSessions,
  };
}

// ─────────────────────────────────────────────────────────────────────────────
// Assessments wrapper
// ─────────────────────────────────────────────────────────────────────────────
class VisitAssessmentsModel {
  final HistoryTakerAssessmentModel? historyTakerAssessment;
  final ConsultantAssessmentModel? consultantAssessment;
  final ReconsultationAssessmentModel? reconsultationAssessment;
  final TherapistSessionsAssessmentModel? therapistSessions;

  VisitAssessmentsModel({
    this.historyTakerAssessment,
    this.consultantAssessment,
    this.reconsultationAssessment,
    this.therapistSessions,
  });

  factory VisitAssessmentsModel.fromJson(Map<String, dynamic> json) {
    return VisitAssessmentsModel(
      historyTakerAssessment: json['History Taker Assessment'] is Map
          ? HistoryTakerAssessmentModel.fromJson(
              Map<String, dynamic>.from(
                json['History Taker Assessment'] as Map,
              ),
            )
          : null,
      consultantAssessment: json['Consultant Assessment'] is Map
          ? ConsultantAssessmentModel.fromJson(
              Map<String, dynamic>.from(json['Consultant Assessment'] as Map),
            )
          : null,
      reconsultationAssessment: json['Reconsultation Assessment'] is Map
          ? ReconsultationAssessmentModel.fromJson(
              Map<String, dynamic>.from(
                json['Reconsultation Assessment'] as Map,
              ),
            )
          : null,
      therapistSessions: json['Therapist Sessions'] is Map
          ? TherapistSessionsAssessmentModel.fromJson(
              Map<String, dynamic>.from(json['Therapist Sessions'] as Map),
            )
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'History Taker Assessment': historyTakerAssessment?.toJson(),
    'Consultant Assessment': consultantAssessment?.toJson(),
    'Reconsultation Assessment': reconsultationAssessment?.toJson(),
    'Therapist Sessions': therapistSessions?.toJson(),
  };
}

// ─────────────────────────────────────────────────────────────────────────────
// Invoice & Advance
// ─────────────────────────────────────────────────────────────────────────────
class InvoiceAdvanceModel {
  final int? invoiceId;
  final String? totalAmount;
  final String? status;
  final num? advancePaidAmount;

  InvoiceAdvanceModel({
    this.invoiceId,
    this.totalAmount,
    this.status,
    this.advancePaidAmount,
  });

  String get displayInvoiceId => invoiceId?.toString() ?? 'No data';

  String get displayTotalAmount =>
      (totalAmount != null && totalAmount!.trim().isNotEmpty)
      ? totalAmount!
      : 'No data';

  String get displayStatus =>
      (status != null && status!.trim().isNotEmpty) ? status! : 'No data';

  String get displayAdvancePaidAmount =>
      advancePaidAmount != null ? advancePaidAmount.toString() : 'No data';

  bool get isPaid => status?.toLowerCase().trim() == 'paid';

  factory InvoiceAdvanceModel.fromJson(Map<String, dynamic> json) {
    return InvoiceAdvanceModel(
      invoiceId: _int(json['Invoice ID']),
      totalAmount: _str(json['Total Amount']),
      status: _str(json['Status']),
      advancePaidAmount: _num(json['Advance Paid Amount']),
    );
  }

  Map<String, dynamic> toJson() => {
    'Invoice ID': invoiceId,
    'Total Amount': totalAmount,
    'Status': status,
    'Advance Paid Amount': advancePaidAmount,
  };
}

// ─────────────────────────────────────────────────────────────────────────────
// Visit Item Model
// ─────────────────────────────────────────────────────────────────────────────
class VisitItemModel {
  final int? visitId;
  final String? type;
  final String? status;
  final String? stage;
  final String? date;
  final num? consultationFee;
  final String? consultant;
  final String? historyTaker;
  final String? therapist;

  /// Legacy field — older API used "Doctor"
  final String? doctor;
  final String? createdAt;
  final VisitAssessmentsModel? assessments;
  final InvoiceAdvanceModel? invoiceAdvance;
  final ReviewModel? review;

  VisitItemModel({
    this.visitId,
    this.type,
    this.status,
    this.stage,
    this.date,
    this.consultationFee,
    this.consultant,
    this.historyTaker,
    this.therapist,
    this.doctor,
    this.createdAt,
    this.assessments,
    this.invoiceAdvance,
    this.review,
  });

  // ── Safe display getters — UI uses these ───────────────────────────────
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

  /// Prefer consultant, then legacy doctor, then therapist
  String get displayDoctor {
    final value = consultant ?? doctor ?? therapist;
    return (value != null && value.trim().isNotEmpty) ? value : 'No data';
  }

  String get displayConsultant {
    final value = consultant ?? doctor;
    return (value != null && value.trim().isNotEmpty) ? value : 'No data';
  }

  String get displayHistoryTaker {
    if (historyTaker == null || historyTaker!.trim().isEmpty) return 'No data';
    if (historyTaker!.toUpperCase() == 'N/A') return 'N/A';
    return historyTaker!;
  }

  String get displayTherapist =>
      (therapist != null && therapist!.trim().isNotEmpty)
      ? therapist!
      : 'No data';

  String get displayCreatedAt =>
      (createdAt != null && createdAt!.trim().isNotEmpty)
      ? createdAt!
      : 'No data';

  bool get hasReview => review != null;

  bool get hasInvoice => invoiceAdvance != null;

  String get displayRating => review?.displayRating ?? 'No data';

  String get displayComment => review?.displayComment ?? 'No data';

  // ── Helpers ─────────────────────────────────────────────────────────────
  bool get isConsultation => type?.toLowerCase() == 'consultation';

  bool get isPackageSession => type?.toLowerCase() == 'package session';

  bool get isCompleted => stage?.toLowerCase() == 'completed';

  bool get hasFee => consultationFee != null;

  // ── fromJson ────────────────────────────────────────────────────────────
  factory VisitItemModel.fromJson(Map<String, dynamic> json) {
    return VisitItemModel(
      visitId: _int(json['Visit ID']),
      type: _str(json['Type']),
      status: _str(json['Status']),
      stage: _str(json['Stage']),
      date: _str(json['Date']),
      consultationFee: _num(json['Consultation Fee']),
      consultant: _str(json['consultant'] ?? json['Consultant']),
      historyTaker: _str(json['History Taker']),
      therapist: _str(json['Therapist']),
      doctor: _str(json['Doctor']),
      createdAt: _str(json['Created At']),
      assessments: json['Assessments'] is Map
          ? VisitAssessmentsModel.fromJson(
              Map<String, dynamic>.from(json['Assessments'] as Map),
            )
          : null,
      invoiceAdvance: json['Invoice & Advance'] is Map
          ? InvoiceAdvanceModel.fromJson(
              Map<String, dynamic>.from(json['Invoice & Advance'] as Map),
            )
          : null,
      review: json['Review'] is Map
          ? ReviewModel.fromJson(
              Map<String, dynamic>.from(json['Review'] as Map),
            )
          : null,
    );
  }

  // ── toJson ──────────────────────────────────────────────────────────────
  Map<String, dynamic> toJson() {
    return {
      'Visit ID': visitId,
      'Type': type,
      'Status': status,
      'Stage': stage,
      'Date': date,
      'Consultation Fee': consultationFee,
      'consultant': consultant,
      'History Taker': historyTaker,
      'Therapist': therapist,
      'Doctor': doctor,
      'Created At': createdAt,
      'Assessments': assessments?.toJson(),
      'Invoice & Advance': invoiceAdvance?.toJson(),
      'Review': review?.toJson(),
    };
  }

  // ── copyWith ────────────────────────────────────────────────────────────
  VisitItemModel copyWith({
    int? visitId,
    String? type,
    String? status,
    String? stage,
    String? date,
    num? consultationFee,
    String? consultant,
    String? historyTaker,
    String? therapist,
    String? doctor,
    String? createdAt,
    VisitAssessmentsModel? assessments,
    InvoiceAdvanceModel? invoiceAdvance,
    ReviewModel? review,
  }) {
    return VisitItemModel(
      visitId: visitId ?? this.visitId,
      type: type ?? this.type,
      status: status ?? this.status,
      stage: stage ?? this.stage,
      date: date ?? this.date,
      consultationFee: consultationFee ?? this.consultationFee,
      consultant: consultant ?? this.consultant,
      historyTaker: historyTaker ?? this.historyTaker,
      therapist: therapist ?? this.therapist,
      doctor: doctor ?? this.doctor,
      createdAt: createdAt ?? this.createdAt,
      assessments: assessments ?? this.assessments,
      invoiceAdvance: invoiceAdvance ?? this.invoiceAdvance,
      review: review ?? this.review,
    );
  }

  @override
  String toString() {
    return 'VisitItemModel(visitId: $visitId, type: $type, stage: $stage, consultant: $consultant)';
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// All Visits Model
// ─────────────────────────────────────────────────────────────────────────────
class AllVisitsModel {
  final List<VisitItemModel> visits;

  AllVisitsModel({required this.visits});

  bool get isEmpty => visits.isEmpty;

  int get totalCount => visits.length;

  List<VisitItemModel> get consultations =>
      visits.where((v) => v.isConsultation).toList();

  List<VisitItemModel> get packageSessions =>
      visits.where((v) => v.isPackageSession).toList();

  List<VisitItemModel> get completedVisits =>
      visits.where((v) => v.isCompleted).toList();

  List<VisitItemModel> get withReviews =>
      visits.where((v) => v.hasReview).toList();

  factory AllVisitsModel.fromJson(List<dynamic> jsonList) {
    final List<VisitItemModel> parsed = jsonList
        .whereType<Map>()
        .map((e) => VisitItemModel.fromJson(Map<String, dynamic>.from(e)))
        .toList();

    return AllVisitsModel(visits: parsed);
  }

  List<Map<String, dynamic>> toJson() {
    return visits.map((v) => v.toJson()).toList();
  }

  @override
  String toString() {
    return 'AllVisitsModel(totalCount: $totalCount)';
  }
}
