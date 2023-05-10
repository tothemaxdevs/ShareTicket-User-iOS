// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) => Order(
      userId: json['user_id'] as String?,
      eventId: json['event_id'] as String?,
      total: json['total'] as int?,
      isPaid: json['is_paid'] as bool?,
      status: json['status'] as String?,
      createdBy: json['created_by'] as String?,
      id: json['id'] as String?,
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'user_id': instance.userId,
      'event_id': instance.eventId,
      'total': instance.total,
      'is_paid': instance.isPaid,
      'status': instance.status,
      'created_by': instance.createdBy,
      'id': instance.id,
      'updated_at': instance.updatedAt?.toIso8601String(),
      'created_at': instance.createdAt?.toIso8601String(),
    };
