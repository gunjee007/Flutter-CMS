import 'dart:ffi';

class Content {
  final int id;
  final String title;
  final String description;
  final double discountPercentage;
  final double rating;
  final int stock;
  final int price;
  final String brand;
  final String thumbnail;
  final List<dynamic> images;

  const Content(
      {required this.id,
      required this.title,
      required this.description,
      required this.discountPercentage,
      required this.rating,
      required this.stock,
      required this.price,
      required this.brand,
      required this.thumbnail,
      required this.images});

  factory Content.fromJson(Map<String, dynamic> json) {
    return Content(
      id: json['id'] as int,
      title: json['title'] as String,
      brand: json['brand'] as String,
      description: json['description'] as String,
      discountPercentage: json['discountPercentage'] as double,
      images: json['images'] as List<dynamic>,
      price: json['price'] as int,
      rating: json['rating'] as double,
      stock: json['stock'] as int,
      thumbnail: json['thumbnail'] as String,
    );
  }
}
