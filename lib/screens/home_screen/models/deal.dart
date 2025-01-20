class DealModel {
  final String id;
  final String title;
  final String description;
  final String imageUrl;

  DealModel({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
  });

  factory DealModel.fromMap(Map<String, dynamic> map) {
    return DealModel(
      id: map['id'] ?? '',
      title: map['title'] ?? 'No Title',
      description: map['description'] ?? 'No Description',
      imageUrl: map['imageUrl'] ?? '',
    );
  }

  factory DealModel.fromJson(Map<String, dynamic> json) {
    return DealModel.fromMap(json);
  }
}
