// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_version.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppVersion _$AppVersionFromJson(Map<String, dynamic> json) => AppVersion(
      id: json['id'] as String?,
      version: json['version'] as String?,
      description: json['description'] as String?,
      skip: json['skip'] as bool?,
      appType: json['app_type'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      createdBy: json['created_by'] as String?,
      updatedBy: json['updated_by'],
      deletedAt: json['deleted_at'],
    );

Map<String, dynamic> _$AppVersionToJson(AppVersion instance) =>
    <String, dynamic>{
      'id': instance.id,
      'version': instance.version,
      'description': instance.description,
      'skip': instance.skip,
      'app_type': instance.appType,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'created_by': instance.createdBy,
      'updated_by': instance.updatedBy,
      'deleted_at': instance.deletedAt,
    };
