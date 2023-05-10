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
      startTime: json['start_time'] as String?,
      endTime: json['end_time'] as String?,
      cityId: json['city_id'] as String?,
      categoryId: json['category_id'] as String?,
      eventGroupId: json['event_group_id'],
      description: json['description'] as String?,
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
      ticket: json['ticket'] as List<dynamic>?,
      paymentMethod: (json['payment_method'] as List<dynamic>?)
          ?.map((e) => PaymentMethod.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$EventToJson(Event instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'date': instance.date?.toIso8601String(),
      'end_date': instance.endDate?.toIso8601String(),
      'start_time': instance.startTime,
      'end_time': instance.endTime,
      'city_id': instance.cityId,
      'category_id': instance.categoryId,
      'event_group_id': instance.eventGroupId,
      'description': instance.description,
      'term': instance.term,
      'address': instance.address,
      'lat': instance.lat,
      'banner': instance.banner,
      'stage': instance.stage,
      'lng': instance.lng,
      'vendor_id': instance.vendorId,
      'category': instance.category,
      'created_by': instance.createdBy,
      'ticket': instance.ticket,
      'payment_method': instance.paymentMethod,
    };
