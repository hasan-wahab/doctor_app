import 'package:doctor_app/core/extentions/context_extentions.dart';
import 'package:doctor_app/data/models/all_visits_model.dart';
import 'package:doctor_app/data/models/reviews_question_model.dart';
import 'package:doctor_app/widgets/app_button.dart';
import 'package:doctor_app/widgets/app_app_bar.dart';
import 'package:doctor_app/widgets/custom_text.dart';
import 'package:doctor_app/widgets/date_time_foemat.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/app_keys/api_keys.dart';
import '../../core/app_styles/app_colors.dart';
import '../../core/app_styles/app_sizes.dart';
import '../../core/app_styles/app_text_styles.dart';
import '../../data/models/post_review_model.dart';
import '../../widgets/app_pull_refresh.dart';
import '../../widgets/show_msg.dart';
import 'bloc/visit_detail_bloc.dart';
import 'bloc/visit_detail_event.dart';
import 'bloc/visit_detail_state.dart';
import 'visits_shimmer.dart';

/// ======================
/// ANSWER MODEL
/// ======================
class AnswerModel {
  int rating;
  List<bool> selectedOptions;
  TextEditingController controller;

  AnswerModel({
    this.rating = 0,
    required this.selectedOptions,
    required this.controller,
  });
}

/// ======================
/// SCREEN
/// ======================
class VisitsDetailScreen extends StatefulWidget {
  const VisitsDetailScreen({super.key});

  @override
  State<VisitsDetailScreen> createState() => _VisitsDetailScreenState();
}

class _VisitsDetailScreenState extends State<VisitsDetailScreen> {
  String? message;
  AllVisitsModel? allVisitsModel;
  List<QuestionModel>? questionModel;

  Map<int, Map<int, AnswerModel>> answers = {};
  List<bool> isExpended = [];

  bool isLoading = false;
  bool isRefreshing = false;
  final String token = '';

  @override
  void initState() {
    context.read<VisitDetailBloc>().add(VisitDetailApiAndLocalEvent());
    super.initState();
  }

  void _sortVisitsOldestFirst() {
    if (allVisitsModel == null) return;
    final visits = List<VisitItemModel>.from(allVisitsModel!.visits);
    visits.sort((a, b) {
      final dateA =
          DateTime.tryParse(a.date ?? '') ??
          DateTime.fromMillisecondsSinceEpoch(0);
      final dateB =
          DateTime.tryParse(b.date ?? '') ??
          DateTime.fromMillisecondsSinceEpoch(0);
      return dateA.compareTo(dateB);
    });
    allVisitsModel = AllVisitsModel(visits: visits);
  }

  bool _isVisitExpanded(int visitIndex) {
    return visitIndex >= 0 &&
        visitIndex < isExpended.length &&
        isExpended[visitIndex];
  }

  void _setVisitExpanded(int visitIndex, bool value) {
    if (visitIndex < 0 || visitIndex >= isExpended.length) return;
    isExpended[visitIndex] = value;
  }

  /// Categories for this visit, based on Assessments.Done flags:
  /// - Consultant Assessment Done → consultation questions
  /// - Reconsultation Assessment Done → reconsultation questions
  /// - Therapist Sessions Done → therapist questions
  /// Show every category whose Done is true (categorized).
  List<String> _questionCategoriesForVisit(int visitIndex) {
    final assessments = allVisitsModel!.visits[visitIndex].assessments;
    final categories = <String>[];

    if (assessments?.consultantAssessment?.isDone == true) {
      categories.add('consultation');
    }
    if (assessments?.reconsultationAssessment?.isDone == true) {
      categories.add('reconsultation');
    }
    if (assessments?.therapistSessions?.isDone == true) {
      categories.add('therapist');
    }

    return categories;
  }

