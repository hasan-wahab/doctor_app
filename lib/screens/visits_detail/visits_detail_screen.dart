import 'package:doctor_app/core/extentions/context_extentions.dart';
import 'package:doctor_app/data/models/all_visits_model.dart';
import 'package:doctor_app/data/models/reviews_question_model.dart';
import 'package:doctor_app/widgets/app_button.dart';
import 'package:doctor_app/widgets/check_circle.dart';
import 'package:doctor_app/widgets/custom_text.dart';
import 'package:doctor_app/widgets/date_time_foemat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/app_styles/app_colors.dart';
import '../../data/models/post_review_model.dart';
import '../../widgets/row_text.dart';
import '../../widgets/show_msg.dart';
import 'bloc/visit_detail_bloc.dart';
import 'bloc/visit_detail_event.dart';
import 'bloc/visit_detail_state.dart';

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

  Widget _buildQuestionInput({
    required QuestionModel q,
    required AnswerModel ans,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10.h),
        CustomText(
          maxLines: 10,
          text: q.questionText.toSentenceCase,
          color: AppColors.primaryColor,
          fontWeight: FontWeight.bold,
        ),
        if (q.type == 'rating')
          Row(
            children: List.generate(
              5,
              (i) => InkWell(
                onTap: () {
                  setState(() {
                    ans.rating = i + 1;
                  });
                },
                child: Icon(
                  Icons.star,
                  color: ans.rating > i ? Colors.amber : Colors.grey,
                ),
              ),
            ),
          )
        else if (q.type == 'options')
          Wrap(
            spacing: 10,
            children: List.generate(q.options.length, (i) {
              return CheckCircle(
                text: q.options[i].toSentenceCase,
                isSelected: ans.selectedOptions[i],
                onChange: () {
                  setState(() {
                    ans.selectedOptions[i] = !ans.selectedOptions[i];
                  });
                },
              );
            }),
          )
        else
          TextField(
            controller: ans.controller,
            maxLines: 2,
            decoration: const InputDecoration(
              hintText: 'Write feedback...',
              border: OutlineInputBorder(),
            ),
          ),
      ],
    );
  }

  /// Groups questions by category and shows a section header for each.
  Widget _buildCategorizedQuestions({
    required int visitIndex,
    required List<QuestionModel> visitQuestions,
  }) {
    final visitAnswerMap = answers[visitIndex];
    if (visitAnswerMap == null) return const SizedBox.shrink();

    final widgets = <Widget>[];
    String? lastCategory;

    for (
      var questionIndex = 0;
      questionIndex < visitQuestions.length;
      questionIndex++
    ) {
      final q = visitQuestions[questionIndex];
      final ans = visitAnswerMap[questionIndex];
      if (ans == null) continue;

      final category = q.category.toLowerCase().trim();
      if (category != lastCategory) {
        lastCategory = category;
        widgets.add(
          Padding(
            padding: EdgeInsets.only(top: 8.h, bottom: 4.h),
            child: CustomText(
              text: _categoryTitle(category),
              color: AppColors.firstTextBlackColor,
              fontWeight: FontWeight.w800,
              fontSize: 15,
            ),
          ),
        );
      }

      widgets.add(_buildQuestionInput(q: q, ans: ans));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,
      children: widgets,
    );
  }

  /// ======================
  /// INIT ANSWERS
  /// ======================
  void initAnswers() {
    answers.clear();
    isExpended = List.generate(allVisitsModel!.visits.length, (_) => false);

    for (var i = 0; i < allVisitsModel!.visits.length; i++) {
      answers[i] = {};
      final visitQuestions = _questionsForVisit(i);

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
  Future<bool> submitData(int visitIndex) async {
    final visitAnswers = answers[visitIndex]!;
    final visitQuestions = _questionsForVisit(visitIndex);

    // Top-level rating/comment: first filled values (API schema).
    // Every answered question also goes into answers[] with question_id.
    int? rating;
    String? comment;
    List<Answers> answersList = [];

    final sortedIndexes = visitAnswers.keys.toList()..sort();

    for (final questionIndex in sortedIndexes) {
      if (questionIndex >= visitQuestions.length) continue;
      final ans = visitAnswers[questionIndex]!;
      final q = visitQuestions[questionIndex];
      final type = q.type.toLowerCase();

      if (type == 'rating') {
        if (ans.rating <= 0) continue;
        rating ??= ans.rating;
        answersList.add(
          Answers(questionId: q.id, answer: ans.rating.toString()),
        );
      } else if (type == 'text' ||
          type.contains('comment') ||
          type.contains('feedback')) {
        final text = ans.controller.text.trim();
        if (text.isEmpty) continue;
        comment ??= text;
        answersList.add(Answers(questionId: q.id, answer: text));
      } else if (type == 'options') {
        for (int i = 0; i < ans.selectedOptions.length; i++) {
          if (ans.selectedOptions[i]) {
            answersList.add(Answers(questionId: q.id, answer: q.options[i]));
          }
        }
      }
    }

    final hasAnyAnswer =
        rating != null ||
        (comment != null && comment.trim().isNotEmpty) ||
        answersList.isNotEmpty;

    if (!hasAnyAnswer) {
      AppMsg.showSnackBar(
        context,
        message: 'Please answer at least one question before submitting.',
      );
      return false;
    }

    final postModel = PostReviewModel(
      visitId: allVisitsModel!.visits[visitIndex].visitId,
      rating: rating,
      comment: comment,
      options: answersList,
    );
    context.read<VisitDetailBloc>().add(
      ReviewSubmitEvent(postReviewModel: postModel),
    );
    return true;
  }

  /// Shows top-level rating/comment (old reviews) + every answers[] row.
  Widget _buildSubmittedReview(VisitItemModel visit) {
    final review = visit.review;
    if (review == null) return const SizedBox.shrink();

    final reviewAnswers = review.answers ?? [];
    final widgets = <Widget>[];
    var rowNo = 1;

    bool answerLooksLikeRating(ReviewAnswerModel item) {
      QuestionModel? question;
      if (questionModel != null) {
        for (final q in questionModel!) {
          if (q.id == item.questionId) {
            question = q;
            break;
          }
        }
      }
      final type = (question?.type ?? '').toLowerCase();
      final ratingValue = int.tryParse(item.displayAnswer.trim());
      return type == 'rating' ||
          (ratingValue != null && ratingValue >= 1 && ratingValue <= 5);
    }

    final hasRatingInAnswers = reviewAnswers.any(answerLooksLikeRating);
    final hasTextInAnswers = reviewAnswers.any((item) {
      QuestionModel? question;
      if (questionModel != null) {
        for (final q in questionModel!) {
          if (q.id == item.questionId) {
            question = q;
            break;
          }
        }
      }
      final type = (question?.type ?? '').toLowerCase();
      return type == 'text' ||
          type.contains('comment') ||
          type.contains('feedback');
    });

    // Old reviews: rating only on top-level fields
    if (review.rating != null && !hasRatingInAnswers) {
      widgets.add(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              maxLines: 10,
              text: '$rowNo. Rating',
              color: AppColors.primaryColor,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(height: 4.h),
            Row(
              children: List.generate(
                5,
                (i) => Icon(
                  Icons.star,
                  color: review.rating! > i ? Colors.amber : Colors.grey,
                ),
              ),
            ),
          ],
        ),
      );
      rowNo++;
    }

    // Old reviews: comment only on top-level fields
    if ((review.comment ?? '').trim().isNotEmpty && !hasTextInAnswers) {
      widgets.add(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              maxLines: 10,
              text: '$rowNo. Comment',
              color: AppColors.primaryColor,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(height: 4.h),
            CustomText(maxLines: 10, text: visit.displayComment),
          ],
        ),
      );
      rowNo++;
    }

    for (final item in reviewAnswers) {
      QuestionModel? question;
      if (questionModel != null) {
        for (final q in questionModel!) {
          if (q.id == item.questionId) {
            question = q;
            break;
          }
        }
      }

      final type = (question?.type ?? '').toLowerCase();
      final title =
          (item.question ?? question?.questionText ?? 'Answer').toSentenceCase;
      final answerText = item.displayAnswer;
      final ratingValue = int.tryParse(answerText.trim()) ?? 0;
      final isRating =
          type == 'rating' ||
          (type.isEmpty && ratingValue >= 1 && ratingValue <= 5);

      widgets.add(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              maxLines: 10,
              text: '$rowNo. $title',
              color: AppColors.primaryColor,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(height: 4.h),
            if (isRating)
              Row(
                children: List.generate(
                  5,
                  (i) => Icon(
                    Icons.star,
                    color: ratingValue > i ? Colors.amber : Colors.grey,
                  ),
                ),
              )
            else
              CustomText(maxLines: 10, text: answerText.toSentenceCase),
          ],
        ),
      );
      rowNo++;
    }

    if (widgets.isEmpty) return const SizedBox.shrink();

    return Column(
      spacing: 12.h,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widgets,
    );
  }

  /// ======================
  /// UI
  /// ======================
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VisitDetailBloc, VisitDetailState>(
      listener: (context, state) {
        if (state is VisitDetailLoadingState) {
          isLoading = true;
        }

        if (state is VisitDetailMessageState) {
          isLoading = false;
          message = state.message.toString();
          AppMsg.showSnackBar(context, message: state.message.toString());
        }

        if (state is AllVisitDatilsListState) {
          isLoading = false;
          allVisitsModel = state.model;
          questionModel = state.question;
          _sortVisitsOldestFirst();
          initAnswers();
        }
      },
      builder: (context, state) {
        return RefreshIndicator(
          onRefresh: () async => context.read<VisitDetailBloc>().add(
            VisitDetailJustFromServerEvent(),
          ),
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.bgColor,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_ios_new),
              ),
              centerTitle: true,
              title: Text('My visit'),
              automaticallyImplyLeading: false,
            ),
            backgroundColor: AppColors.bgColor,
            body: SafeArea(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : allVisitsModel == null || allVisitsModel!.visits.isEmpty
                  ? Center(
                      child: SizedBox(
                        width: MediaQuery.sizeOf(context).width,
                        child: Column(
                          spacing: 10.h,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomText(
                              text: message == 'No internet connection!'
                                  ? message!
                                  : 'No visits found',
                              color: AppColors.primaryColor,
                              fontSize: 16,
                            ),
                            InkWell(
                              onTap: () => context.read<VisitDetailBloc>().add(
                                VisitDetailApiAndLocalEvent(),
                              ),
                              child: Icon(Icons.refresh),
                            ),
                          ],
                        ),
                      ),
                    )
                  : ListView(
                      padding: EdgeInsets.all(16.w),
                      // Display newest first; review rules still use
                      // chronological index (oldest = visit 1).
                      children: List.generate(allVisitsModel!.visits.length, (
                        displayIndex,
                      ) {
                        final visitIndex =
                            allVisitsModel!.visits.length - 1 - displayIndex;
                        final visit = allVisitsModel!.visits[visitIndex];
                        final visitQuestions = _questionsForVisit(visitIndex);
                        return Card(
                          margin: EdgeInsets.only(bottom: 12.h),
                          color: AppColors.secondaryColor,
                          child: Padding(
                            padding: EdgeInsets.all(12.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RowText(
                                  firstText: 'Date',
                                  secondText: DateAndTimeFormater.dateFormat(
                                    visit.displayDate,
                                  ),
                                ),
                                RowText(
                                  firstText: 'Type',
                                  buttonText: visit.displayType.toString(),
                                ),
                                RowText(
                                  firstText: 'Doctor',
                                  secondText: visit.displayDoctor,
                                ),
                                RowText(
                                  firstText: 'Stage',
                                  secondText: visit.displayStage,
                                ),
                                RowText(
                                  firstText: 'Amount',
                                  secondText: visit.displayConsultationFee,
                                ),
                                RowText(
                                  firstText: 'Status',
                                  secondText: visit.displayStatus,
                                ),

                                const Divider(),

                                /// QUESTIONS
                                if (_isVisitExpanded(visitIndex) &&
                                    visitQuestions.isNotEmpty)
                                  _buildCategorizedQuestions(
                                    visitIndex: visitIndex,
                                    visitQuestions: visitQuestions,
                                  ),

                                /// BUTTON / SUBMITTED REVIEW / EMPTY MSG
                                if (visit.hasReview) ...[
                                  SizedBox(height: 20.h),
                                  _buildSubmittedReview(visit),
                                ] else if (visitQuestions.isNotEmpty) ...[
                                  SizedBox(height: 20.h),
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
                                    text: _isVisitExpanded(visitIndex)
                                        ? 'Submit'
                                        : 'Give Feedback',
                                  ),
                                ] else ...[
                                  SizedBox(height: 12.h),
                                  CustomText(
                                    text:
                                        'No feedback available for this visit yet.',
                                    color: AppColors.primaryColor,
                                  ),
                                ],
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
            ),
          ),
        );
      },
    );
  }
}
