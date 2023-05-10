import 'package:json_annotation/json_annotation.dart';

import 'orders.dart';

part 'order_ticket_by_id_result.g.dart';

@JsonSerializable()
class OrderTicketByIdResult {
  Orders? orders;

  OrderTicketByIdResult({this.orders});

  @override
  String toString() => 'OrderTicketByIdResult(orders: $orders)';

  factory OrderTicketByIdResult.fromJson(Map<String, dynamic> json) {
    return _$OrderTicketByIdResultFromJson(json);
  }

  Map<String, dynamic> toJson() => _$OrderTicketByIdResultToJson(this);

  OrderTicketByIdResult copyWith({
    Orders? orders,
  }) {
    return OrderTicketByIdResult(
      orders: orders ?? this.orders,
    );
  }
}
