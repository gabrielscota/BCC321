import 'entities.dart';

class ProductEntity {
  final String id;
  final String name;
  final String description;
  final int price;
  final int stockQuantity;
  final bool isFavorited;
  final List<RatingEntity> ratings;
  final String shopName;

  ProductEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.stockQuantity,
    this.isFavorited = false,
    this.ratings = const [],
    required this.shopName,
  });

  ProductEntity copyWith({
    String? id,
    String? name,
    String? description,
    int? price,
    int? stockQuantity,
    bool? isFavorited,
    List<RatingEntity>? ratings,
    String? shopName,
  }) {
    return ProductEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      stockQuantity: stockQuantity ?? this.stockQuantity,
      isFavorited: isFavorited ?? this.isFavorited,
      ratings: ratings ?? this.ratings,
      shopName: shopName ?? this.shopName,
    );
  }
}
