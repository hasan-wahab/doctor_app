class PostReviewModel {
  int? visitId;
  int? rating;
  String? comment;
  List<Answers>? options;

  PostReviewModel({this.visitId, this.rating, this.comment, this.options});

  PostReviewModel.fromJson(Map<String, dynamic> json) {
    visitId = json['visit_id'];
    rating = json['rating'];
    comment = json['comment'];
    if (json['answers'] != null) {
      options = <Answers>[];
      json['answers'].forEach((v) {
        options!.add(new Answers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['visit_id'] = this.visitId;
    data['rating'] = this.rating;
    data['comment'] = this.comment;
    if (this.options != null) {
      data['answers'] = this.options!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Answers {
  int? questionId;
  String? answer;

  Answers({this.questionId, this.answer});

  Answers.fromJson(Map<String, dynamic> json) {
    questionId = json['question_id'];
    answer = json['answer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['question_id'] = this.questionId;
    data['answer'] = this.answer;
    return data;
  }
}
