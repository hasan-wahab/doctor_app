import 'package:doctor_app/core/app_keys/api_keys.dart';
import 'package:doctor_app/data/api_service/base_api/base_api.dart';

import '../../data/models/post_review_model.dart';

class PostReviewRepo {
  BaseApi api;

  PostReviewRepo({required this.api});

  Future postReview({
    required PostReviewModel model,
    required String token,
  }) async {
    try {
      await api.postApi(
        url: ApiKeys.postReviewKey,
        body: model.toJson(),
        token: token,
      );
    } on Exception catch (e) {
      throw e.toString();
    }
  }
}
