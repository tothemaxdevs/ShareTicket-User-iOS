// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'city_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CityResult _$CityResultFromJson(Map<String, dynamic> json) => CityResult(
      cities: (json['cities'] as List<dynamic>?)
          ?.map((e) => City.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CityResultToJson(CityResult instance) =>
    <String, dynamic>{
      'cities': instance.cities,
    };
