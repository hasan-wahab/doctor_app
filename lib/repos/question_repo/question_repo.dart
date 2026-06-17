import 'dart:convert';

import 'package:doctor_app/core/app_keys/api_keys.dart';
import 'package:doctor_app/data/api_service/base_api/base_api.dart';
import 'package:doctor_app/data/models/reviews_question_model.dart';
import 'package:http/http.dart';

class QuestionRepo {
  BaseApi api;

  QuestionRepo({required this.api});

  Future getQuestions({required String token}) async {
    List<QuestionModel> questionList = [];
    try {
      Map<String, dynamic> response = await api.getApi(
        url: ApiKeys.question,
        token: token,
      );
      if (response.isNotEmpty) {
        for (var a in response['data']) {
          questionList.add(QuestionModel.fromJson(a));
        }
        print(questionList.length);
        return questionList;
      } else {
        throw Exception('No data found');
      }
    } on Exception catch (e) {
      throw e.toString();
    }
  }
}
