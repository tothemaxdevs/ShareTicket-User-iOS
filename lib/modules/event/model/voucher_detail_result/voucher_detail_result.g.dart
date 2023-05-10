// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'voucher_detail_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VoucherDetailResult _$VoucherDetailResultFromJson(Map<String, dynamic> json) =>
    VoucherDetailResult(
      voucher: json['voucher'] == null
          ? null
          : Voucher.fromJson(json['voucher'] as Map<String, dynamic>),
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$VoucherDetailResultToJson(
        VoucherDetailResult instance) =>
    <String, dynamic>{
      'voucher': instance.voucher,
      'user': instance.user,
    };
