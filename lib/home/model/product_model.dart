class ProductModel {
  final int id;
  final String title;
  final num price;
  final String description;
  final String category;
  final List <String> images;

  const ProductModel(
      {required this.id,
      required this.title,
      required this.price,
      required this.description,
      required this.category,
      required this.images});

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
        id: json["id"],
        title: json["title"],
        price: json["price"],
        description: json["description"],
        category: json["category"],
        images: List <String>.from (json["images"]));
  }
}