  List<QuestionModel> _questionsForVisit(int visitIndex) {
    if (questionModel == null) return [];
    final categories = _questionCategoriesForVisit(visitIndex);
    if (categories.isEmpty) return [];

    final filtered = questionModel!
        .where(
          (q) =>
              q.isActive &&
              categories.contains(q.category.toLowerCase().trim()),
        )
        .toList();

    // Keep category order same as assessment rule order, then sortOrder.
    filtered.sort((a, b) {
      final aCat = a.category.toLowerCase().trim();
      final bCat = b.category.toLowerCase().trim();
      final aIdx = categories.indexOf(aCat);
      final bIdx = categories.indexOf(bCat);
      if (aIdx != bIdx) return aIdx.compareTo(bIdx);
      return a.sortOrder.compareTo(b.sortOrder);
    });
    return filtered;
  }

  /// Categories that already have at least one posted answer.
  /// Once any question in a category is reviewed, that whole category is closed
  /// for further edit (remaining questions in it are not shown again).
  Set<String> _postedReviewCategories(int visitIndex) {
    final visit = allVisitsModel!.visits[visitIndex];
    final posted = <String>{};
    if (questionModel == null) return posted;

    final idToCategory = <int, String>{
      for (final q in questionModel!) q.id: q.category.toLowerCase().trim(),
    };

    for (final a in visit.review?.answers ?? []) {
      final id = a.questionId;
      if (id == null) continue;
      final category = idToCategory[id];
      if (category != null && category.isNotEmpty) {
        posted.add(category);
      }
    }
    return posted;
  }

  /// Questions the user can still answer:
  /// - Done=true categories only
  /// - If review exists: only categories with zero posted answers yet
  ///   (e.g. therapist already reviewed → skip leftover therapist questions;
  ///    when reconsultation Done → show only reconsultation)
  List<QuestionModel> _questionsForInput(int visitIndex) {
    final allDoneQuestions = _questionsForVisit(visitIndex);
    if (allDoneQuestions.isEmpty) return [];

    final visit = allVisitsModel!.visits[visitIndex];
    if (!visit.hasReview) return allDoneQuestions;

    final postedCategories = _postedReviewCategories(visitIndex);
    return allDoneQuestions
        .where(
          (q) => !postedCategories.contains(q.category.toLowerCase().trim()),
        )
        .toList();
  }

  String _categoryTitle(String category) {
    switch (category.toLowerCase().trim()) {
      case 'consultation':
        return 'Consultation Questions';
      case 'reconsultation':
        return 'Reconsultation Questions';
      case 'therapist':
        return 'Therapist Questions';
      default:
        return '${category.toSentenceCase} Questions';
    }
  }

  String _categorySubtitle(String category) {
    switch (category.toLowerCase().trim()) {
      case 'consultation':
        return 'Please share your immediate treatment feedback';
      case 'reconsultation':
        return 'Please share your follow-up treatment feedback';
      case 'therapist':
        return 'Evaluation of therapist attention & clinic care';
      default:
        return 'Please share your feedback';
    }
  }

  String _displayAmount(String fee) {
    final trimmed = fee.trim();
    if (trimmed.isEmpty || trimmed == 'No data') return fee;
    if (trimmed.toLowerCase().startsWith('rs')) return trimmed;
    final parsed = num.tryParse(trimmed.replaceAll(',', ''));
    if (parsed == null) return 'Rs. $trimmed';
    final digits = parsed.round().toString();
    final buffer = StringBuffer();
    for (var i = 0; i < digits.length; i++) {
      final remaining = digits.length - i;
      if (i > 0 && remaining % 3 == 0) buffer.write(',');
      buffer.write(digits[i]);
    }
    return 'Rs. $buffer';
  }

