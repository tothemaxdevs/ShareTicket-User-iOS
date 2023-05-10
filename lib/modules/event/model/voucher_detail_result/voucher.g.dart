// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'voucher.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Voucher _$VoucherFromJson(Map<String, dynamic> json) => Voucher(
      id: json['id'] as String?,
      title: json['title'] as String?,
      categoryId: json['category_id'] as String?,
      code: json['code'] as String?,
      startDate: json['start_date'] as String?,
      endDate: json['end_date'] as String?,
      typeVoucher: json['type_voucher'] as String?,
      typeDiscount: json['type_discount'] as String?,
      term: json['term'],
      minimumPurchase: json['minimum_purchase'] as int?,
      totalDiscount: json['total_discount'] as int?,
      maxDiscount: json['max_discount'] as int?,
      maxQuota: json['max_quota'] as int?,
      maxUsed: json['max_used'] as int?,
      totalClaim: json['total_claim'] as int?,
      totalUsed: json['total_used'] as int?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      createdBy: json['created_by'] as String?,
      updatedBy: json['updated_by'],
    );

Map<String, dynamic> _$VoucherToJson(Voucher instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'category_id': instance.categoryId,
      'code': instance.code,
      'start_date': instance.startDate,
      'end_date': instance.endDate,
      'type_voucher': instance.typeVoucher,
      'type_discount': instance.typeDiscount,
      'term': instance.term,
      'minimum_purchase': instance.minimumPurchase,
      'total_discount': instance.totalDiscount,
      'max_discount': instance.maxDiscount,
      'max_quota': instance.maxQuota,
      'max_used': instance.maxUsed,
      'total_claim': instance.totalClaim,
      'total_used': instance.totalUsed,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'created_by': instance.createdBy,
      'updated_by': instance.updatedBy,
    };
