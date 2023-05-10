import 'package:json_annotation/json_annotation.dart';

import 'order.dart';

part 'new_ticket.g.dart';

@JsonSerializable()
class NewTicket {
  Order? order;

  NewTicket({this.order});

  @override
  String toString() => 'NewTicket(order: $order)';

  factory NewTicket.fromJson(Map<String, dynamic> json) {
    return _$NewTicketFromJson(json);
  }

  Map<String, dynamic> toJson() => _$NewTicketToJson(this);

  NewTicket copyWith({
    Order? order,
  }) {
    return NewTicket(
      order: order ?? this.order,
    );
  }
}
