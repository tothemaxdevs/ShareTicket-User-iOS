// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orders.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Orders _$OrdersFromJson(Map<String, dynamic> json) => Orders(
      id: json['id'] as String?,
      total: json['total'] as int?,
      discount: json['discount'] as int?,
      subtotal: json['subtotal'] as int?,
      code: json['code'] as String?,
      isPaid: json['is_paid'] as bool?,
      status: json['status'] as String?,
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      event: json['event'] == null
          ? null
          : Event.fromJson(json['event'] as Map<String, dynamic>),
      virtualAccount: json['virtual_account'] == null
          ? null
          : VirtualAccount.fromJson(
              json['virtual_account'] as Map<String, dynamic>),
      qris: json['qris'] == null
          ? null
          : Qris.fromJson(json['qris'] as Map<String, dynamic>),
      orderDetail: (json['order_detail'] as List<dynamic>?)
          ?.map((e) => OrderDetail.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OrdersToJson(Orders instance) => <String, dynamic>{
      'id': instance.id,
      'total': instance.total,
      'subtotal': instance.subtotal,
      'discount': instance.discount,
      'code': instance.code,
      'is_paid': instance.isPaid,
      'status': instance.status,
      'user': instance.user,
      'event': instance.event,
      'virtual_account': instance.virtualAccount,
      'qris': instance.qris,
      'order_detail': instance.orderDetail,
    };
