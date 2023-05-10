// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_group_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventGroupResult _$EventGroupResultFromJson(Map<String, dynamic> json) =>
    EventGroupResult(
      eventGroups: (json['event_groups'] as List<dynamic>?)
          ?.map((e) => EventGroup.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$EventGroupResultToJson(EventGroupResult instance) =>
    <String, dynamic>{
      'event_groups': instance.eventGroups,
    };
