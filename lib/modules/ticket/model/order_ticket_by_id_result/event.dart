import 'package:json_annotation/json_annotation.dart';

part 'event.g.dart';

@JsonSerializable()
class Event {
  String? id;
  String? title;
  DateTime? date;
  @JsonKey(name: 'end_date')
  DateTime? endDate;
  String? city;
  String? category;
  @JsonKey(name: 'start_time')
  String? startTime;
  @JsonKey(name: 'end_time')
  String? endTime;
  String? description;
  String? term;
  String? address;
  String? lat;
  String? lng;
  String? banner;
  List<String>? stage;
  dynamic vendor;

  Event({
    this.id,
    this.title,
    this.date,
    this.endDate,
    this.city,
    this.category,
    this.startTime,
    this.endTime,
    this.description,
    this.term,
    this.address,
    this.lat,
    this.lng,
    this.banner,
    this.stage,
    this.vendor,
  });

  @override
  String toString() {
    return 'Event(id: $id, title: $title, date: $date, endDate: $endDate, city: $city, category: $category, startTime: $startTime, endTime: $endTime, description: $description, term: $term, address: $address, lat: $lat, lng: $lng, banner: $banner, stage: $stage, vendor: $vendor)';
  }

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);

  Map<String, dynamic> toJson() => _$EventToJson(this);

  Event copyWith({
    String? id,
    String? title,
    DateTime? date,
    DateTime? endDate,
    String? city,
    String? category,
    String? startTime,
    String? endTime,
    String? description,
    String? term,
    String? address,
    String? lat,
    String? lng,
    String? banner,
    List<String>? stage,
    dynamic vendor,
  }) {
    return Event(
      id: id ?? this.id,
      title: title ?? this.title,
      date: date ?? this.date,
      endDate: endDate ?? this.endDate,
      city: city ?? this.city,
      category: category ?? this.category,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      description: description ?? this.description,
      term: term ?? this.term,
      address: address ?? this.address,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      banner: banner ?? this.banner,
      stage: stage ?? this.stage,
      vendor: vendor ?? this.vendor,
    );
  }
}
