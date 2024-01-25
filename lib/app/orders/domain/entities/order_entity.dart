class OrderEntity {
  final String id;
  final String status;
  final DateTime deliveryDate;
  final String paymentMethod;
  final String addressId;
  final String userId;
  final String? couponId;

  OrderEntity({
    required this.id,
    required this.status,
    required this.deliveryDate,
    required this.paymentMethod,
    required this.addressId,
    required this.userId,
    this.couponId,
  });
}
