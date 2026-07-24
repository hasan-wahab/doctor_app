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

  /// Visit position rules (1-based visit number, oldest visit first):
  /// - Visit 1 + type consultation → consultation questions
  /// - Visits 2,3,4,5 → therapist
  /// - Visit 6,11,16... + type consultation → reconsultation
  /// - Visits 7,8,9,10,12,13... (other slots) → therapist
  String _questionCategoryForVisit(int visitIndex) {
    final visit = allVisitsModel!.visits[visitIndex];
    final type = visit.type?.toLowerCase().trim() ?? '';
    final visitNumber = visitIndex + 1;

    if (visitNumber == 1 && type == 'consultation') {
      return 'consultation';
    }

    if (visitNumber > 1 &&
        (visitNumber - 1) % 5 == 0 &&
        type == 'consultation') {
      return 'reconsultation';
    }

    return 'therapist';
  }

  List<QuestionModel> _questionsForVisit(int visitIndex) {
    if (questionModel == null) return [];
    final category = _questionCategoryForVisit(visitIndex).toLowerCase();
    final filtered = questionModel!
        .where((q) => q.isActive && q.category.toLowerCase().trim() == category)
        .toList();
    filtered.sort((a, b) => a.sortOrder.compareTo(b.sortOrder));
    return filtered;
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
  Future submitData(int visitIndex) async {
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

    final postModel = PostReviewModel(
      visitId: allVisitsModel!.visits[visitIndex].visitId,
      rating: rating,
      comment: comment,
      options: answersList,
    );
    context.read<VisitDetailBloc>().add(
      ReviewSubmitEvent(postReviewModel: postModel),
    );
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
                  : allVisitsModel == null
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
                                  : 'No data',
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
                                _isVisitExpanded(visitIndex) &&
                                        visit.isCompleted
                                    ? visitQuestions.isEmpty
                                          ? CustomText(
                                              text:
                                                  'No feedback questions available for this visit.',
                                              color: AppColors.primaryColor,
                                            )
                                          : Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              spacing: 10,
                                              children: List.generate(visitQuestions.length, (
                                                questionIndex,
                                              ) {
                                                final q =
                                                    visitQuestions[questionIndex];
                                                final visitAnswerMap =
                                                    answers[visitIndex];
                                                if (visitAnswerMap == null ||
                                                    !visitAnswerMap.containsKey(
                                                      questionIndex,
                                                    )) {
                                                  return const SizedBox.shrink();
                                                }
                                                final ans =
                                                    visitAnswerMap[questionIndex]!;

                                                return Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(height: 10.h),

                                                    CustomText(
                                                      maxLines: 10,
                                                      text: q
                                                          .questionText
                                                          .toSentenceCase,
                                                      color: AppColors
                                                          .primaryColor,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),

                                                    /// ⭐ RATING
                                                    if (q.type == 'rating')
                                                      Row(
                                                        children: List.generate(
                                                          5,
                                                          (i) => InkWell(
                                                            onTap: () {
                                                              setState(() {
                                                                ans.rating =
                                                                    i + 1;
                                                              });
                                                            },
                                                            child: Icon(
                                                              Icons.star,
                                                              color:
                                                                  ans.rating > i
                                                                  ? Colors.amber
                                                                  : Colors.grey,
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    /// OPTIONS
                                                    else if (q.type ==
                                                        'options')
                                                      Wrap(
                                                        spacing: 10,
                                                        children: List.generate(
                                                          q.options.length,
                                                          (i) {
                                                            return CheckCircle(
                                                              text: q
                                                                  .options[i]
                                                                  .toSentenceCase,
                                                              isSelected: ans
                                                                  .selectedOptions[i],
                                                              onChange: () {
                                                                setState(() {
                                                                  ans.selectedOptions[i] =
                                                                      !ans.selectedOptions[i];
                                                                });
                                                              },
                                                            );
                                                          },
                                                        ),
                                                      )
                                                    /// COMMENT
                                                    else
                                                      TextField(
                                                        controller:
                                                            ans.controller,
                                                        maxLines: 2,
                                                        decoration: const InputDecoration(
                                                          hintText:
                                                              "Write feedback...",
                                                          border:
                                                              OutlineInputBorder(),
                                                        ),
                                                      ),
                                                  ],
                                                );
                                              }),
                                            )
                                    : const SizedBox.shrink(),
                                SizedBox(height: 20.h),

                                /// BUTTON
                                !visit.hasReview
                                    ? visit.isCompleted
                                          ? AppButton(
                                              onTap: () async {
                                                if (_isVisitExpanded(
                                                  visitIndex,
                                                )) {
                                                  if (visitQuestions.isEmpty) {
                                                    AppMsg.showSnackBar(
                                                      context,
                                                      message:
                                                          'No questions to submit for this visit.',
                                                    );
                                                  } else {
                                                    await submitData(
                                                      visitIndex,
                                                    );
                                                  }
                                                }
                                                setState(() {
                                                  _setVisitExpanded(
                                                    visitIndex,
                                                    !_isVisitExpanded(
                                                      visitIndex,
                                                    ),
                                                  );
                                                });
                                              },
                                              text: _isVisitExpanded(visitIndex)
                                                  ? 'Submit'
                                                  : 'Give Feedback',
                                            )
                                          : Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                CustomText(
                                                  color: AppColors.primaryColor,

                                                  text:
                                                      'You can only review completed visits.',
                                                ),
                                              ],
                                            )
                                    : _buildSubmittedReview(visit),
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
