// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Event _$EventFromJson(Map<String, dynamic> json) => Event(
      id: json['id'] as String?,
      title: json['title'] as String?,
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      endDate: json['end_date'] == null
          ? null
          : DateTime.parse(json['end_date'] as String),
      city: json['city'] as String?,
      category: json['category'] as String?,
      startTime: json['start_time'] as String?,
      endTime: json['end_time'] as String?,
      description: json['description'] as String?,
      term: json['term'] as String?,
      address: json['address'] as String?,
      lat: json['lat'] as String?,
      lng: json['lng'] as String?,
      banner: json['banner'] as String?,
      stage:
          (json['stage'] as List<dynamic>?)?.map((e) => e as String).toList(),
      vendor: json['vendor'],
    );

Map<String, dynamic> _$EventToJson(Event instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'date': instance.date?.toIso8601String(),
      'end_date': instance.endDate?.toIso8601String(),
      'city': instance.city,
      'category': instance.category,
      'start_time': instance.startTime,
      'end_time': instance.endTime,
      'description': instance.description,
      'term': instance.term,
      'address': instance.address,
      'lat': instance.lat,
      'lng': instance.lng,
      'banner': instance.banner,
      'stage': instance.stage,
      'vendor': instance.vendor,
    };
