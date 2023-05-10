import 'package:json_annotation/json_annotation.dart';

part 'order_detail.g.dart';

@JsonSerializable()
class OrderDetail {
  String? id;
  @JsonKey(name: 'order_id')
  String? orderId;
  @JsonKey(name: 'ticket_id')
  String? ticketId;
  int? price;
  @JsonKey(name: 'total_price')
  int? totalPrice;
  String? quantity;
  @JsonKey(name: 'created_at')
  DateTime? createdAt;
  @JsonKey(name: 'created_by')
  String? createdBy;
  @JsonKey(name: 'updated_by')
  dynamic updatedBy;
  @JsonKey(name: 'updated_at')
  DateTime? updatedAt;

  OrderDetail({
    this.id,
    this.orderId,
    this.ticketId,
    this.price,
    this.totalPrice,
    this.quantity,
    this.createdAt,
    this.createdBy,
    this.updatedBy,
    this.updatedAt,
  });

  @override
  String toString() {
    return 'OrderDetail(id: $id, orderId: $orderId, ticketId: $ticketId, price: $price, totalPrice: $totalPrice, quantity: $quantity, createdAt: $createdAt, createdBy: $createdBy, updatedBy: $updatedBy, updatedAt: $updatedAt)';
  }

  factory OrderDetail.fromJson(Map<String, dynamic> json) {
    return _$OrderDetailFromJson(json);
  }

  Map<String, dynamic> toJson() => _$OrderDetailToJson(this);

  OrderDetail copyWith({
    String? id,
    String? orderId,
    String? ticketId,
    int? price,
    int? totalPrice,
    String? quantity,
    DateTime? createdAt,
    String? createdBy,
    dynamic updatedBy,
    DateTime? updatedAt,
  }) {
    return OrderDetail(
      id: id ?? this.id,
      orderId: orderId ?? this.orderId,
      ticketId: ticketId ?? this.ticketId,
      price: price ?? this.price,
      totalPrice: totalPrice ?? this.totalPrice,
      quantity: quantity ?? this.quantity,
      createdAt: createdAt ?? this.createdAt,
      createdBy: createdBy ?? this.createdBy,
      updatedBy: updatedBy ?? this.updatedBy,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
