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
      cityId: json['city_id'] as String?,
      categoryId: json['category_id'] as String?,
      term: json['term'] as String?,
      address: json['address'] as String?,
      lat: json['lat'] as String?,
      banner: json['banner'] as String?,
      stage:
          (json['stage'] as List<dynamic>?)?.map((e) => e as String).toList(),
      lng: json['lng'] as String?,
      vendorId: json['vendor_id'],
      category: json['category'] == null
          ? null
          : Category.fromJson(json['category'] as Map<String, dynamic>),
      createdBy: json['created_by'] == null
          ? null
          : CreatedBy.fromJson(json['created_by'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$EventToJson(Event instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'date': instance.date?.toIso8601String(),
      'end_date': instance.endDate?.toIso8601String(),
      'city_id': instance.cityId,
      'category_id': instance.categoryId,
      'term': instance.term,
      'address': instance.address,
      'lat': instance.lat,
      'banner': instance.banner,
      'stage': instance.stage,
      'lng': instance.lng,
      'vendor_id': instance.vendorId,
      'category': instance.category,
      'created_by': instance.createdBy,
    };
