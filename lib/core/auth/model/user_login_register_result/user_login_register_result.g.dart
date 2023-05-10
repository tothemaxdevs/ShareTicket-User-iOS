// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_login_register_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserLoginRegisterResult _$UserLoginRegisterResultFromJson(
        Map<String, dynamic> json) =>
    UserLoginRegisterResult(
      success: json['success'] as bool?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserLoginRegisterResultToJson(
        UserLoginRegisterResult instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
    };
