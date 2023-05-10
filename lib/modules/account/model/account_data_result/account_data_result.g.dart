// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_data_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountDataResult _$AccountDataResultFromJson(Map<String, dynamic> json) =>
    AccountDataResult(
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AccountDataResultToJson(AccountDataResult instance) =>
    <String, dynamic>{
      'user': instance.user,
    };
