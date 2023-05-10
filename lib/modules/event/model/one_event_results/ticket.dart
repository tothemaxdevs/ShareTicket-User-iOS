import 'package:json_annotation/json_annotation.dart';

part 'ticket.g.dart';

@JsonSerializable()
class Ticket {
  String? id;
  String? title;
  String? price;
  @JsonKey(name: 'start_date')
  String? startDate;
  @JsonKey(name: 'end_date')
  String? endDate;
  @JsonKey(name: 'event_id')
  String? eventId;
  @JsonKey(name: 'remember_token')
  dynamic rememberToken;
  @JsonKey(name: 'created_at')
  DateTime? createdAt;
  @JsonKey(name: 'updated_at')
  DateTime? updatedAt;
  @JsonKey(name: 'created_by')
  dynamic createdBy;
  @JsonKey(name: 'updated_by')
  dynamic updatedBy;
  @JsonKey(name: 'order_amount')
  int? orderAmount;
  int? stock;

  Ticket(
      {this.id,
      this.title,
      this.price,
      this.startDate,
      this.endDate,
      this.eventId,
      this.rememberToken,
      this.createdAt,
      this.updatedAt,
      this.createdBy,
      this.updatedBy,
      this.orderAmount,
      this.stock});

  @override
  String toString() {
    return 'Ticket(id: $id, title: $title, price: $price, startDate: $startDate, endDate: $endDate, eventId: $eventId, rememberToken: $rememberToken, createdAt: $createdAt, updatedAt: $updatedAt, createdBy: $createdBy, updatedBy: $updatedBy, orderAmount: $orderAmount, stock $stock)';
  }

  factory Ticket.fromJson(Map<String, dynamic> json) {
    return _$TicketFromJson(json);
  }

  Map<String, dynamic> toJson() => _$TicketToJson(this);

  Ticket copyWith({
    String? id,
    String? title,
    String? price,
    String? startDate,
    String? endDate,
    String? eventId,
    dynamic rememberToken,
    DateTime? createdAt,
    DateTime? updatedAt,
    dynamic createdBy,
    dynamic updatedBy,
    int? orderAmount,
    int? stock,
  }) {
    return Ticket(
      id: id ?? this.id,
      title: title ?? this.title,
      price: price ?? this.price,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      eventId: eventId ?? this.eventId,
      rememberToken: rememberToken ?? this.rememberToken,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      createdBy: createdBy ?? this.createdBy,
      updatedBy: updatedBy ?? this.updatedBy,
      orderAmount: orderAmount ?? this.orderAmount,
      stock: stock ?? this.stock,
    );
  }
}
