class Product {
  final int id;
  final String name;
  final double price;
  final String category;
  final String image;
  final String description;
  bool isFavourite;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.category,
    required this.image,
    required this.description,
    this.isFavourite = false,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json["id"],
      name: json["name"],
      price: (json["price"] as num).toDouble(),
      category: json["category"],
      image: json["image"],
      description: json["description"],
    );
  }

  Product copyWith({
    int? id,
    String? name,
    double? price,
    String? category,
    String? image,
    String? description,
    bool? isFavourite,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      category: category ?? this.category,
      image: image ?? this.image,
      description: description ?? this.description,
      isFavourite: isFavourite ?? this.isFavourite,
    );
  }
}