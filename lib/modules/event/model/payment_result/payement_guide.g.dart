// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payement_guide.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PayementGuide _$PayementGuideFromJson(Map<String, dynamic> json) =>
    PayementGuide(
      id: json['id'] as String?,
      bankName: json['bank_name'] as String?,
      bankCode: json['bank_code'] as String?,
      icon: json['icon'] as String?,
      paymentAtm: json['payment_atm'] as String?,
      paymentMbanking: json['payment_mbanking'] as String?,
      paymentIbanking: json['payment_ibanking'] as String?,
    );

Map<String, dynamic> _$PayementGuideToJson(PayementGuide instance) =>
    <String, dynamic>{
      'id': instance.id,
      'bank_name': instance.bankName,
      'bank_code': instance.bankCode,
      'icon': instance.icon,
      'payment_atm': instance.paymentAtm,
      'payment_mbanking': instance.paymentMbanking,
      'payment_ibanking': instance.paymentIbanking,
    };
