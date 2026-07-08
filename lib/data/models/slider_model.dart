import 'dart:convert';

class SliderModel {
  final int? id;
  final String title;
  final List<String> images;
  final int? createdBy;
  final int? updatedBy;
  final String createdAt;
  final String updatedAt;
  final String? deletedAt;

  // 🔥 DISPLAY VARIABLES
  late final String displayTitle;
  late final String displayImage;
  late final bool hasImage;
  late final int imageCount;

  SliderModel({
    this.id,
    required this.title,
    required this.images,
    this.createdBy,
    this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  }) {
    displayTitle = title.trim().isNotEmpty ? title : "No Title";
    hasImage = images.isNotEmpty;
    displayImage = hasImage ? images.first : "";
    imageCount = images.length;
  }

  /// 🔥 FROM JSON (SUPER SAFE)
  factory SliderModel.fromJson(Map<String, dynamic> json) {
    List<String> parsedImages = [];

    try {
      final rawImages = json['images'];

      if (rawImages != null) {
        // ✅ Case 1: already List
        if (rawImages is List) {
          parsedImages = List<String>.from(rawImages);
        }
        // ✅ Case 2: String (your current API)
        else if (rawImages is String && rawImages.isNotEmpty) {
          parsedImages = List<String>.from(jsonDecode(rawImages));
        }
      }
    } catch (e) {
      parsedImages = [];
    }

    return SliderModel(
      id: json['id'] is int ? json['id'] : null,
      title: json['title']?.toString() ?? '',
      images: parsedImages,
      createdBy: json['created_by'] is int ? json['created_by'] : null,
      updatedBy: json['updated_by'] is int ? json['updated_by'] : null,
      createdAt: json['created_at']?.toString() ?? '',
      updatedAt: json['updated_at']?.toString() ?? '',
      deletedAt: json['deleted_at']?.toString(),
    );
  }

  /// 🔥 TO JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'images': images, // ✅ no need jsonEncode (better)
      'created_by': createdBy,
      'updated_by': updatedBy,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'deleted_at': deletedAt,
    };
  }
}
