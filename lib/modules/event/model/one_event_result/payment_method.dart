import 'package:json_annotation/json_annotation.dart';

part 'payment_method.g.dart';

@JsonSerializable()
class PaymentMethod {
  String? id;
  @JsonKey(name: 'event_id')
  String? eventId;
  @JsonKey(name: 'payment_method')
  String? paymentMethod;
  @JsonKey(name: 'created_at')
  DateTime? createdAt;
  @JsonKey(name: 'updated_at')
  DateTime? updatedAt;
  @JsonKey(name: 'created_by')
  String? createdBy;
  @JsonKey(name: 'updated_by')
  dynamic updatedBy;

  PaymentMethod({
    this.id,
    this.eventId,
    this.paymentMethod,
    this.createdAt,
    this.updatedAt,
    this.createdBy,
    this.updatedBy,
  });

  @override
  String toString() {
    return 'PaymentMethod(id: $id, eventId: $eventId, paymentMethod: $paymentMethod, createdAt: $createdAt, updatedAt: $updatedAt, createdBy: $createdBy, updatedBy: $updatedBy)';
  }

  factory PaymentMethod.fromJson(Map<String, dynamic> json) {
    return _$PaymentMethodFromJson(json);
  }

  Map<String, dynamic> toJson() => _$PaymentMethodToJson(this);

  PaymentMethod copyWith({
    String? id,
    String? eventId,
    String? paymentMethod,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? createdBy,
    dynamic updatedBy,
  }) {
    return PaymentMethod(
      id: id ?? this.id,
      eventId: eventId ?? this.eventId,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      createdBy: createdBy ?? this.createdBy,
      updatedBy: updatedBy ?? this.updatedBy,
    );
  }
}
