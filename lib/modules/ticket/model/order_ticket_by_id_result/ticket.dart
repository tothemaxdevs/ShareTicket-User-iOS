import 'package:json_annotation/json_annotation.dart';

part 'ticket.g.dart';

@JsonSerializable()
class Ticket {
  String? id;
  String? title;
  String? price;
  int? stock;
  @JsonKey(name: 'start_date')
  String? startDate;
  @JsonKey(name: 'end_date')
  String? endDate;
  @JsonKey(name: 'event_id')
  String? eventId;

  Ticket({
    this.id,
    this.title,
    this.price,
    this.stock,
    this.startDate,
    this.endDate,
    this.eventId,
  });

  @override
  String toString() {
    return 'Ticket(id: $id, title: $title, price: $price, stock: $stock, startDate: $startDate, endDate: $endDate, eventId: $eventId)';
  }

  factory Ticket.fromJson(Map<String, dynamic> json) {
    return _$TicketFromJson(json);
  }

  Map<String, dynamic> toJson() => _$TicketToJson(this);

  Ticket copyWith({
    String? id,
    String? title,
    String? price,
    int? stock,
    String? startDate,
    String? endDate,
    String? eventId,
  }) {
    return Ticket(
      id: id ?? this.id,
      title: title ?? this.title,
      price: price ?? this.price,
      stock: stock ?? this.stock,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      eventId: eventId ?? this.eventId,
    );
  }
}
