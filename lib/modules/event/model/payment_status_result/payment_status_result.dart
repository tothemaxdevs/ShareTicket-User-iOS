import 'package:json_annotation/json_annotation.dart';

import 'order.dart';

part 'payment_status_result.g.dart';

@JsonSerializable()
class PaymentStatusResult {
  Order? order;

  PaymentStatusResult({this.order});

  @override
  String toString() => 'PaymentStatusResult(order: $order)';

  factory PaymentStatusResult.fromJson(Map<String, dynamic> json) {
    return _$PaymentStatusResultFromJson(json);
  }

  Map<String, dynamic> toJson() => _$PaymentStatusResultToJson(this);

  PaymentStatusResult copyWith({
    Order? order,
  }) {
    return PaymentStatusResult(
      order: order ?? this.order,
    );
  }
}
