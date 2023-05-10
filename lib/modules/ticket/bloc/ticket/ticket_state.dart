part of 'ticket_bloc.dart';

@immutable
abstract class TicketState {}

class TicketBlocInitial extends TicketState {}

class GetTicketOrderLoadingState extends TicketState {
  GetTicketOrderLoadingState();
}

class GetTicketOrderLoadedState extends TicketState {
  final OrderTicketResult data;
  GetTicketOrderLoadedState(this.data);
}

class GetTicketOrderErrorState extends TicketState {
  final String message;
  GetTicketOrderErrorState(this.message);
}

class GetTicketOrderEmptyState extends TicketState {
  final String message;
  GetTicketOrderEmptyState(this.message);
}

class GeTicketOrderByIdLoadingState extends TicketState {
  GeTicketOrderByIdLoadingState();
}

class GeTicketOrderByIdLoadedState extends TicketState {
  final OrderTicketByIdResult data;
  GeTicketOrderByIdLoadedState(this.data);
}

class GeTicketOrderByIdErrorState extends TicketState {
  final String message;
  GeTicketOrderByIdErrorState(this.message);
}

class PostUpdateStatusLoadingState extends TicketState {
  PostUpdateStatusLoadingState();
}

class PostUpdateStatusLoadedState extends TicketState {
  final Response data;
  PostUpdateStatusLoadedState(this.data);
}

class PostUpdateStatusErrorState extends TicketState {
  final String message;
  PostUpdateStatusErrorState(this.message);
}

class PostUpdateStatusFailedState extends TicketState {
  final String message;
  PostUpdateStatusFailedState(this.message);
}

class PostCancelOrderLoadingState extends TicketState {
  PostCancelOrderLoadingState();
}

class PostCancelOrderLoadedState extends TicketState {
  final Response data;
  PostCancelOrderLoadedState(this.data);
}

class PostCancelOrderErrorState extends TicketState {
  final String message;
  PostCancelOrderErrorState(this.message);
}

class PostCancelOrderFailedState extends TicketState {
  final String message;
  PostCancelOrderFailedState(this.message);
}
