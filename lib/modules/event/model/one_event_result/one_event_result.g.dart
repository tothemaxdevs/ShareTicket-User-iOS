// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'one_event_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OneEventResult _$OneEventResultFromJson(Map<String, dynamic> json) =>
    OneEventResult(
      event: json['event'] == null
          ? null
          : Event.fromJson(json['event'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OneEventResultToJson(OneEventResult instance) =>
    <String, dynamic>{
      'event': instance.event,
    };
