part of 'event_bloc.dart';

@immutable
abstract class EventsEvent {
  const EventsEvent();
}

class GetOneEventEvent extends EventsEvent {
  String eventId;
  GetOneEventEvent(this.eventId);
}

class GetVaEvent extends EventsEvent {
  Map<String, dynamic>? params;
  GetVaEvent(this.params);
}

class CreateOrderEvent extends EventsEvent {
  Map<String, dynamic>? params;
  CreateOrderEvent(this.params);
}

class GetPaymentEvent extends EventsEvent {
  Map<String, dynamic>? params;
  GetPaymentEvent(this.params);
}

class GetPaymentStatusEvent extends EventsEvent {
  final String? orderId;
  GetPaymentStatusEvent(this.orderId);
}

class PostUpdateStatusEvent extends EventsEvent {
  final String? orderId;
  PostUpdateStatusEvent(this.orderId);
}

class CancelPreviousOrderEvent extends EventsEvent {
  final String? orderId;
  Map<String, dynamic>? params;
  CancelPreviousOrderEvent(this.orderId);
}

class GetVoucherDetailEvent extends EventsEvent {
  final String? voucer;
  const GetVoucherDetailEvent(this.voucer);
}
