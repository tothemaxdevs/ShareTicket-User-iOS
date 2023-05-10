// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'va_list_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VaListResult _$VaListResultFromJson(Map<String, dynamic> json) => VaListResult(
      payment: json['payment'] == null
          ? null
          : Payment.fromJson(json['payment'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$VaListResultToJson(VaListResult instance) =>
    <String, dynamic>{
      'payment': instance.payment,
    };
