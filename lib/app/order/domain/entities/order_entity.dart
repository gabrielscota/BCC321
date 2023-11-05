import 'package:equatable/equatable.dart';

enum PaymentMethod { cash, card, paypal, applePay, googlePay, samsungPay, other }

class OrderEntity extends Equatable {
  final String id;
  final DateTime date;
  final String status;
  final PaymentMethod paymentMethod;

  const OrderEntity({required this.id, required this.date, required this.status, required this.paymentMethod});

  @override
  List<Object> get props => [id, date, status, paymentMethod];
}
