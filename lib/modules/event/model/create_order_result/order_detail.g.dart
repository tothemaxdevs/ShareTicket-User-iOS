// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderDetail _$OrderDetailFromJson(Map<String, dynamic> json) => OrderDetail(
      id: json['id'] as String?,
      orderId: json['order_id'] as String?,
      ticketId: json['ticket_id'] as String?,
      price: json['price'] as int?,
      totalPrice: json['total_price'] as int?,
      quantity: json['quantity'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      createdBy: json['created_by'] as String?,
      updatedBy: json['updated_by'],
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$OrderDetailToJson(OrderDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'order_id': instance.orderId,
      'ticket_id': instance.ticketId,
      'price': instance.price,
      'total_price': instance.totalPrice,
      'quantity': instance.quantity,
      'created_at': instance.createdAt?.toIso8601String(),
      'created_by': instance.createdBy,
      'updated_by': instance.updatedBy,
      'updated_at': instance.updatedAt?.toIso8601String(),
    };
