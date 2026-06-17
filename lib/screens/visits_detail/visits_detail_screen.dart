// import 'package:doctor_app/core/extentions/context_extentions.dart';
// import 'package:doctor_app/data/api_service/base_api/base_api_impl.dart';
// import 'package:doctor_app/data/models/all_visits_model.dart';
// import 'package:doctor_app/data/models/reviews_question_model.dart';
// import 'package:doctor_app/repos/question_repo/question_repo.dart';
// import 'package:doctor_app/screens/profile_screens/bloc/profile_event.dart';
// import 'package:doctor_app/screens/visits_detail/bloc/visit_detail_bloc.dart';
// import 'package:doctor_app/widgets/app_t_field.dart';
// import 'package:doctor_app/widgets/check_circle.dart';
// import 'package:doctor_app/widgets/custom_text.dart';
// import 'package:doctor_app/widgets/date_time_foemat.dart';
// import 'package:doctor_app/widgets/feed_back_dilog.dart';
// import 'package:doctor_app/widgets/feedback_button.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// import '../../core/app_styles/app_colors.dart';
// import '../../data/models/current_patient_model.dart';
// import '../../widgets/app_button.dart';
// import '../../widgets/row_text.dart';
// import '../../widgets/show_msg.dart';
// import '../profile_screens/bloc/profile_bloc.dart';
// import '../profile_screens/bloc/profile_state.dart';
// import 'bloc/visit_detail_event.dart';
// import 'bloc/visit_detail_state.dart';
//
// class VisitsDetailScreen extends StatefulWidget {
//   const VisitsDetailScreen({super.key});
//
//   @override
//   State<VisitsDetailScreen> createState() => _VisitsDetailScreenState();
// }
//
// class _VisitsDetailScreenState extends State<VisitsDetailScreen> {
//   AllVisitsModel? allVisitsModel;
//   List<QuestionModel>? questionModel;
//   bool isLoading = false;
//   int startValue = 0;
//   List<bool> isSelected = [];
//
//   List<List<bool>> boolList = [];
//
//   @override
//   void initState() {
//     context.read<VisitDetailBloc>().add(VisitDetailApiAndLocalEvent());
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<VisitDetailBloc, VisitDetailState>(
//       listener: (context, state) {
//         if (state is VisitDetailLoadingState) {
//           isLoading = true;
//         }
//         if (state is VisitDetailMessageState) {
//           isLoading = false;
//           AppMsg.showSnackBar(context, message: state.message.toString());
//         }
//         if (state is AllVisitDatilsListState) {
//           isLoading = false;
//           allVisitsModel = state.model;
//           questionModel = state.question;
//
//         }
//       },
//       builder: (context, state) {
//         return RefreshIndicator(
//           onRefresh: () async => context.read<VisitDetailBloc>().add(
//             VisitDetailJustFromServerEvent(),
//           ),
//           child: Scaffold(
//             appBar: AppBar(
//               backgroundColor: AppColors.bgColor,
//               leading: IconButton(
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//                 icon: Icon(Icons.arrow_back_ios_new),
//               ),
//               centerTitle: true,
//               title: Text('My visit'),
//               automaticallyImplyLeading: false,
//             ),
//             backgroundColor: AppColors.bgColor,
//             body: SafeArea(
//               child: isLoading == false && allVisitsModel != null
//                   ? allVisitsModel!.visits.isNotEmpty
//                         ? ListView(
//                             padding: EdgeInsets.symmetric(
//                               horizontal: 20.w,
//                               vertical: 10.h,
//                             ),
//                             children: [
//                               CustomText(
//                                 text: 'Visit History',
//                                 fontSize: 20,
//                                 color: AppColors.primaryColor,
//                               ),
//                               Column(
//                                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                                 children: List.generate(allVisitsModel!.visits.length, (
//                                   index,
//                                 ) {
//                                   final currentPatient = allVisitsModel!.visits;
//                                   return Container(
//                                     margin: EdgeInsets.only(top: 10.h),
//
//                                     width: 360.w,
//                                     decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(12.r),
//                                     ),
//
//                                     child: Card(
//                                       margin: EdgeInsets.zero,
//                                       color: AppColors.secondaryColor,
//                                       child: Padding(
//                                         padding: EdgeInsets.symmetric(
//                                           horizontal: 12.w,
//                                           vertical: 12.h,
//                                         ),
//                                         child: Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.spaceBetween,
//                                           children: [
//                                             RowText(
//                                               firstText: 'Date',
//                                               secondText:
//                                                   DateAndTimeFormater.dateFormat(
//                                                     currentPatient[index]
//                                                         .displayDate,
//                                                   ),
//                                             ),
//                                             RowText(
//                                               firstText: 'Type',
//                                               buttonText: currentPatient[index]
//                                                   .displayType
//                                                   .toString(),
//                                             ),
//                                             RowText(
//                                               firstText: 'Doctor',
//                                               secondText: currentPatient[index]
//                                                   .displayDoctor,
//                                             ),
//                                             RowText(
//                                               firstText: 'Stage',
//                                               secondText: currentPatient[index]
//                                                   .displayStage,
//                                             ),
//                                             RowText(
//                                               firstText: 'Amount',
//                                               secondText: currentPatient[index]
//                                                   .displayConsultationFee,
//                                             ),
//                                             RowText(
//                                               firstText: 'Status',
//                                               secondText: currentPatient[index]
//                                                   .displayStatus,
//                                             ),
//
//                                             Divider(),
//
//                                             ...List.generate((questionModel!.length), (
//                                               index1,
//                                             ) {
//                                               return Column(
//                                                 spacing: 8.h,
//                                                 crossAxisAlignment:
//                                                     CrossAxisAlignment.start,
//                                                 children: [
//                                                   if (questionModel![index1]
//                                                           .type ==
//                                                       'rating')
//                                                     Column(
//                                                       spacing: 10.h,
//                                                       crossAxisAlignment:
//                                                           CrossAxisAlignment
//                                                               .start,
//                                                       children: [
//                                                         CustomText(
//                                                           color: AppColors
//                                                               .primaryColor,
//                                                           fontWeight:
//                                                               FontWeight.bold,
//                                                           fontSize: 18.sp,
//                                                           text: questionModel![index1]
//                                                               .questionText
//                                                               .toSentenceCase,
//                                                         ),
//
//                                                         /// Stars
//                                                         Row(
//                                                           mainAxisAlignment:
//                                                               MainAxisAlignment
//                                                                   .spaceEvenly,
//                                                           children: List.generate(
//                                                             (5),
//                                                             (index) => InkWell(
//                                                               onTap: () {
//                                                                 setState(() {
//                                                                   startValue <
//                                                                           index
//                                                                       ? startValue =
//                                                                             index
//                                                                       : startValue =
//                                                                             0;
//                                                                 });
//                                                               },
//                                                               child: Icon(
//                                                                 Icons.star,
//                                                                 color:
//                                                                     startValue <
//                                                                         index
//                                                                     ? Colors
//                                                                           .amber
//                                                                     : Colors
//                                                                           .amber
//                                                                           .shade700,
//                                                               ),
//                                                             ),
//                                                           ),
//                                                         ),
//                                                       ],
//                                                     )
//                                                   else if (questionModel![index1]
//                                                           .type ==
//                                                       'options')
//                                                     Column(
//                                                       spacing: 10.h,
//                                                       crossAxisAlignment:
//                                                           CrossAxisAlignment
//                                                               .start,
//                                                       children: [
//                                                         CustomText(
//                                                           color: AppColors
//                                                               .primaryColor,
//                                                           fontWeight:
//                                                               FontWeight.bold,
//                                                           fontSize: 18.sp,
//                                                           text: questionModel![index1]
//                                                               .questionText
//                                                               .toSentenceCase,
//                                                         ),
//                                                         Wrap(
//                                                           runSpacing: 12,
//                                                           spacing: 10.w,
//                                                           children: List.generate(
//                                                             (questionModel![index1]
//                                                                 .options
//                                                                 .length),
//                                                             (index) {
//                                                               isSelected.add(
//                                                                 false,
//                                                               );
//                                                               return CheckCircle(
//                                                                 onChange: () {
//                                                                   setState(() {
//                                                                     isSelected[index] =
//                                                                         !isSelected[index];
//                                                                   });
//                                                                 },
//                                                                 isSelected:
//                                                                     isSelected[index],
//                                                                 text: questionModel![index1]
//                                                                     .options[index]
//                                                                     .toSentenceCase,
//                                                               );
//                                                             },
//                                                           ),
//                                                         ),
//                                                       ],
//                                                     )
//                                                   else
//                                                     Column(
//                                                       spacing: 10.h,
//                                                       crossAxisAlignment:
//                                                           CrossAxisAlignment
//                                                               .start,
//                                                       children: [
//                                                         CustomText(
//                                                           color: AppColors
//                                                               .primaryColor,
//                                                           fontWeight:
//                                                               FontWeight.bold,
//                                                           fontSize: 18.sp,
//                                                           text: questionModel![index1]
//                                                               .questionText
//                                                               .toSentenceCase,
//                                                         ),
//
//                                                         TextField(
//                                                           maxLines: 2,
//                                                           decoration: InputDecoration(
//                                                             hintText: 'Comment',
//                                                             hintStyle:
//                                                                 TextStyle(
//                                                                   color: Colors
//                                                                       .grey
//                                                                       .shade400,
//                                                                   fontSize:
//                                                                       14.sp,
//                                                                 ),
//                                                             filled: true,
//                                                             fillColor: Colors
//                                                                 .grey
//                                                                 .shade50,
//                                                             contentPadding:
//                                                                 EdgeInsets.fromLTRB(
//                                                                   14.w,
//                                                                   12.h,
//                                                                   14.w,
//                                                                   36.h,
//                                                                 ),
//                                                           ),
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   SizedBox(height: 10.h),
//                                                 ],
//                                               );
//                                             }),
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                   );
//                                 }),
//                               ),
//                             ],
//                           )
//                         : Center(child: Text('No data'))
//                   : Center(child: CircularProgressIndicator()),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
import 'package:doctor_app/core/extentions/context_extentions.dart';
import 'package:doctor_app/data/api_service/base_api/base_api_impl.dart';
import 'package:doctor_app/data/models/all_visits_model.dart';
import 'package:doctor_app/data/models/reviews_question_model.dart';
import 'package:doctor_app/repos/post_review_repo/post_review_repo.dart';
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

  /// ======================
  /// INIT ANSWERS (NO CHANGE)
  /// ======================
  void initAnswers() {
    answers.clear();

    for (int i = 0; i < allVisitsModel!.visits.length; i++) {
      answers[i] = {};

      for (int j = 0; j < questionModel!.length; j++) {
        answers[i]![j] = AnswerModel(
          rating: 0,
          selectedOptions: List.generate(
            questionModel![j].options.length,
            (_) => false,
          ),
          controller: TextEditingController(),
        );
      }
    }
  }

  /// ======================
  /// SUBMIT DATA (FIXED ONLY HERE)
  /// ======================
  Future<void> submitData(int visitIndex) async {
    final visitAnswers = answers[visitIndex]!;

    int? rating;
    String? comment;
    List<Answers> answersList = [];

    visitAnswers.forEach((questionIndex, ans) {
      final q = questionModel![questionIndex];

      /// ⭐ RATING
      if (q.type == 'rating') {
        rating = ans.rating;
      }
      /// 📝 COMMENT (SAFE FIX)
      else if (q.type.toLowerCase().contains('comment') ||
          q.type.toLowerCase().contains('text') ||
          q.type.toLowerCase().contains('feedback')) {
        comment = ans.controller.text;
      }
      /// ✅ OPTIONS
      else if (q.type == 'options') {
        for (int i = 0; i < ans.selectedOptions.length; i++) {
          if (ans.selectedOptions[i]) {
            answersList.add(Answers(questionId: q.id, answer: q.options[i]));
          }
        }
      }
    });

    /// 🔥 FINAL MODEL
    PostReviewModel postModel = PostReviewModel(
      visitId: allVisitsModel!.visits[visitIndex].visitId,
      rating: rating,
      comment: comment,
      options: answersList,
    );
    context.read<VisitDetailBloc>().add(
      ReviewSubmitEvent(postReviewModel: postModel),
    );
  }

  /// ======================
  /// UI (NO CHANGE)
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
          AppMsg.showSnackBar(context, message: state.message.toString());
        }

        if (state is AllVisitDatilsListState) {
          isLoading = false;
          allVisitsModel = state.model;
          questionModel = state.question;
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
                  ? const SizedBox()
                  : ListView(
                      padding: EdgeInsets.all(16.w),
                      children: List.generate(allVisitsModel!.visits.length, (
                        visitIndex,
                      ) {
                        final visit = allVisitsModel!.visits[visitIndex];
                        isExpended.add(false);
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
                                isExpended[visitIndex] && visit.isCompleted
                                    ? Column(
                                        spacing: 10,
                                        children: List.generate(questionModel!.length, (
                                          questionIndex,
                                        ) {
                                          final q =
                                              questionModel![questionIndex];
                                          final ans =
                                              answers[visitIndex]![questionIndex]!;

                                          return Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(height: 10.h),

                                              CustomText(
                                                text: q
                                                    .questionText
                                                    .toSentenceCase,
                                                color: AppColors.primaryColor,
                                                fontWeight: FontWeight.bold,
                                              ),

                                              /// ⭐ RATING
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
                                                        color: ans.rating > i
                                                            ? Colors.amber
                                                            : Colors.grey,
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              /// OPTIONS
                                              else if (q.type == 'options')
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
                                                  controller: ans.controller,
                                                  maxLines: 2,
                                                  decoration:
                                                      const InputDecoration(
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
                                    : SizedBox(),
                                SizedBox(height: 20.h),

                                /// BUTTON
                                visit.isCompleted
                                    ? AppButton(
                                        onTap: () {
                                          if (isExpended[visitIndex]) {
                                            submitData(visitIndex);
                                          }
                                          setState(() {
                                            isExpended[visitIndex] =
                                                !isExpended[visitIndex];
                                          });
                                          print(isExpended);
                                        },
                                        text: isExpended[visitIndex]
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
                                      ),
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
