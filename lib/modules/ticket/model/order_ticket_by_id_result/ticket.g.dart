// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ticket _$TicketFromJson(Map<String, dynamic> json) => Ticket(
      id: json['id'] as String?,
      title: json['title'] as String?,
      price: json['price'] as String?,
      stock: json['stock'] as int?,
      startDate: json['start_date'] as String?,
      endDate: json['end_date'] as String?,
      eventId: json['event_id'] as String?,
    );

Map<String, dynamic> _$TicketToJson(Ticket instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'price': instance.price,
      'stock': instance.stock,
      'start_date': instance.startDate,
      'end_date': instance.endDate,
      'event_id': instance.eventId,
    };
