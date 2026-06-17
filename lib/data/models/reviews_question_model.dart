class QuestionModel {
  QuestionModel({
    required this.id,
    required this.questionText,
    required this.type,
    required this.options,
    required this.isActive,
    required this.sortOrder,
    required this.createdAt,
    required this.updatedAt,
  });

  final int id;
  final String questionText;
  final String type;
  final List<String> options;
  final bool isActive;
  final int sortOrder;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory QuestionModel.fromJson(Map<String, dynamic> json){
    return QuestionModel(
      id: json["id"] ?? 0,
      questionText: json["question_text"] ?? "",
      type: json["type"] ?? "",
      options: json["options"] == null ? [] : List<String>.from(json["options"]!.map((x) => x)),
      isActive: json["is_active"] ?? false,
      sortOrder: json["sort_order"] ?? 0,
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "question_text": questionText,
    "type": type,
    "options": options.map((x) => x).toList(),
    "is_active": isActive,
    "sort_order": sortOrder,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };

}
