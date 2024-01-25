class CouponEntity {
  final String id;
  final String discountCode;
  final double discountValue;
  final DateTime? startDate;
  final DateTime? endDate;

  CouponEntity({
    required this.id,
    required this.discountCode,
    required this.discountValue,
    required this.startDate,
    required this.endDate,
  });
}
