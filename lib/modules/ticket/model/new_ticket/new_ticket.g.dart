// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_ticket.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewTicket _$NewTicketFromJson(Map<String, dynamic> json) => NewTicket(
      order: json['order'] == null
          ? null
          : Order.fromJson(json['order'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NewTicketToJson(NewTicket instance) => <String, dynamic>{
      'order': instance.order,
    };
