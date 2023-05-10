// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventResult _$EventResultFromJson(Map<String, dynamic> json) => EventResult(
      events: (json['events'] as List<dynamic>?)
          ?.map((e) => Event.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$EventResultToJson(EventResult instance) =>
    <String, dynamic>{
      'events': instance.events,
    };
