import '../../../../core/errors/errors.dart';
import '../../domain/entities/entities.dart';

class SellerDto {
  final String id;
  final String shopName;
  final String description;

  SellerDto({
    required this.id,
    required this.shopName,
    required this.description,
  });

  factory SellerDto.fromMap(Map<String, dynamic> map) {
    try {
      return SellerDto(
        id: map['user_id'] != null ? map['user_id'].toString() : '',
        shopName: map['shop_name'] as String,
        description: map['description'] as String,
      );
    } catch (e) {
      throw DtoFailure(message: 'Error parsing seller from map');
    }
  }

  SellerEntity toEntity() {
    return SellerEntity(
      id: id,
      shopName: shopName,
      description: description,
    );
  }
}
