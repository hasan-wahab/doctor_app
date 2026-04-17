class AllPackagesModel {
  int? id;
  String? name;
  int? sessions;
  String? price;
  String? image;
  int? createdBy;
  int? updatedBy;
  int? deletedAt;
  String? createdAt;
  String? updatedAt;

  AllPackagesModel({
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

  AllPackagesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    sessions = json['sessions'];
    price = json['price'];
    image = json['image'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['sessions'] = this.sessions;
    data['price'] = this.price;
    data['image'] = this.image;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
