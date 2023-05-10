// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_ticket_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderTicketResult _$OrderTicketResultFromJson(Map<String, dynamic> json) =>
    OrderTicketResult(
      orders: (json['orders'] as List<dynamic>?)
          ?.map((e) => Order.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OrderTicketResultToJson(OrderTicketResult instance) =>
    <String, dynamic>{
      'orders': instance.orders,
    };
