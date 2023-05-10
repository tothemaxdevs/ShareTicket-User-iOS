part of 'event_bloc.dart';

@immutable
abstract class EventsState {}

class EventsBlocInitial extends EventsState {}

class GetOneEventLoadingState extends EventsState {
  GetOneEventLoadingState();
}

class GetOneEventLoadedState extends EventsState {
  final OneEventResult data;
  GetOneEventLoadedState(this.data);
}

class GetOneEventErrorState extends EventsState {
  final String message;
  GetOneEventErrorState(this.message);
}

class GetPaymentMethodLoadingState extends EventsState {
  GetPaymentMethodLoadingState();
}

class GetPaymentMethodLoadedState extends EventsState {
  final VaListResult data;
  GetPaymentMethodLoadedState(this.data);
}

class GetPaymentMethodErrorState extends EventsState {
  final String message;
  GetPaymentMethodErrorState(this.message);
}

class GetPaymentMethodEmptyState extends EventsState {
  final String message;
  GetPaymentMethodEmptyState(this.message);
}

class CreateOrderLoadingState extends EventsState {
  CreateOrderLoadingState();
}

class CreateOrderLoadedState extends EventsState {
  String data;
  CreateOrderLoadedState(this.data);
}

class CreateOrderFailedState extends EventsState {
  final Response message;
  CreateOrderFailedState(this.message);
}

class CreateOrderErrorState extends EventsState {
  final String message;
  CreateOrderErrorState(this.message);
}

class GetVoucherDetailLoadingState extends EventsState {
  GetVoucherDetailLoadingState();
}

class GetVoucherDetailLoadedState extends EventsState {
  final VoucherDetailResult data;
  GetVoucherDetailLoadedState(this.data);
}

class GetVoucherDetailNotFoundState extends EventsState {
  final String message;
  GetVoucherDetailNotFoundState(this.message);
}

class GetVoucherDetailFailedState extends EventsState {
  final String message;
  GetVoucherDetailFailedState(this.message);
}

class GetVoucherDetailErrorState extends EventsState {
  final String message;
  GetVoucherDetailErrorState(this.message);
}

// class CancelPreviousOrderLoadingState extends EventsState {
//   CancelPreviousOrderLoadingState();
// }

// class CancelPreviousOrderLoadedState extends EventsState {
//   final Response data;
//   CancelPreviousOrderLoadedState(this.data);
// }

// class CancelPreviousOrderFailedState extends EventsState {
//   final Response message;
//   CancelPreviousOrderFailedState(this.message);
// }

// class CancelPreviousOrderErrorState extends EventsState {
//   final String message;
//   CancelPreviousOrderErrorState(this.message);
// }

class GetPaymentLoadingState extends EventsState {
  GetPaymentLoadingState();
}

class GetPaymentLoadedState extends EventsState {
  final PaymentResult data;
  GetPaymentLoadedState(this.data);
}

class GetFailedLoadedState extends EventsState {
  final String? data;
  GetFailedLoadedState(this.data);
}

class GetPaymentErrorState extends EventsState {
  final String message;
  GetPaymentErrorState(this.message);
}

class GetPaymentStatusLoadingState extends EventsState {
  GetPaymentStatusLoadingState();
}

class GetPaymentStatusLoadedState extends EventsState {
  final PaymentStatusResult data;
  GetPaymentStatusLoadedState(this.data);
}

class GetPaymentStatusErrorState extends EventsState {
  final String message;
  GetPaymentStatusErrorState(this.message);
}

class PostUpdateStatusLoadingState extends EventsState {
  PostUpdateStatusLoadingState();
}

class PostUpdateStatusLoadedState extends EventsState {
  final Response data;
  PostUpdateStatusLoadedState(this.data);
}

class PostUpdateStatusErrorState extends EventsState {
  final String message;
  PostUpdateStatusErrorState(this.message);
}

class PostUpdateStatusFailedState extends EventsState {
  final String message;
  PostUpdateStatusFailedState(this.message);
}
