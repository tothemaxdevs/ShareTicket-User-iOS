import 'package:json_annotation/json_annotation.dart';

part 'order.g.dart';

@JsonSerializable()
class Order {
  @JsonKey(name: 'user_id')
  String? userId;
  @JsonKey(name: 'event_id')
  String? eventId;
  int? total;
  @JsonKey(name: 'is_paid')
  bool? isPaid;
  String? status;
  @JsonKey(name: 'created_by')
  String? createdBy;
  String? id;
  @JsonKey(name: 'updated_at')
  DateTime? updatedAt;
  @JsonKey(name: 'created_at')
  DateTime? createdAt;

  Order({
    this.userId,
    this.eventId,
    this.total,
    this.isPaid,
    this.status,
    this.createdBy,
    this.id,
    this.updatedAt,
    this.createdAt,
  });

  @override
  String toString() {
    return 'Order(userId: $userId, eventId: $eventId, total: $total, isPaid: $isPaid, status: $status, createdBy: $createdBy, id: $id, updatedAt: $updatedAt, createdAt: $createdAt)';
  }

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  Map<String, dynamic> toJson() => _$OrderToJson(this);

  Order copyWith({
    String? userId,
    String? eventId,
    int? total,
    bool? isPaid,
    String? status,
    String? createdBy,
    String? id,
    DateTime? updatedAt,
    DateTime? createdAt,
  }) {
    return Order(
      userId: userId ?? this.userId,
      eventId: eventId ?? this.eventId,
      total: total ?? this.total,
      isPaid: isPaid ?? this.isPaid,
      status: status ?? this.status,
      createdBy: createdBy ?? this.createdBy,
      id: id ?? this.id,
      updatedAt: updatedAt ?? this.updatedAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
