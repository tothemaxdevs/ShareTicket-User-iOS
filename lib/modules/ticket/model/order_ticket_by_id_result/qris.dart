import 'package:json_annotation/json_annotation.dart';

part 'qris.g.dart';

@JsonSerializable()
class Qris {
  String? id;
  @JsonKey(name: 'user_id')
  String? userId;
  @JsonKey(name: 'order_id')
  String? orderId;
  @JsonKey(name: 'qris_id')
  String? qrisId;
  @JsonKey(name: 'external_id')
  String? externalId;
  String? amount;
  @JsonKey(name: 'qr_string')
  String? qrString;
  @JsonKey(name: 'callback_url')
  String? callbackUrl;
  String? description;
  String? type;
  String? status;
  @JsonKey(name: 'created_at')
  DateTime? createdAt;
  @JsonKey(name: 'updated_at')
  DateTime? updatedAt;
  @JsonKey(name: 'created_by')
  String? createdBy;
  @JsonKey(name: 'updated_by')
  dynamic updatedBy;

  Qris({
    this.id,
    this.userId,
    this.orderId,
    this.qrisId,
    this.externalId,
    this.amount,
    this.qrString,
    this.callbackUrl,
    this.description,
    this.type,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.createdBy,
    this.updatedBy,
  });

  @override
  String toString() {
    return 'Qris(id: $id, userId: $userId, orderId: $orderId, qrisId: $qrisId, externalId: $externalId, amount: $amount, qrString: $qrString, callbackUrl: $callbackUrl, description: $description, type: $type, status: $status, createdAt: $createdAt, updatedAt: $updatedAt, createdBy: $createdBy, updatedBy: $updatedBy)';
  }

  factory Qris.fromJson(Map<String, dynamic> json) => _$QrisFromJson(json);

  Map<String, dynamic> toJson() => _$QrisToJson(this);

  Qris copyWith({
    String? id,
    String? userId,
    String? orderId,
    String? qrisId,
    String? externalId,
    String? amount,
    String? qrString,
    String? callbackUrl,
    String? description,
    String? type,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? createdBy,
    dynamic updatedBy,
  }) {
    return Qris(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      orderId: orderId ?? this.orderId,
      qrisId: qrisId ?? this.qrisId,
      externalId: externalId ?? this.externalId,
      amount: amount ?? this.amount,
      qrString: qrString ?? this.qrString,
      callbackUrl: callbackUrl ?? this.callbackUrl,
      description: description ?? this.description,
      type: type ?? this.type,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      createdBy: createdBy ?? this.createdBy,
      updatedBy: updatedBy ?? this.updatedBy,
    );
  }
}