  Widget _buildQuestionInput({
    required QuestionModel q,
    required AnswerModel ans,
    required int number,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          maxLines: 10,
          text: '$number. ${q.questionText.toSentenceCase}',
          style: AppTextStyles.body.copyWith(
            color: AppColors.primaryColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: AppSizes.spaceMd),
        if (q.type == 'rating')
          _StarRating(
            rating: ans.rating,
            onChanged: (value) {
              setState(() {
                ans.rating = value;
              });
            },
          )
        else if (q.type == 'options')
          _OptionPills(
            options: q.options,
            isSelected: (i) => ans.selectedOptions[i],
            onToggle: (i) {
              setState(() {
                ans.selectedOptions[i] = !ans.selectedOptions[i];
              });
            },
          )
        else
          TextField(
            controller: ans.controller,
            maxLines: 3,
            style: AppTextStyles.body,
            decoration: InputDecoration(
              hintText: 'Write feedback...',
              hintStyle: AppTextStyles.bodySmall,
              filled: true,
              fillColor: AppColors.bgColor,
              contentPadding: EdgeInsets.symmetric(
                horizontal: AppSizes.fieldPaddingH,
                vertical: AppSizes.fieldPaddingV,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSizes.radiusSm),
                borderSide: BorderSide(color: AppColors.borderColor),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSizes.radiusSm),
                borderSide: BorderSide(color: AppColors.borderColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSizes.radiusSm),
                borderSide: BorderSide(color: AppColors.primaryColor),
              ),
            ),
          ),
      ],
    );
  }

  Widget _numberedBlock({required String title, required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(maxLines: 10, text: title, style: AppTextStyles.bodySmall),
        SizedBox(height: AppSizes.spaceXs),
        child,
      ],
    );
  }

  Widget _submittedAnswerView({
    required ReviewAnswerModel item,
    required QuestionModel? question,
  }) {
    final type = (question?.type ?? '').toLowerCase();
    final answerText = item.displayAnswer;
    final ratingValue = int.tryParse(answerText.trim()) ?? 0;
    final isRating =
        type == 'rating' ||
        (type.isEmpty && ratingValue >= 1 && ratingValue <= 5);

    if (isRating) {
      return _StarRating(rating: ratingValue);
    }
    return CustomText(
      maxLines: 10,
      text: answerText.toSentenceCase,
      style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w600),
    );
  }

  Widget? _sectionCards(List<Widget> cards) {
    if (cards.isEmpty) return null;
    return Column(
      children: [
        for (var i = 0; i < cards.length; i++) ...[
          if (i > 0) SizedBox(height: AppSizes.spaceXxl),
          cards[i],
        ],
      ],
    );
  }

  /// Submitted answers only — always visible, same as the old flow.
  Widget? _buildSubmittedReviewCards(VisitItemModel visit) {
    final review = visit.review;
    if (review == null) return null;

    QuestionModel? questionFor(ReviewAnswerModel item) {
      if (questionModel == null || item.questionId == null) return null;
      for (final q in questionModel!) {
        if (q.id == item.questionId) return q;
      }
      return null;
    }

    bool answerLooksLikeRating(ReviewAnswerModel item) {
      final question = questionFor(item);
      final type = (question?.type ?? '').toLowerCase();
      final ratingValue = int.tryParse(item.displayAnswer.trim());
      return type == 'rating' ||
          (ratingValue != null && ratingValue >= 1 && ratingValue <= 5);
    }

    final reviewAnswers = review.answers ?? [];
    final hasRatingInAnswers = reviewAnswers.any(answerLooksLikeRating);
    final hasTextInAnswers = reviewAnswers.any((item) {
      final type = (questionFor(item)?.type ?? '').toLowerCase();
      return type == 'text' ||
          type.contains('comment') ||
          type.contains('feedback');
    });

    const preferredOrder = ['consultation', 'reconsultation', 'therapist'];
    final cards = <Widget>[];

    final legacyItems = <Widget>[];
    if (review.rating != null && !hasRatingInAnswers) {
      legacyItems.add(
        _numberedBlock(
          title: '1. Rating',
          child: _StarRating(rating: review.rating!),
        ),
      );
    }
    if ((review.comment ?? '').trim().isNotEmpty && !hasTextInAnswers) {
      legacyItems.add(
        _numberedBlock(
          title: '${legacyItems.isEmpty ? 1 : 2}. Comment',
          child: CustomText(
            maxLines: 10,
            text: visit.displayComment,
            style: AppTextStyles.body,
          ),
        ),
      );
    }
    if (legacyItems.isNotEmpty) {
      cards.add(
        _SectionCard(
          title: 'REVIEW',
          subtitle: 'Your submitted feedback',
          submitted: true,
          items: legacyItems,
        ),
      );
    }

    final grouped = <String, List<ReviewAnswerModel>>{};
    for (final item in reviewAnswers) {
      final category = (questionFor(item)?.category ?? '').toLowerCase().trim();
      final key = category.isEmpty ? 'other' : category;
      grouped.putIfAbsent(key, () => []).add(item);
    }

    final sortedCategories = grouped.keys.toList()
      ..sort((a, b) {
        final aIdx = preferredOrder.indexOf(a);
        final bIdx = preferredOrder.indexOf(b);
        final aOrder = aIdx == -1 ? preferredOrder.length : aIdx;
        final bOrder = bIdx == -1 ? preferredOrder.length : bIdx;
        if (aOrder != bOrder) return aOrder.compareTo(bOrder);
        return a.compareTo(b);
      });

    for (final category in sortedCategories) {
      final items = <Widget>[];
      var number = 1;
      for (final item in grouped[category]!) {
        final question = questionFor(item);
        final title = (item.question ?? question?.questionText ?? 'Answer')
            .toSentenceCase;
        items.add(
          _numberedBlock(
            title: '$number. $title',
            child: _submittedAnswerView(item: item, question: question),
          ),
        );
        number++;
      }
      cards.add(
        _SectionCard(
          title: category == 'other'
              ? 'OTHER'
              : _categoryTitle(category).toUpperCase(),
          subtitle: 'Your submitted feedback',
          submitted: true,
          items: items,
        ),
      );
    }

    return _sectionCards(cards);
  }

  /// Pending questions — only after Give Feedback, same as the old flow.
  Widget? _buildPendingQuestionCards({
    required int visitIndex,
    required List<QuestionModel> pendingQuestions,
  }) {
    final visitAnswerMap = answers[visitIndex];
    if (visitAnswerMap == null || pendingQuestions.isEmpty) return null;

    final ordered = <String>[];
    final indexesByCategory = <String, List<int>>{};

    for (
      var questionIndex = 0;
      questionIndex < pendingQuestions.length;
      questionIndex++
    ) {
      if (visitAnswerMap[questionIndex] == null) continue;
      final category = pendingQuestions[questionIndex].category
          .toLowerCase()
          .trim();
      if (!indexesByCategory.containsKey(category)) {
        ordered.add(category);
        indexesByCategory[category] = [];
      }
      indexesByCategory[category]!.add(questionIndex);
    }

    final cards = <Widget>[];
    var questionNumber = 1;
    for (final category in ordered) {
      final indexes = indexesByCategory[category]!;
      final items = <Widget>[];
      for (final questionIndex in indexes) {
        items.add(
          _buildQuestionInput(
            q: pendingQuestions[questionIndex],
            ans: visitAnswerMap[questionIndex]!,
            number: questionNumber++,
          ),
        );
      }
      cards.add(
        _SectionCard(
          title: _categoryTitle(category).toUpperCase(),
          subtitle: _categorySubtitle(category),
          items: items,
        ),
      );
    }

    return _sectionCards(cards);
  }

  /// ======================
  /// INIT ANSWERS
  /// ======================
  void initAnswers() {
    answers.clear();
    isExpended = List.generate(allVisitsModel!.visits.length, (_) => false);

    for (var i = 0; i < allVisitsModel!.visits.length; i++) {
      answers[i] = {};
      final visitQuestions = _questionsForInput(i);

      for (var j = 0; j < visitQuestions.length; j++) {
        answers[i]![j] = AnswerModel(
          rating: 0,
          selectedOptions: List.generate(
            visitQuestions[j].options.length,
            (_) => false,
          ),
          controller: TextEditingController(),
        );
      }
    }
  }

  /// ======================
  /// SUBMIT DATA
  /// ======================
  /// Returns `true` when review was submitted; `false` when blocked by validation.
  /// Create (POST) when no review yet; edit (PUT) when adding answers for newly
  /// Done categories — previous answers are merged into the same payload.
  Future<bool> submitData(int visitIndex) async {
    final visitAnswers = answers[visitIndex]!;
    final visitQuestions = _questionsForInput(visitIndex);
    final visit = allVisitsModel!.visits[visitIndex];
    final existingReview = visit.review;
    final isEdit = visit.hasReview && existingReview?.reviewId != null;

    // Top-level rating/comment: first filled values (API schema).
    // Every answered question also goes into answers[] with question_id.
    int? rating;
    String? comment;
    List<Answers> newAnswersList = [];

    final sortedIndexes = visitAnswers.keys.toList()..sort();

    for (final questionIndex in sortedIndexes) {
      if (questionIndex >= visitQuestions.length) continue;
      final ans = visitAnswers[questionIndex]!;
      final q = visitQuestions[questionIndex];
      final type = q.type.toLowerCase();

      if (type == 'rating') {
        if (ans.rating <= 0) continue;
        rating ??= ans.rating;
        newAnswersList.add(
          Answers(questionId: q.id, answer: ans.rating.toString()),
        );
      } else if (type == 'text' ||
          type.contains('comment') ||
          type.contains('feedback')) {
        final text = ans.controller.text.trim();
        if (text.isEmpty) continue;
        comment ??= text;
        newAnswersList.add(Answers(questionId: q.id, answer: text));
      } else if (type == 'options') {
        for (int i = 0; i < ans.selectedOptions.length; i++) {
          if (ans.selectedOptions[i]) {
            newAnswersList.add(Answers(questionId: q.id, answer: q.options[i]));
          }
        }
      }
    }

    final hasAnyAnswer =
        rating != null ||
        (comment != null && comment.trim().isNotEmpty) ||
        newAnswersList.isNotEmpty;

    if (!hasAnyAnswer) {
      AppMsg.showSnackBar(
        context,
        message: 'Please answer at least one question before submitting.',
      );
      return false;
    }

    List<Answers> answersList = newAnswersList;
    if (isEdit) {
      final merged = <Answers>[];
      for (final a in existingReview!.answers ?? []) {
        if (a.questionId == null) continue;
        final answerText = (a.answer ?? '').trim();
        if (answerText.isEmpty) continue;
        merged.add(Answers(questionId: a.questionId, answer: answerText));
      }
      merged.addAll(newAnswersList);
      answersList = merged;
    }

    final postModel = PostReviewModel(
      visitId: visit.visitId,
      rating: rating ?? existingReview?.rating,
      comment: (comment != null && comment.trim().isNotEmpty)
          ? comment
          : existingReview?.comment,
      options: answersList,
    );

    final reviewId = isEdit ? existingReview!.reviewId : null;
    if (kDebugMode) {
      print('========== VISIT REVIEW DEBUG ==========');
      print('visit_id        : ${visit.visitId}');
      print('hasReview       : ${visit.hasReview}');
      print('existingReviewId: ${existingReview?.reviewId}');
      print(
        'action          : ${isEdit ? "EDIT (PUT)" : "SUBMIT / CREATE (POST)"}',
      );
      if (isEdit) {
        print('API             : PUT ${ApiKeys.editReviewKey(reviewId!)}');
        print('EDITED REVIEW   : reviewId=$reviewId');
      } else {
        print('API             : POST ${ApiKeys.postReviewKey}');
        print('SUBMITTED REVIEW: new create (no reviewId yet)');
      }
      print(
        'pending categories questions: ${visitQuestions.map((q) => "${q.id}:${q.category}").toList()}',
      );
      print('new answers count : ${newAnswersList.length}');
      print('payload answers   : ${answersList.length}');
      print('body             : ${postModel.toJson()}');
      print('========================================');
    }

    context.read<VisitDetailBloc>().add(
      ReviewSubmitEvent(postReviewModel: postModel, reviewId: reviewId),
    );
    return true;
  }

  Widget _buildVisitInfo(VisitItemModel visit) {
    final status = visit.displayStatus;
    final showStatus =
        status.isNotEmpty &&
        status != 'No data' &&
        status.toLowerCase() != visit.displayStage.toLowerCase();

    return Column(
      children: [
        _VisitInfoRow(
          label: 'Date',
          value: DateAndTimeFormater.dateFormat(visit.displayDate),
        ),
        SizedBox(height: AppSizes.spaceSm),
        _VisitInfoRow(label: 'Type', value: visit.displayType),
        SizedBox(height: AppSizes.spaceSm),
        _VisitInfoRow(
          label: 'Doctor',
          value: visit.displayDoctor,
          valueStyle: AppTextStyles.name,
        ),
        SizedBox(height: AppSizes.spaceSm),
        _VisitInfoRow(
          label: 'Stage',
          trailing: _StageChip(label: visit.displayStage),
        ),
        if (showStatus) ...[
          SizedBox(height: AppSizes.spaceSm),
          _VisitInfoRow(label: 'Status', value: status),
        ],
        SizedBox(height: AppSizes.spaceSm),
        _VisitInfoRow(
          label: 'Amount',
          value: _displayAmount(visit.displayConsultationFee),
          valueStyle: AppTextStyles.name.copyWith(
            color: AppColors.primaryColor,
          ),
        ),
        SizedBox(height: AppSizes.spaceMd),
        Divider(color: AppColors.borderColor, height: 1),
      ],
    );
  }

  Widget _buildVisitItem({
    required int visitIndex,
    required VisitItemModel visit,
  }) {
    final pendingQuestions = _questionsForInput(visitIndex);
    final expanded = _isVisitExpanded(visitIndex);
    final submittedCards = visit.hasReview
        ? _buildSubmittedReviewCards(visit)
        : null;
    final pendingCards = expanded && pendingQuestions.isNotEmpty
        ? _buildPendingQuestionCards(
            visitIndex: visitIndex,
            pendingQuestions: pendingQuestions,
          )
        : null;

    return _VisitSurfaceCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildVisitInfo(visit),
          if (submittedCards != null) ...[
            SizedBox(height: AppSizes.spaceXxl),
            submittedCards,
          ],
          if (pendingCards != null) ...[
            SizedBox(height: AppSizes.spaceXxl),
            pendingCards,
          ],
          if (pendingQuestions.isNotEmpty) ...[
            SizedBox(height: AppSizes.spaceXxl),
            AppButton(
              onTap: () async {
                // Collapsed → only expand (stay open).
                if (!_isVisitExpanded(visitIndex)) {
                  setState(() {
                    _setVisitExpanded(visitIndex, true);
                  });
                  return;
                }

                await submitData(visitIndex);
              },
              borderRadius: BorderRadius.circular(AppSizes.radiusSm),
              text: expanded
                  ? (visit.hasReview ? 'Update Review' : 'Submit')
                  : 'Give Feedback',
            ),
          ] else if (!visit.hasReview) ...[
            SizedBox(height: AppSizes.spaceXxl),
            CustomText(
              text: 'No feedback available for this visit yet.',
              style: AppTextStyles.body.copyWith(color: AppColors.primaryColor),
              maxLines: 3,
            ),
          ],
        ],
      ),
    );
  }

  Widget _emptyState() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: AppSizes.pageInsets,
          children: [
            SizedBox(
              height: constraints.maxHeight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    text: message == 'No internet connection!'
                        ? message!
                        : 'No visits found',
                    style: AppTextStyles.body.copyWith(
                      color: AppColors.primaryColor,
                    ),
                  ),
                  SizedBox(height: AppSizes.spaceMd),
                  AppBarRefreshButton(onTap: _requestFirstLoad),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  void _requestFirstLoad() {
    context.read<VisitDetailBloc>().add(VisitDetailApiAndLocalEvent());
  }

  Future<void> _onRefresh() async {
    final bloc = context.read<VisitDetailBloc>();
    final done = bloc.stream.firstWhere(
      (state) =>
          state is AllVisitDatilsListState || state is VisitDetailMessageState,
    );
    bloc.add(VisitDetailJustFromServerEvent());
    await done;
  }

  /// ======================
  /// UI
  /// ======================
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VisitDetailBloc, VisitDetailState>(
      listener: (context, state) {
        if (state is VisitDetailLoadingState) {
          if (allVisitsModel == null) {
            isLoading = true;
          } else {
            isRefreshing = true;
          }
        } else {
          isLoading = false;
          isRefreshing = false;
        }

        if (state is VisitDetailMessageState) {
          message = state.message.toString();
          AppMsg.showSnackBar(context, message: state.message.toString());
        }

        if (state is AllVisitDatilsListState) {
          allVisitsModel = state.model;
          questionModel = state.question;
          _sortVisitsOldestFirst();
          initAnswers();
        }
      },
      builder: (context, state) {
        final firstLoad = isLoading && allVisitsModel == null;
        final appBarLoading = isLoading || isRefreshing;
        final visits = allVisitsModel?.visits ?? const <VisitItemModel>[];

        return Scaffold(
          backgroundColor: AppColors.screenBgColor,
          appBar: AppAppBar(
            title: 'My visit',
            showBack: true,
            isLoading: appBarLoading,
            actions: [
              AppBarRefreshButton(onTap: appBarLoading ? null : _onRefresh),
            ],
          ),
          body: firstLoad
              ? const VisitsShimmer()
              : Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: AppSizes.contentMaxWidth(context),
                    ),
                    child: AppPullRefresh(
                      enabled: !appBarLoading,
                      onRefresh: _onRefresh,
                      child: visits.isEmpty
                          ? _emptyState()
                          : ListView.separated(
                              physics: const AlwaysScrollableScrollPhysics(),
                              padding: AppSizes.pageInsets,
                              itemCount: visits.length,
                              separatorBuilder: (_, _) =>
                                  SizedBox(height: AppSizes.spaceXxl),
                              itemBuilder: (context, displayIndex) {
                                // Display newest first; review rules still use
                                // chronological index (oldest = visit 1).
                                final visitIndex =
                                    visits.length - 1 - displayIndex;
                                return _buildVisitItem(
                                  visitIndex: visitIndex,
                                  visit: visits[visitIndex],
                                );
                              },
                            ),
                    ),
                  ),
                ),
        );
      },
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.title,
    required this.subtitle,
    required this.items,
    this.submitted = false,
  });

  final String title;
  final String subtitle;
  final List<Widget> items;
  final bool submitted;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: submitted ? AppColors.secondaryColor : AppColors.screenBgColor,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.radiusSm),
        side: BorderSide(
          color: submitted ? AppColors.primaryColor : AppColors.borderColor,
        ),
      ),
      child: Padding(
        padding: AppSizes.cardInsets,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: CustomText(text: title, style: AppTextStyles.name),
                ),
                if (submitted) ...[
                  SizedBox(width: AppSizes.gapSm),
                  Icon(
                    Icons.check_circle_rounded,
                    size: AppSizes.iconSm,
                    color: AppColors.primaryColor,
                  ),
                  SizedBox(width: AppSizes.gapSm),
                  CustomText(
                    text: 'Submitted',
                    style: AppTextStyles.chipPrimary,
                  ),
                ],
              ],
            ),
            SizedBox(height: AppSizes.spaceXs),
            CustomText(
              text: submitted ? 'This review has been submitted' : subtitle,
              style: AppTextStyles.bodySmall,
              maxLines: 3,
            ),
            SizedBox(height: AppSizes.spaceMd),
            for (var i = 0; i < items.length; i++) ...[
              if (i > 0) SizedBox(height: AppSizes.spaceXl),
              items[i],
            ],
          ],
        ),
      ),
    );
  }
}

