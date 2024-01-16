import '../../../../core/errors/errors.dart';
import '../../domain/entities/entities.dart';

class ProductDto {
  final String id;
  final String name;
  final String description;
  final String price;

  ProductDto({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
  });

  factory ProductDto.fromMap(Map<String, dynamic> map) {
    try {
      return ProductDto(
        id: map['id'].toString(),
        name: map['name'] as String,
        description: map['description'] as String,
        price: map['price'].toString(),
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
      price: price,
    );
  }
}
