import 'package:json_annotation/json_annotation.dart';

import 'ticket.dart';

part 'order_detail.g.dart';

@JsonSerializable()
class OrderDetail {
  String? id;
  int? price;
  @JsonKey(name: 'total_price')
  int? totalPrice;
  String? quantity;
  Ticket? ticket;

  OrderDetail({
    this.id,
    this.price,
    this.totalPrice,
    this.quantity,
    this.ticket,
  });

  @override
  String toString() {
    return 'OrderDetail(id: $id, price: $price, totalPrice: $totalPrice, quantity: $quantity, ticket: $ticket)';
  }

  factory OrderDetail.fromJson(Map<String, dynamic> json) {
    return _$OrderDetailFromJson(json);
  }

  Map<String, dynamic> toJson() => _$OrderDetailToJson(this);

  OrderDetail copyWith({
    String? id,
    int? price,
    int? totalPrice,
    String? quantity,
    Ticket? ticket,
  }) {
    return OrderDetail(
      id: id ?? this.id,
      price: price ?? this.price,
      totalPrice: totalPrice ?? this.totalPrice,
      quantity: quantity ?? this.quantity,
      ticket: ticket ?? this.ticket,
    );
  }
}
