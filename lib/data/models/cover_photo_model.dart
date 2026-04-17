class CoverPhotoModel {
  final bool success;
  final int statusCode;
  final String message;
  final List<String> data;

  CoverPhotoModel({
    required this.success,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory CoverPhotoModel.fromJson(Map<String, dynamic> json) {
    return CoverPhotoModel(
      success: json['success'] ?? false,
      statusCode: json['status_code'] ?? 0,
      message: json['message'] ?? '',
      data: List<String>.from(json['data'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'status_code': statusCode,
      'message': message,
      'data': data,
    };
  }
}
