class Category {

  int? id;

  String categoryName;

  String? description;

  Category({
    this.id,
    required this.categoryName,
    this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "categoryName": categoryName,
      "description": description,
    };
  }

  factory Category.fromMap(
    Map<String, dynamic> map,
  ) {
    return Category(
      id: map["id"],
      categoryName: map["categoryName"],
      description: map["description"],
    );
  }
}