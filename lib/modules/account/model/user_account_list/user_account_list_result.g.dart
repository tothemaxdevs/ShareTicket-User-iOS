// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_account_list_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserAccountListResult _$UserAccountListResultFromJson(
        Map<String, dynamic> json) =>
    UserAccountListResult(
      users: (json['users'] as List<dynamic>?)
          ?.map((e) => User.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UserAccountListResultToJson(
        UserAccountListResult instance) =>
    <String, dynamic>{
      'users': instance.users,
    };