class _VisitSurfaceCard extends StatelessWidget {
  const _VisitSurfaceCard({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.bgColor,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.radiusMd),
        side: BorderSide(color: AppColors.borderColor),
      ),
      child: Padding(padding: AppSizes.cardInsets, child: child),
    );
  }
}

class _VisitInfoRow extends StatelessWidget {
  const _VisitInfoRow({
    required this.label,
    this.value,
    this.valueStyle,
    this.trailing,
  });

  final String label;
  final String? value;
  final TextStyle? valueStyle;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: CustomText(text: label, style: AppTextStyles.bodySmall),
        ),
        SizedBox(width: AppSizes.gapMd),
        if (trailing != null)
          trailing!
        else
          Flexible(
            child: CustomText(
              text: value ?? '',
              style: valueStyle ?? AppTextStyles.body,
              align: TextAlign.right,
              maxLines: 3,
            ),
          ),
      ],
    );
  }
}

class _StageChip extends StatelessWidget {
  const _StageChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final isComplete = label.toLowerCase().contains('complete');
    final color = isComplete ? AppColors.success : AppColors.primaryColor;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.gapMd,
        vertical: AppSizes.spaceXs,
      ),
      decoration: BoxDecoration(
        color: isComplete
            ? AppColors.success.withValues(alpha: 0.12)
            : AppColors.secondaryColor,
        borderRadius: BorderRadius.circular(AppSizes.radiusLg),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: AppSizes.spaceXs,
            height: AppSizes.spaceXs,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          SizedBox(width: AppSizes.gapSm),
          CustomText(
            text: label,
            style: AppTextStyles.chipPrimary.copyWith(color: color),
          ),
        ],
      ),
    );
  }
}

