part of 'ticket_bloc.dart';

@immutable
abstract class TicketEvent {
  const TicketEvent();
}

class GetTicketOrderEvent extends TicketEvent {}

class GetTicketOrderByIdEvent extends TicketEvent {
  String ticketId;
  GetTicketOrderByIdEvent(this.ticketId);
}

class PostUpdateStatusEvent extends TicketEvent {
  final String? orderId;
  PostUpdateStatusEvent(this.orderId);
}

class PostCancelOrderEvent extends TicketEvent {
  Map<String, dynamic>? body = <String, dynamic>{};
  PostCancelOrderEvent({
    this.body,
  });
}
