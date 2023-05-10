// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'virtual_account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VirtualAccount _$VirtualAccountFromJson(Map<String, dynamic> json) =>
    VirtualAccount(
      name: json['name'] as String?,
      code: json['code'] as String?,
      isActivated: json['is_activated'] as bool?,
      statusPayment: json['status_payment'] as String?,
      logo: json['logo'] as String?,
    );

Map<String, dynamic> _$VirtualAccountToJson(VirtualAccount instance) =>
    <String, dynamic>{
      'name': instance.name,
      'code': instance.code,
      'is_activated': instance.isActivated,
      'status_payment': instance.statusPayment,
      'logo': instance.logo,
    };
