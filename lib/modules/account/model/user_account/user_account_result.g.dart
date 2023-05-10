// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_account_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserAccountResult _$UserAccountResultFromJson(Map<String, dynamic> json) =>
    UserAccountResult(
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserAccountResultToJson(UserAccountResult instance) =>
    <String, dynamic>{
      'user': instance.user,
    };
