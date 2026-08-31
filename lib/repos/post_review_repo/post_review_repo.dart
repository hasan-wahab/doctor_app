import 'package:doctor_app/core/app_keys/api_keys.dart';
import 'package:doctor_app/data/api_service/base_api/base_api.dart';
import 'package:flutter/foundation.dart';

import '../../data/models/post_review_model.dart';

class PostReviewRepo {
  BaseApi api;

  PostReviewRepo({required this.api});

  Future postReview({
    required PostReviewModel model,
    required String token,
  }) async {
    try {
      if (kDebugMode) {
        print('>>> CALLING SUBMITTED REVIEW API (POST)');
        print('>>> URL : ${ApiKeys.postReviewKey}');
        print('>>> BODY: ${model.toJson()}');
      }
      await api.postApi(
        url: ApiKeys.postReviewKey,
        body: model.toJson(),
        token: token,
      );
    } on Exception catch (e) {
      throw e.toString();
    }
  }

  Future editReview({
    required int reviewId,
    required PostReviewModel model,
    required String token,
  }) async {
    try {
      if (kDebugMode) {
        print('>>> CALLING EDITED REVIEW API (PUT)');
        print('>>> URL : ${ApiKeys.editReviewKey(reviewId)}');
        print('>>> BODY: ${model.toJson()}');
      }
      await api.putApi(
        url: ApiKeys.editReviewKey(reviewId),
        body: model.toJson(),
        token: token,
      );
    } on Exception catch (e) {
      throw e.toString();
    }
  }
}
