import '../../../../core/errors/errors.dart';
import '../../domain/entities/entities.dart';
import 'dto.dart';

class ProductDto {
  final String id;
  final String name;
  final String description;
  final String price;
  final int stockQuantity;
  final bool isFavorited;
  final List<RatingDto> ratings;
  final String shopName;

  ProductDto({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.stockQuantity,
    this.isFavorited = false,
    this.ratings = const [],
    required this.shopName,
  });

  factory ProductDto.fromMap(Map<String, dynamic> map) {
    try {
      return ProductDto(
        id: map['id'].toString(),
        name: map['name'] as String,
        description: map['description'] as String,
        price: map['price'].toString(),
        stockQuantity: map['stock_quantity'] as int,
        isFavorited: map['is_favorited'] as bool,
        ratings: map['ratings'] != null ? List<RatingDto>.from(map['ratings'].map((x) => RatingDto.fromMap(x))) : [],
        shopName: map['shop_name'] as String,
      );
    } catch (e) {
      throw DtoFailure(message: 'Error parsing product from map');
    }
  }

  ProductEntity toEntity() {
    return ProductEntity(
      id: id,
      name: name,
      description: description,
      price: int.parse(price),
      stockQuantity: stockQuantity,
      isFavorited: isFavorited,
      ratings: ratings.map((e) => e.toEntity()).toList(),
      shopName: shopName,
    );
  }
}
