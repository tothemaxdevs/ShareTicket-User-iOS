// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Payment _$PaymentFromJson(Map<String, dynamic> json) => Payment(
      virtualAccount: (json['virtual_account'] as List<dynamic>?)
          ?.map((e) => VirtualAccount.fromJson(e as Map<String, dynamic>))
          .toList(),
      qris: (json['qris'] as List<dynamic>?)
          ?.map((e) => VirtualAccount.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PaymentToJson(Payment instance) => <String, dynamic>{
      'virtual_account': instance.virtualAccount,
      'qris': instance.qris,
    };
