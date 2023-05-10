// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'virtual_account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VirtualAccount _$VirtualAccountFromJson(Map<String, dynamic> json) =>
    VirtualAccount(
      id: json['id'] as String?,
      userId: json['user_id'] as String?,
      virtualAccountId: json['virtual_account_id'] as String?,
      externalId: json['external_id'] as String?,
      ownerId: json['owner_id'] as String?,
      name: json['name'] as String?,
      bankCode: json['bank_code'] as String?,
      merchantCode: json['merchant_code'] as String?,
      accountNumber: json['account_number'] as String?,
      expectedAmount: json['expected_amount'] as String?,
      expirationDate: json['expiration_date'] == null
          ? null
          : DateTime.parse(json['expiration_date'] as String),
      status: json['status'] as String?,
      statusPayment: json['status_payment'] as String?,
      currency: json['currency'] as String?,
      country: json['country'] as String?,
      isClosed: json['is_closed'] as String?,
      isSingleUse: json['is_single_use'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      createdBy: json['created_by'],
      updatedBy: json['updated_by'] as String?,
    );

Map<String, dynamic> _$VirtualAccountToJson(VirtualAccount instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'virtual_account_id': instance.virtualAccountId,
      'external_id': instance.externalId,
      'owner_id': instance.ownerId,
      'name': instance.name,
      'bank_code': instance.bankCode,
      'merchant_code': instance.merchantCode,
      'account_number': instance.accountNumber,
      'expected_amount': instance.expectedAmount,
      'expiration_date': instance.expirationDate?.toIso8601String(),
      'status': instance.status,
      'status_payment': instance.statusPayment,
      'currency': instance.currency,
      'country': instance.country,
      'is_closed': instance.isClosed,
      'is_single_use': instance.isSingleUse,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'created_by': instance.createdBy,
      'updated_by': instance.updatedBy,
    };
