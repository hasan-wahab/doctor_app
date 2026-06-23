// ─────────────────────────────────────────────────────────────────────────────
// all_visits_model.dart
// Full null-safe model — fromJson / toJson
// App will NEVER crash on null fields
// ─────────────────────────────────────────────────────────────────────────────

// ─────────────────────────────────────────────────────────────────────────────
// Review Answer Model
// ─────────────────────────────────────────────────────────────────────────────
class ReviewAnswerModel {
  final int? questionId;
  final String? question;
  final String? answer;

  ReviewAnswerModel({this.questionId, this.question, this.answer});

  // Display getters
  String get displayQuestion =>
      (question != null && question!.trim().isNotEmpty) ? question! : 'No data';

  String get displayAnswer =>
      (answer != null && answer!.trim().isNotEmpty) ? answer! : 'No data';

  factory ReviewAnswerModel.fromJson(Map<String, dynamic> json) {
    return ReviewAnswerModel(
      questionId: json['Question ID'] as int?,
      question: json['Question'] as String?,
      answer: json['Answer'] as String?,
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

  // Display getters
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
      reviewId: json['Review ID'] as int?,
      rating: json['Rating'] as int?,
      comment: json['Comment'] as String?,
      submittedAt: json['Submitted At'] as String?,
      answers: (json['Answers'] as List?)
          ?.whereType<Map<String, dynamic>>()
          .map((e) => ReviewAnswerModel.fromJson(e))
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
// Visit Item Model
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
  final ReviewModel? review; // ✅ NEW FIELD

  VisitItemModel({
    this.visitId,
    this.type,
    this.status,
    this.stage,
    this.date,
    this.consultationFee,
    this.doctor,
    this.createdAt,
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

  String get displayDoctor =>
      (doctor != null && doctor!.trim().isNotEmpty) ? doctor! : 'No data';

  String get displayCreatedAt =>
      (createdAt != null && createdAt!.trim().isNotEmpty)
      ? createdAt!
      : 'No data';

  // Review display helpers
  bool get hasReview => review != null;

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
      visitId: json['Visit ID'] as int?,
      type: json['Type'] as String?,
      status: json['Status'] as String?,
      stage: json['Stage'] as String?,
      date: json['Date'] as String?,
      consultationFee: json['Consultation Fee'] as num?,
      doctor: json['Doctor'] as String?,
      createdAt: json['Created At'] as String?,
      review: json['Review'] != null
          ? ReviewModel.fromJson(json['Review'])
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
      'Doctor': doctor,
      'Created At': createdAt,
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
    String? doctor,
    String? createdAt,
    ReviewModel? review,
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
      review: review ?? this.review,
    );
  }

  @override
  String toString() {
    return 'VisitItemModel(visitId: $visitId, type: $type, stage: $stage, doctor: $doctor)';
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

  // ── fromJson ────────────────────────────────────────────────────────────
  factory AllVisitsModel.fromJson(List<dynamic> jsonList) {
    final List<VisitItemModel> parsed = jsonList
        .whereType<Map<String, dynamic>>()
        .map((e) => VisitItemModel.fromJson(e))
        .toList();

    return AllVisitsModel(visits: parsed);
  }

  // ── toJson ──────────────────────────────────────────────────────────────
  List<Map<String, dynamic>> toJson() {
    return visits.map((v) => v.toJson()).toList();
  }

  @override
  String toString() {
    return 'AllVisitsModel(totalCount: $totalCount)';
  }
}
