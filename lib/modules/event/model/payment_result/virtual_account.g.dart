// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'virtual_account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VirtualAccount _$VirtualAccountFromJson(Map<String, dynamic> json) =>
    VirtualAccount(
      id: json['id'] as String?,
      accountName: json['account_name'] as String?,
      bankCode: json['bank_code'] as String?,
      xenditId: json['xendit_id'] as String?,
      externalId: json['external_id'] as String?,
      expectedAmount: json['expected_amount'] as String?,
      accountNumber: json['account_number'] as String?,
      expirationDate: json['expiration_date'] as String?,
      orderId: json['order_id'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      createdBy: json['created_by'] as String?,
      updatedBy: json['updated_by'],
    );

Map<String, dynamic> _$VirtualAccountToJson(VirtualAccount instance) =>
    <String, dynamic>{
      'id': instance.id,
      'account_name': instance.accountName,
      'bank_code': instance.bankCode,
      'xendit_id': instance.xenditId,
      'external_id': instance.externalId,
      'expected_amount': instance.expectedAmount,
      'account_number': instance.accountNumber,
      'expiration_date': instance.expirationDate,
      'order_id': instance.orderId,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'created_by': instance.createdBy,
      'updated_by': instance.updatedBy,
    };
