// ─────────────────────────────────────────────────────────────────────────────
// all_packages_model.dart
// Full null-safe model — fromJson / toJson
// App will NEVER crash on null fields
// ─────────────────────────────────────────────────────────────────────────────

// ─────────────────────────────────────────────────────────────────────────────
// Helper
// ─────────────────────────────────────────────────────────────────────────────
String _safe(dynamic value) {
  if (value == null) return 'No data';
  final str = value.toString().trim();
  return str.isEmpty ? 'No data' : str;
}

// ─────────────────────────────────────────────────────────────────────────────
// PackageItemModel — single package
// ─────────────────────────────────────────────────────────────────────────────
class PackageItemModel {
  final int? id;
  final String? name;
  final int? sessions;
  final String? price;
  final String? image;
  final int? createdBy;
  final int? updatedBy;
  final String? deletedAt;
  final String? createdAt;
  final String? updatedAt;

  PackageItemModel({
    this.id,
    this.name,
    this.sessions,
    this.price,
    this.image,
    this.createdBy,
    this.updatedBy,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  // ── Safe display getters — use in UI, never raw nullable fields ───────────
  String get displayId => id?.toString() ?? 'No data';
  String get displayName => _safe(name);
  String get displaySessions => sessions?.toString() ?? 'No data';
  String get displayPrice => _safe(price).toString();
  String get displayImage => _safe(image);
  String get displayCreatedAt => _safe(createdAt);
  String get displayUpdatedAt => _safe(updatedAt);
  String get displayDeletedAt => _safe(deletedAt);

  // ── Helpers ───────────────────────────────────────────────────────────────
  bool get isDeleted => deletedAt != null;
  bool get hasImage => image != null && image!.trim().isNotEmpty;

  double? get priceAsDouble => price != null ? double.tryParse(price!) : null;

  String get displayFormattedPrice {
    final d = priceAsDouble;
    if (d == null) return 'No data';
    return 'PKR ${d.toStringAsFixed(0)}';
  }

  // ── fromJson ──────────────────────────────────────────────────────────────
  factory PackageItemModel.fromJson(Map<String, dynamic> json) {
    return PackageItemModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      sessions: json['sessions'] as int?,
      price: json['price'] as String?,
      image: json['image'] as String?,
      createdBy: json['created_by'] as int?,
      updatedBy: json['updated_by'] as int?,
      deletedAt: json['deleted_at'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }

  // ── toJson ────────────────────────────────────────────────────────────────
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'sessions': sessions,
    'price': price,
    'image': image,
    'created_by': createdBy,
    'updated_by': updatedBy,
    'deleted_at': deletedAt,
    'created_at': createdAt,
    'updated_at': updatedAt,
  };

  // ── copyWith ──────────────────────────────────────────────────────────────
  PackageItemModel copyWith({
    int? id,
    String? name,
    int? sessions,
    String? price,
    String? image,
    int? createdBy,
    int? updatedBy,
    String? deletedAt,
    String? createdAt,
    String? updatedAt,
  }) {
    return PackageItemModel(
      id: id ?? this.id,
      name: name ?? this.name,
      sessions: sessions ?? this.sessions,
      price: price ?? this.price,
      image: image ?? this.image,
      createdBy: createdBy ?? this.createdBy,
      updatedBy: updatedBy ?? this.updatedBy,
      deletedAt: deletedAt ?? this.deletedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  String toString() =>
      'PackageItemModel(id: $id, name: $name, sessions: $sessions, price: $price)';
}

// ─────────────────────────────────────────────────────────────────────────────
// AllPackagesModel — wraps the full list
// ─────────────────────────────────────────────────────────────────────────────
class AllPackagesModel {
  final List<PackageItemModel> packages;

  AllPackagesModel({required this.packages});

  // ── Helpers ───────────────────────────────────────────────────────────────
  bool get isEmpty => packages.isEmpty;
  int get totalCount => packages.length;

  /// Active packages only (not soft-deleted)
  List<PackageItemModel> get activePackages =>
      packages.where((p) => !p.isDeleted).toList();

  /// Packages with image
  List<PackageItemModel> get packagesWithImage =>
      packages.where((p) => p.hasImage).toList();

  /// Find package by id — returns null if not found
  PackageItemModel? findById(int id) {
    try {
      return packages.firstWhere((p) => p.id == id);
    } catch (_) {
      return null;
    }
  }

  // ── fromJson — parses a JSON array ───────────────────────────────────────
  factory AllPackagesModel.fromJson(List<dynamic> jsonList) {
    final List<PackageItemModel> parsed = jsonList
        .whereType<Map<String, dynamic>>()
        .map((e) => PackageItemModel.fromJson(e))
        .toList();
    return AllPackagesModel(packages: parsed);
  }

  // ── toJson — returns a JSON array ─────────────────────────────────────────
  List<Map<String, dynamic>> toJson() =>
      packages.map((p) => p.toJson()).toList();

  @override
  String toString() =>
      'AllPackagesModel(totalCount: $totalCount, active: ${activePackages.length})';
}

// ─────────────────────────────────────────────────────────────────────────────
// USAGE EXAMPLE
// ─────────────────────────────────────────────────────────────────────────────
//
//  import 'dart:convert';
//
//  final List<dynamic> rawList = jsonDecode(response.body);
//  final AllPackagesModel allPackages = AllPackagesModel.fromJson(rawList);
//
//  print(allPackages.totalCount);                         // 10
//  print(allPackages.isEmpty);                            // false
//  print(allPackages.activePackages.length);              // 10 (none deleted)
//
//  final PackageItemModel pkg = allPackages.packages[0];
//  print(pkg.displayId);                                  // "1"
//  print(pkg.displayName);                                // "Lumber spine Package ..."
//  print(pkg.displaySessions);                            // "7"
//  print(pkg.displayPrice);                               // "15000.00"
//  print(pkg.displayFormattedPrice);                      // "PKR 15000"
//  print(pkg.displayImage);                               // "No data"  (was null)
//  print(pkg.displayDeletedAt);                           // "No data"  (was null)
//  print(pkg.hasImage);                                   // false
//  print(pkg.isDeleted);                                  // false
//  print(pkg.priceAsDouble);                              // 15000.0
//
//  // Find by ID — null safe
//  final PackageItemModel? found = allPackages.findById(5);
//  print(found?.displayName);                             // "Neck spine Package..."
//
//  final PackageItemModel? notFound = allPackages.findById(999);
//  print(notFound?.displayName);                          // null — no crash
//
//  // Back to JSON:
//  final List<Map<String, dynamic>> backToJson = allPackages.toJson();
// ─────────────────────────────────────────────────────────────────────────────
