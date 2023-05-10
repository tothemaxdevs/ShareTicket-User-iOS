// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventCategory _$EventCategoryFromJson(Map<String, dynamic> json) =>
    EventCategory(
      id: json['id'] as String?,
      name: json['name'] as String?,
      code: json['code'] as String?,
      icon: json['icon'] as String?,
      type: json['type'],
      eventCount: json['event_count'] as int?,
    );

Map<String, dynamic> _$EventCategoryToJson(EventCategory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'code': instance.code,
      'icon': instance.icon,
      'type': instance.type,
      'event_count': instance.eventCount,
    };
