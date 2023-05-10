// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'qris.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Qris _$QrisFromJson(Map<String, dynamic> json) => Qris(
      id: json['id'] as String?,
      userId: json['user_id'] as String?,
      orderId: json['order_id'] as String?,
      qrisId: json['qris_id'] as String?,
      externalId: json['external_id'] as String?,
      amount: json['amount'] as String?,
      qrString: json['qr_string'] as String?,
      callbackUrl: json['callback_url'] as String?,
      description: json['description'] as String?,
      type: json['type'] as String?,
      status: json['status'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      createdBy: json['created_by'] as String?,
      updatedBy: json['updated_by'],
    );

Map<String, dynamic> _$QrisToJson(Qris instance) => <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'order_id': instance.orderId,
      'qris_id': instance.qrisId,
      'external_id': instance.externalId,
      'amount': instance.amount,
      'qr_string': instance.qrString,
      'callback_url': instance.callbackUrl,
      'description': instance.description,
      'type': instance.type,
      'status': instance.status,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'created_by': instance.createdBy,
      'updated_by': instance.updatedBy,
    };
