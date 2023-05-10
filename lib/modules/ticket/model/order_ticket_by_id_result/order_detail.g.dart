// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderDetail _$OrderDetailFromJson(Map<String, dynamic> json) => OrderDetail(
      id: json['id'] as String?,
      price: json['price'] as int?,
      totalPrice: json['total_price'] as int?,
      quantity: json['quantity'] as String?,
      ticket: json['ticket'] == null
          ? null
          : Ticket.fromJson(json['ticket'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OrderDetailToJson(OrderDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'price': instance.price,
      'total_price': instance.totalPrice,
      'quantity': instance.quantity,
      'ticket': instance.ticket,
    };
