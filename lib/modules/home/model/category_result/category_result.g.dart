// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryResult _$CategoryResultFromJson(Map<String, dynamic> json) =>
    CategoryResult(
      eventCategories: (json['event_categories'] as List<dynamic>?)
          ?.map((e) => EventCategory.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CategoryResultToJson(CategoryResult instance) =>
    <String, dynamic>{
      'event_categories': instance.eventCategories,
    };
