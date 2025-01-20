class CategoryModel {
  final String id;
  final String name;
  final List<String> imageUrls;

  CategoryModel({
    required this.id,
    required this.name,
    required this.imageUrls,
  });

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      imageUrls: map['imgUrl'] != null ? List<String>.from(map['imgUrl']) : [],
    );
  }

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel.fromMap(json);
  }
}
