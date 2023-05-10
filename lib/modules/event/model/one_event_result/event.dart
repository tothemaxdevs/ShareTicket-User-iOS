import 'package:json_annotation/json_annotation.dart';

import 'category.dart';
import 'created_by.dart';
import 'payment_method.dart';
import 'ticket.dart';

part 'event.g.dart';

@JsonSerializable()
class Event {
  String? id;
  String? title;
  DateTime? date;
  @JsonKey(name: 'end_date')
  DateTime? endDate;
  @JsonKey(name: 'start_time')
  String? startTime;
  @JsonKey(name: 'end_time')
  String? endTime;
  @JsonKey(name: 'city_id')
  String? cityId;
  @JsonKey(name: 'category_id')
  String? categoryId;
  String? description;
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
  List<Ticket>? ticket;
  @JsonKey(name: 'payment_method')
  List<PaymentMethod>? paymentMethod;

  Event({
    this.id,
    this.title,
    this.date,
    this.endDate,
    this.startTime,
    this.endTime,
    this.cityId,
    this.categoryId,
    this.description,
    this.term,
    this.address,
    this.lat,
    this.banner,
    this.stage,
    this.lng,
    this.vendorId,
    this.category,
    this.createdBy,
    this.ticket,
    this.paymentMethod,
  });

  @override
  String toString() {
    return 'Event(id: $id, title: $title, date: $date, endDate: $endDate, startTime: $startTime, endTime: $endTime, cityId: $cityId, categoryId: $categoryId, description: $description, term: $term, address: $address, lat: $lat, banner: $banner, stage: $stage, lng: $lng, vendorId: $vendorId, category: $category, createdBy: $createdBy, ticket: $ticket, paymentMethod: $paymentMethod)';
  }

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);

  Map<String, dynamic> toJson() => _$EventToJson(this);

  Event copyWith({
    String? id,
    String? title,
    DateTime? date,
    DateTime? endDate,
    String? startTime,
    String? endTime,
    String? cityId,
    String? categoryId,
    String? description,
    String? term,
    String? address,
    String? lat,
    String? banner,
    List<String>? stage,
    String? lng,
    dynamic vendorId,
    Category? category,
    CreatedBy? createdBy,
    List<Ticket>? ticket,
    List<PaymentMethod>? paymentMethod,
  }) {
    return Event(
      id: id ?? this.id,
      title: title ?? this.title,
      date: date ?? this.date,
      endDate: endDate ?? this.endDate,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      cityId: cityId ?? this.cityId,
      categoryId: categoryId ?? this.categoryId,
      description: description ?? this.description,
      term: term ?? this.term,
      address: address ?? this.address,
      lat: lat ?? this.lat,
      banner: banner ?? this.banner,
      stage: stage ?? this.stage,
      lng: lng ?? this.lng,
      vendorId: vendorId ?? this.vendorId,
      category: category ?? this.category,
      createdBy: createdBy ?? this.createdBy,
      ticket: ticket ?? this.ticket,
      paymentMethod: paymentMethod ?? this.paymentMethod,
    );
  }
}
