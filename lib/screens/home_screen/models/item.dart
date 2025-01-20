class ItemModel {
  final String id;
  final String name;
  final double price;
  final double rating;
  final List<String> imageUrls;

  ItemModel({
    required this.id,
    required this.name,
    required this.price,
    required this.rating,
    required this.imageUrls,
  });

  factory ItemModel.fromMap(Map<String, dynamic> map) {
    print(map);
    return ItemModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      price: (map['price'] ?? 0.0).toDouble(),
      rating: (map['rating'] ?? 4.5).toDouble(),
      imageUrls: List<String>.from(map['imageUrls'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'rating': rating,
      'imageUrls': imageUrls,
    };
  }
}
