import 'package:json_annotation/json_annotation.dart';

import 'order.dart';

part 'order_ticket_result.g.dart';

@JsonSerializable()
class OrderTicketResult {
  List<Order>? orders;

  OrderTicketResult({this.orders});

  @override
  String toString() => 'OrderTicketResult(orders: $orders)';

  factory OrderTicketResult.fromJson(Map<String, dynamic> json) {
    return _$OrderTicketResultFromJson(json);
  }

  Map<String, dynamic> toJson() => _$OrderTicketResultToJson(this);

  OrderTicketResult copyWith({
    List<Order>? orders,
  }) {
    return OrderTicketResult(
      orders: orders ?? this.orders,
    );
  }
}
