// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) => Order(
      id: json['id'] as String?,
      total: json['total'] as int?,
      code: json['code'] as String?,
      isPaid: json['is_paid'] as bool?,
      status: json['status'] as String?,
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      event: json['event'] == null
          ? null
          : Event.fromJson(json['event'] as Map<String, dynamic>),
      virtualAccount: json['virtual_account'],
      qris: json['qris'] == null
          ? null
          : Qris.fromJson(json['qris'] as Map<String, dynamic>),
      orderDetail: (json['order_detail'] as List<dynamic>?)
          ?.map((e) => OrderDetail.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'id': instance.id,
      'total': instance.total,
      'code': instance.code,
      'is_paid': instance.isPaid,
      'status': instance.status,
      'user': instance.user,
      'event': instance.event,
      'virtual_account': instance.virtualAccount,
      'qris': instance.qris,
      'order_detail': instance.orderDetail,
    };
