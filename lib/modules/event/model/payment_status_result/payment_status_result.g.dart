// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_status_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentStatusResult _$PaymentStatusResultFromJson(Map<String, dynamic> json) =>
    PaymentStatusResult(
      order: json['order'] == null
          ? null
          : Order.fromJson(json['order'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PaymentStatusResultToJson(
        PaymentStatusResult instance) =>
    <String, dynamic>{
      'order': instance.order,
    };
