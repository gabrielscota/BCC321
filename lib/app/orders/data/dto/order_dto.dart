import '../../../../core/errors/errors.dart';
import '../../domain/entities/entities.dart';

class OrderDto {
  final String id;
  final String status;
  final String deliveryDate;
  final String paymentMethod;
  final String addressId;
  final String userId;
  final String? couponId;

  OrderDto({
    required this.id,
    required this.status,
    required this.deliveryDate,
    required this.paymentMethod,
    required this.addressId,
    required this.userId,
    this.couponId,
  });

  factory OrderDto.fromMap(Map<String, dynamic> map) {
    try {
      return OrderDto(
        id: map['id'].toString(),
        status: map['status'].toString(),
        deliveryDate: map['delivery_date'].toString(),
        paymentMethod: map['payment_method'].toString(),
        addressId: map['address_id'].toString(),
        userId: map['user_id'].toString(),
        couponId: map['couponId'] != null ? (map['couponId']).toString() : null,
      );
    } catch (e) {
      throw DtoFailure(message: 'Error parsing product from map');
    }
  }

  OrderEntity toEntity() {
    return OrderEntity(
      id: id,
      status: status,
      deliveryDate: DateTime.parse(deliveryDate),
      paymentMethod: paymentMethod,
      addressId: addressId,
      userId: userId,
      couponId: couponId,
    );
  }
}
