import '../../../../core/errors/errors.dart';
import '../../domain/entities/entities.dart';

class CouponDto {
  final String id;
  final String discountCode;
  final double discountValue;
  final String startDate;
  final String endDate;

  CouponDto({
    required this.id,
    required this.discountCode,
    required this.discountValue,
    required this.startDate,
    required this.endDate,
  });

  factory CouponDto.fromMap(Map<String, dynamic> map) {
    try {
      return CouponDto(
        id: map['id'].toString(),
        discountCode: map['discount_code'] as String,
        discountValue: double.parse(map['discount_value'].toString()),
        startDate: map['start_date'] != null ? map['start_date'] as String : '',
        endDate: map['end_date'] != null ? map['end_date'] as String : '',
      );
    } catch (e) {
      throw DtoFailure(message: 'Error parsing coupon from map');
    }
  }

  CouponEntity toEntity() {
    return CouponEntity(
      id: id,
      discountCode: discountCode,
      discountValue: discountValue,
      startDate: startDate.isNotEmpty ? DateTime.parse(startDate) : null,
      endDate: endDate.isNotEmpty ? DateTime.parse(endDate) : null,
    );
  }
}
