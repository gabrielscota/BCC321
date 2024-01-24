import '../../../../core/errors/errors.dart';
import '../../domain/entities/entities.dart';

class ProductDto {
  final String id;
  final String name;
  final String description;
  final String price;
  final int stockQuantity;

  ProductDto({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.stockQuantity,
  });

  factory ProductDto.fromMap(Map<String, dynamic> map) {
    try {
      return ProductDto(
        id: map['id'].toString(),
        name: map['name'] as String,
        description: map['description'] as String,
        price: map['price'].toString(),
        stockQuantity: map['stock_quantity'] as int,
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
    );
  }
}
