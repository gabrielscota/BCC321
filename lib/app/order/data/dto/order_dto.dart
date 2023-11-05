class OrderDto {
  final String id;
  final DateTime date;
  final String status;
  final String paymentMethod;

  OrderDto({required this.id, required this.date, required this.status, required this.paymentMethod});

  factory OrderDto.fromMap(Map<String, dynamic> json) {
    return OrderDto(
      id: json['id'],
      date: DateTime.parse(json['date']),
      status: json['status'],
      paymentMethod: json['paymentMethod'],
    );
  }

  Map toMap() => {
        'id': id,
        'date': date.toIso8601String(),
        'status': status,
        'paymentMethod': paymentMethod,
      };
}