class _StarRating extends StatelessWidget {
  const _StarRating({required this.rating, this.onChanged});

  final int rating;
  final ValueChanged<int>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(5, (i) {
        final filled = rating > i;
        final star = Icon(
          filled ? Icons.star_rounded : Icons.star_border_rounded,
          color: filled ? AppColors.warning : AppColors.mutedTextColor,
          size: AppSizes.iconLg,
        );
        if (onChanged == null) return star;
        return InkWell(
          onTap: () => onChanged!(i + 1),
          borderRadius: BorderRadius.circular(AppSizes.radiusSm),
          child: star,
        );
      }),
    );
  }
}

class _OptionPills extends StatelessWidget {
  const _OptionPills({
    required this.options,
    required this.isSelected,
    this.onToggle,
  });

  final List<String> options;
  final bool Function(int index) isSelected;
  final ValueChanged<int>? onToggle;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Wrap(
          spacing: AppSizes.gapSm,
          runSpacing: AppSizes.spaceSm,
          children: List.generate(options.length, (i) {
            return ConstrainedBox(
              constraints: BoxConstraints(maxWidth: constraints.maxWidth),
              child: _OptionPill(
                text: options[i].toSentenceCase,
                selected: isSelected(i),
                onTap: onToggle == null ? null : () => onToggle!(i),
              ),
            );
          }),
        );
      },
    );
  }
}

class _OptionPill extends StatelessWidget {
  const _OptionPill({required this.text, required this.selected, this.onTap});

  final String text;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(AppSizes.radiusSm);

    return Material(
      color: selected ? AppColors.primaryColor : AppColors.bgColor,
      shape: RoundedRectangleBorder(
        borderRadius: radius,
        side: selected
            ? BorderSide.none
            : BorderSide(color: AppColors.borderColor),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: radius,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppSizes.gapMd,
            vertical: AppSizes.spaceXs,
          ),
          child: CustomText(
            text: text,
            style:
                (selected
                        ? AppTextStyles.chipPrimary.copyWith(
                            color: AppColors.textWhiteColor,
                          )
                        : AppTextStyles.chipMuted)
                    .copyWith(fontWeight: FontWeight.w600),
            align: TextAlign.center,
            maxLines: 1,
          ),
        ),
      ),
    );
  }
}
