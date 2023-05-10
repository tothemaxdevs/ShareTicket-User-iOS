// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'content.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Content _$ContentFromJson(Map<String, dynamic> json) => Content(
      id: json['id'] as String?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      descriptionText: json['description_text'] as String?,
      type: json['type'] as String?,
      price: json['price'],
      thumbnail: json['thumbnail'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$ContentToJson(Content instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'description_text': instance.descriptionText,
      'type': instance.type,
      'price': instance.price,
      'thumbnail': instance.thumbnail,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt?.toIso8601String(),
    };
