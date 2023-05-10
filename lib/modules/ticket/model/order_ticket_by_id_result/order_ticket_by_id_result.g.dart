// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_ticket_by_id_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderTicketByIdResult _$OrderTicketByIdResultFromJson(
        Map<String, dynamic> json) =>
    OrderTicketByIdResult(
      orders: json['orders'] == null
          ? null
          : Orders.fromJson(json['orders'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OrderTicketByIdResultToJson(
        OrderTicketByIdResult instance) =>
    <String, dynamic>{
      'orders': instance.orders,
    };
