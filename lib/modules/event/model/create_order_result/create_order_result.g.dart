// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_order_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateOrderResult _$CreateOrderResultFromJson(Map<String, dynamic> json) =>
    CreateOrderResult(
      status: json['status'] as bool?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CreateOrderResultToJson(CreateOrderResult instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
    };
