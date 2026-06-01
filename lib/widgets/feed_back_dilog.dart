// import 'package:doctor_app/widgets/date_time_foemat.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// /// Teal accent from your UI (adjust if brand changes).
// const Color kFeedbackPrimary = Color(0xFF109D8E);
//
// /// Data shown in the dialog header — pass from parent / API.
// class FeedbackSubject {
//   final String name;
//
//   /// e.g. "05/14/2026
//   final String subtitle;
//
//   ///• Package Session"
//
//   final String subtitle2;
//
//   final Widget? avatar;
//   final Color avatarBackgroundColor;
//   final Color avatarForegroundColor;
//   const FeedbackSubject({
//     required this.name,
//     required this.subtitle,
//     required this.subtitle2,
//     this.avatar,
//     this.avatarBackgroundColor = const Color(0xFFE0F2F1),
//     this.avatarForegroundColor = kFeedbackPrimary,
//   });
// }
//
// /// Result when user taps Submit (rating 1–5, trimmed comment).
// class FeedbackResult {
//   const FeedbackResult({required this.rating, required this.comment});
//
//   final int rating;
//   final String comment;
// }
//
// /// Reusable "Give Feedback" modal — matches screenshot-style layout.
// ///
// /// Usage:
// /// ```dart
// /// final result = await GiveFeedbackDialog.show(
// ///   context,
// ///   subject: FeedbackSubject(
// ///     name: 'DR ANWAR UL HAQ',
// ///     subtitle: '05/14/2026 • Package Session',
// ///   ),
// /// );
// /// if (result != null) { /* save result */ }
// /// ```
// class GiveFeedbackDialog extends StatefulWidget {
//   final FeedbackSubject subject;
//   final String title;
//   final String experienceQuestion;
//   final String commentLabel;
//   final String commentHint;
//   final int maxCommentLength;
//
//   /// 0 = none selected; 1–5 = stars
//   final int initialRating;
//   final String cancelLabel;
//   final String submitLabel;
//   final Color barrierColor;
//   const GiveFeedbackDialog({
//     super.key,
//     required this.subject,
//     this.title = 'Give Feedback',
//     this.experienceQuestion = 'How was your experience?',
//     this.commentLabel = 'Write your comment (optional)',
//     this.commentHint = 'Write your comment here...',
//     this.maxCommentLength = 500,
//     this.initialRating = 0,
//     this.cancelLabel = 'Cancel',
//     this.submitLabel = 'Submit',
//     this.barrierColor = const Color(0x99000000),
//   });
//
//   /// Opens the dialog; returns [FeedbackResult] on Submit, `null` on dismiss/Cancel.
//   static Future<FeedbackResult?> show(
//     BuildContext context, {
//     required FeedbackSubject subject,
//     String title = 'Give Feedback',
//     String experienceQuestion = 'How was your experience?',
//     String commentLabel = 'Write your comment (optional)',
//     String commentHint = 'Write your comment here...',
//     int maxCommentLength = 500,
//     int initialRating = 0,
//     String cancelLabel = 'Cancel',
//     String submitLabel = 'Submit',
//     Color barrierColor = const Color(0x99000000),
//     bool barrierDismissible = true,
//   }) {
//     return showDialog<FeedbackResult>(
//       context: context,
//       barrierDismissible: barrierDismissible,
//       barrierColor: barrierColor,
//       builder: (ctx) => GiveFeedbackDialog(
//         subject: subject,
//         title: title,
//         experienceQuestion: experienceQuestion,
//         commentLabel: commentLabel,
//         commentHint: commentHint,
//         maxCommentLength: maxCommentLength,
//         initialRating: initialRating,
//         cancelLabel: cancelLabel,
//         submitLabel: submitLabel,
//         barrierColor: barrierColor,
//       ),
//     );
//   }
//
//   @override
//   State<GiveFeedbackDialog> createState() => _GiveFeedbackDialogState();
// }
//
// class _GiveFeedbackDialogState extends State<GiveFeedbackDialog> {
//   late int _rating;
//   late final TextEditingController _commentController;
//
//   @override
//   void initState() {
//     super.initState();
//     _rating = widget.initialRating.clamp(widget.initialRating, 5);
//     _commentController = TextEditingController();
//   }
//
//   @override
//   void dispose() {
//     _commentController.dispose();
//     super.dispose();
//   }
//
//   void _submit() {
//     if (_rating < 1) {
//       ScaffoldMessenger.maybeOf(
//         context,
//       )?.showSnackBar(const SnackBar(content: Text('Please select a rating.')));
//       return;
//     }
//     print(_rating);
//     Navigator.of(context).pop(
//       FeedbackResult(rating: _rating, comment: _commentController.text.trim()),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final s = widget.subject;
//     final radius = 20.r;
//     final buttonRadius = 10.0.r;
//
//     return Dialog(
//       insetPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(radius),
//       ),
//       backgroundColor: Colors.white,
//       child: Padding(
//         padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 20.h),
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               Row(
//                 children: [
//                   Expanded(
//                     child: Text(
//                       widget.title,
//                       style: TextStyle(
//                         fontSize: 18.sp,
//                         fontWeight: FontWeight.w700,
//                         color: Colors.black87,
//                       ),
//                     ),
//                   ),
//                   IconButton(
//                     onPressed: () => Navigator.of(context).pop(),
//                     icon: Icon(Icons.close, size: 22.r, color: Colors.black54),
//                     padding: EdgeInsets.zero,
//                     constraints: BoxConstraints(
//                       minWidth: 40.w,
//                       minHeight: 40.h,
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 8.h),
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   CircleAvatar(
//                     radius: 28.r,
//                     backgroundColor: s.avatarBackgroundColor,
//                     child:
//                         s.avatar ??
//                         Icon(
//                           Icons.person,
//                           size: 32.r,
//                           color: s.avatarForegroundColor,
//                         ),
//                   ),
//                   SizedBox(width: 14.w),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           s.name,
//                           style: TextStyle(
//                             fontSize: 15.sp,
//                             fontWeight: FontWeight.w700,
//                             color: Colors.black87,
//                           ),
//                         ),
//                         SizedBox(height: 4.h),
//                         Text(
//                           "${DateAndTimeFormater.dateFormat(s.subtitle)}  ${s.subtitle2}",
//                           style: TextStyle(
//                             fontSize: 13.sp,
//                             color: Colors.grey.shade600,
//                             height: 1.25.h,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 22.h),
//               Text(
//                 widget.experienceQuestion,
//                 style: TextStyle(fontSize: 15.sp, color: Colors.black87),
//               ),
//               SizedBox(height: 10.h),
//               _StarRatingRow(
//                 rating: _rating,
//                 primary: kFeedbackPrimary,
//                 onChanged: (v) => setState(() => _rating = v),
//               ),
//               SizedBox(height: 20.h),
//               Text(
//                 widget.commentLabel,
//                 style: TextStyle(fontSize: 14.sp, color: Colors.black87),
//               ),
//               SizedBox(height: 8.h),
//               _CommentField(
//                 controller: _commentController,
//                 hint: widget.commentHint,
//                 maxLength: widget.maxCommentLength,
//               ),
//               SizedBox(height: 20.h),
//               Row(
//                 children: [
//                   Expanded(
//                     child: OutlinedButton(
//                       onPressed: () => Navigator.of(context).pop(),
//                       style: OutlinedButton.styleFrom(
//                         foregroundColor: kFeedbackPrimary,
//                         side: BorderSide(color: kFeedbackPrimary, width: 1.2.w),
//                         padding: EdgeInsets.symmetric(vertical: 14.h),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(buttonRadius),
//                         ),
//                       ),
//                       child: Text(widget.cancelLabel),
//                     ),
//                   ),
//                   SizedBox(width: 12.w),
//                   Expanded(
//                     child: FilledButton(
//                       onPressed: _submit,
//                       style: FilledButton.styleFrom(
//                         backgroundColor: kFeedbackPrimary,
//                         foregroundColor: Colors.white,
//                         padding: EdgeInsets.symmetric(vertical: 14.h),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(buttonRadius),
//                         ),
//                       ),
//                       child: Text(widget.submitLabel),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class _StarRatingRow extends StatelessWidget {
//   const _StarRatingRow({
//     required this.rating,
//     required this.primary,
//     required this.onChanged,
//   });
//
//   final int rating;
//   final Color primary;
//   final ValueChanged<int> onChanged;
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: List.generate(5, (i) {
//             final index = i + 1;
//             final selected = rating >= index;
//             return InkWell(
//               onTap: () => onChanged(index),
//               borderRadius: BorderRadius.circular(20.r),
//               child: Padding(
//                 padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 2.w),
//                 child: Icon(
//                   selected ? Icons.star : Icons.star_border,
//                   color: primary,
//                   size: 36.r,
//                 ),
//               ),
//             );
//           }),
//         ),
//         SizedBox(height: 2.h),
//         Row(
//           children: [
//             Text(
//               'Poor',
//               style: TextStyle(fontSize: 12.sp, color: Colors.grey.shade600),
//             ),
//             const Spacer(),
//             Text(
//               'Excellent',
//               style: TextStyle(fontSize: 12.sp, color: Colors.grey.shade600),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }
//
// class _CommentField extends StatelessWidget {
//   const _CommentField({
//     required this.controller,
//     required this.hint,
//     required this.maxLength,
//   });
//
//   final TextEditingController controller;
//   final String hint;
//   final int maxLength;
//
//   @override
//   Widget build(BuildContext context) {
//     final border = OutlineInputBorder(
//       borderRadius: BorderRadius.circular(10.r),
//       borderSide: BorderSide(color: Colors.grey.shade300),
//     );
//
//     return TextField(
//       controller: controller,
//       maxLines: 4,
//       maxLength: maxLength,
//       buildCounter:
//           (context, {required currentLength, required isFocused, maxLength}) {
//             return Padding(
//               padding: EdgeInsets.only(top: 4.h, right: 2.w),
//               child: Text(
//                 '$currentLength/$maxLength',
//                 style: TextStyle(fontSize: 12.sp, color: Colors.grey.shade600),
//               ),
//             );
//           },
//       decoration: InputDecoration(
//         hintText: hint,
//         hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14.sp),
//         filled: true,
//         fillColor: Colors.grey.shade50,
//         contentPadding: EdgeInsets.fromLTRB(14.w, 12.h, 14.w, 36.h),
//         border: border,
//         enabledBorder: border,
//         focusedBorder: border.copyWith(
//           borderSide: BorderSide(color: kFeedbackPrimary, width: 1.2.w),
//         ),
//       ),
//     );
//   }
// }
