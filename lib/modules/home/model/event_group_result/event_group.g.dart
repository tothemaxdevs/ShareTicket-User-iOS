// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventGroup _$EventGroupFromJson(Map<String, dynamic> json) => EventGroup(
      id: json['id'] as String?,
      name: json['name'] as String?,
      code: json['code'] as String?,
      icon: json['icon'] as String?,
      type: json['type'] as String?,
      eventCount: json['event_count'] as int?,
    );

Map<String, dynamic> _$EventGroupToJson(EventGroup instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'code': instance.code,
      'icon': instance.icon,
      'type': instance.type,
      'event_count': instance.eventCount,
    };
