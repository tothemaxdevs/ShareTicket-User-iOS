// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentResult _$PaymentResultFromJson(Map<String, dynamic> json) =>
    PaymentResult(
      payementGuide: json['payement_guide'] == null
          ? null
          : PayementGuide.fromJson(
              json['payement_guide'] as Map<String, dynamic>),
      virtualAccount: json['virtual_account'] == null
          ? null
          : VirtualAccount.fromJson(
              json['virtual_account'] as Map<String, dynamic>),
      qris: json['qris'] == null
          ? null
          : Qris.fromJson(json['qris'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PaymentResultToJson(PaymentResult instance) =>
    <String, dynamic>{
      'payement_guide': instance.payementGuide,
      'virtual_account': instance.virtualAccount,
      'qris': instance.qris,
    };
