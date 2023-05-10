// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ticket _$TicketFromJson(Map<String, dynamic> json) => Ticket(
      id: json['id'] as String?,
      title: json['title'] as String?,
      price: json['price'] as String?,
      startDate: json['start_date'] as String?,
      endDate: json['end_date'] as String?,
      eventId: json['event_id'] as String?,
      rememberToken: json['remember_token'],
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      createdBy: json['created_by'],
      updatedBy: json['updated_by'],
      orderAmount: json['order_amount'] as int?,
      stock: json['stock'] as int?,
    );

Map<String, dynamic> _$TicketToJson(Ticket instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'price': instance.price,
      'start_date': instance.startDate,
      'end_date': instance.endDate,
      'event_id': instance.eventId,
      'remember_token': instance.rememberToken,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'created_by': instance.createdBy,
      'updated_by': instance.updatedBy,
      'order_amount': instance.orderAmount,
      'stock': instance.stock,
    };
