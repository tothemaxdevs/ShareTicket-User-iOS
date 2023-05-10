import 'package:shareticket/modules/event/model/one_event_result/ticket.dart';

class OrderModel {
  final String? proudctid;
  final int? amount;
  final Ticket? ticket;

  OrderModel({
    this.proudctid,
    this.amount,
    this.ticket,
  });
}

class SubtotalModel {
  final String? title;
  final int? total;
  final String? ticketId;
  final int orderAmount;

  SubtotalModel({
    this.title,
    this.total,
    this.ticketId,
    required this.orderAmount,
  });
}
