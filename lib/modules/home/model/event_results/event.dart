import 'package:json_annotation/json_annotation.dart';

import 'category.dart';
import 'created_by.dart';

part 'event.g.dart';

@JsonSerializable()
class Event {
  String? id;
  String? title;
  DateTime? date;
  @JsonKey(name: 'end_date')
  DateTime? endDate;
  @JsonKey(name: 'city_id')
  String? cityId;
  @JsonKey(name: 'category_id')
  String? categoryId;
  String? term;
  String? address;
  String? lat;
  String? banner;
  List<String>? stage;
  String? lng;
  @JsonKey(name: 'vendor_id')
  dynamic vendorId;
  Category? category;
  @JsonKey(name: 'created_by')
  CreatedBy? createdBy;

  Event({
    this.id,
    this.title,
    this.date,
    this.endDate,
    this.cityId,
    this.categoryId,
    this.term,
    this.address,
    this.lat,
    this.banner,
    this.stage,
    this.lng,
    this.vendorId,
    this.category,
    this.createdBy,
  });

  @override
  String toString() {
    return 'Event(id: $id, title: $title, date: $date, endDate: $endDate, cityId: $cityId, categoryId: $categoryId, term: $term, address: $address, lat: $lat, banner: $banner, stage: $stage, lng: $lng, vendorId: $vendorId, category: $category, createdBy: $createdBy)';
  }

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);

  Map<String, dynamic> toJson() => _$EventToJson(this);

  Event copyWith({
    String? id,
    String? title,
    DateTime? date,
    DateTime? endDate,
    String? cityId,
    String? categoryId,
    String? term,
    String? address,
    String? lat,
    String? banner,
    List<String>? stage,
    String? lng,
    dynamic vendorId,
    Category? category,
    CreatedBy? createdBy,
  }) {
    return Event(
      id: id ?? this.id,
      title: title ?? this.title,
      date: date ?? this.date,
      endDate: endDate ?? this.endDate,
      cityId: cityId ?? this.cityId,
      categoryId: categoryId ?? this.categoryId,
      term: term ?? this.term,
      address: address ?? this.address,
      lat: lat ?? this.lat,
      banner: banner ?? this.banner,
      stage: stage ?? this.stage,
      lng: lng ?? this.lng,
      vendorId: vendorId ?? this.vendorId,
      category: category ?? this.category,
      createdBy: createdBy ?? this.createdBy,
    );
  }
}
