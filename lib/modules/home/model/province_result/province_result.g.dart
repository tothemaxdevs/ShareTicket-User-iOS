// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'province_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProvinceResult _$ProvinceResultFromJson(Map<String, dynamic> json) =>
    ProvinceResult(
      provinces: (json['provinces'] as List<dynamic>?)
          ?.map((e) => Province.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProvinceResultToJson(ProvinceResult instance) =>
    <String, dynamic>{
      'provinces': instance.provinces,
    };
