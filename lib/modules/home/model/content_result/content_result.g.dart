// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'content_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContentResult _$ContentResultFromJson(Map<String, dynamic> json) =>
    ContentResult(
      contents: (json['contents'] as List<dynamic>?)
          ?.map((e) => Content.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ContentResultToJson(ContentResult instance) =>
    <String, dynamic>{
      'contents': instance.contents,
    };
