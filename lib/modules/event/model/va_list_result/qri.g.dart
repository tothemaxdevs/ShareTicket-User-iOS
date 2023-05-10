// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'qri.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Qri _$QriFromJson(Map<String, dynamic> json) => Qri(
      name: json['name'] as String?,
      code: json['code'] as String?,
      isActivated: json['is_activated'] as bool?,
      statusPayment: json['status_payment'] as String?,
      logo: json['logo'] as String?,
    );

Map<String, dynamic> _$QriToJson(Qri instance) => <String, dynamic>{
      'name': instance.name,
      'code': instance.code,
      'is_activated': instance.isActivated,
      'status_payment': instance.statusPayment,
      'logo': instance.logo,
    };
