class ProductModel {
  final int id;
  final String title;
  final num price;
  final String description;
  final String category;
  final List<String> images;
  final String imageUrl;
  final num rating;
  final int count; 

  const ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.images,
    required this.imageUrl,
    required this.rating,
    this.count = 1, 
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json["id"],
      title: json["title"],
      price: json["price"],
      description: json["description"],
      category: json["category"],
      images: List<String>.from(json["images"]),
      imageUrl: json["thumbnail"],
      rating: json["rating"],
    );
  }

  ProductModel copyWith({
    int? id,
    String? title,
    num? price,
    String? description,
    String? category,
    List<String>? images,
    String? imageUrl,
    num? rating,
    int? count,
  }) {
    return ProductModel(
      id: id ?? this.id,
      title: title ?? this.title,
      price: price ?? this.price,
      description: description ?? this.description,
      category: category ?? this.category,
      images: images ?? this.images,
      imageUrl: imageUrl ?? this.imageUrl,
      rating: rating ?? this.rating,
      count: count ?? this.count,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "price": price,
        "description": description,
        "category": category,
        "images": images,
        "thumbnail": imageUrl,
        "rating": rating,
        "count": count,
      };
}

