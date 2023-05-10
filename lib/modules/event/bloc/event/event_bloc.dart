import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:shareticket/core/auth/model/response_model/response.dart';
import 'package:shareticket/modules/event/api/event.api.dart';
import 'package:shareticket/modules/event/model/create_order_result/create_order_result.dart';
import 'package:shareticket/modules/event/model/one_event_result/one_event_result.dart';
import 'package:shareticket/modules/event/model/payment_result/payment_result.dart';
import 'package:shareticket/modules/event/model/payment_status_result/payment_status_result.dart';
import 'package:shareticket/modules/event/model/va_list_result/va_list_result.dart';
import 'package:shareticket/modules/event/model/voucher_detail_result/voucher_detail_result.dart';

part 'event_event.dart';
part 'event_state.dart';

class EventBloc extends Bloc<EventsEvent, EventsState> {
  final EventApi _eventApi;
  EventBloc({EventApi? api})
      : _eventApi = api ?? EventApi(),
        super(EventsBlocInitial()) {
    on<GetOneEventEvent>(_getContent);
    on<GetVaEvent>(_getVaList);
    on<CreateOrderEvent>(_onCreateOrder);
    on<GetPaymentEvent>(_onGetPayment);
    on<GetPaymentStatusEvent>(_onGetPaymentStatus);
    on<PostUpdateStatusEvent>(_onPostUpdateStatus);
    on<GetVoucherDetailEvent>(_onGetVoucherDetail);
  }

  _getContent(GetOneEventEvent event, Emitter<EventsState> emit) async {
    emit(GetOneEventLoadingState());
    try {
      final data = await _eventApi.getOneEvent(id: event.eventId);
      ResponseData responseData = ResponseData.fromJson(data.data);
      OneEventResult oneEventResult =
          OneEventResult.fromJson(responseData.data);

      log('Loaded content');
      emit(GetOneEventLoadedState(oneEventResult));
    } on DioError catch (error) {
      log('Error content');
      emit(GetOneEventErrorState(error.message));
    }
  }

  _getVaList(GetVaEvent event, Emitter<EventsState> emit) async {
    emit(GetPaymentMethodLoadingState());
    try {
      final data = await _eventApi.getPaymentMethod(event.params);
      ResponseData responseData = ResponseData.fromJson(data.data);
      VaListResult vaListResult = VaListResult.fromJson(responseData.data);
      if (vaListResult.payment!.virtualAccount == null &&
          vaListResult.payment!.qris == null) {
        log('Empty content');
        emit(GetPaymentMethodEmptyState('Kosong'));
      } else {
        log('Loaded content');
        emit(GetPaymentMethodLoadedState(vaListResult));
      }
    } on DioError catch (error) {
      log('Error content');
      emit(GetPaymentMethodErrorState(error.message));
    }
  }

  _onCreateOrder(CreateOrderEvent event, Emitter<EventsState> emit) async {
    emit(CreateOrderLoadingState());

    try {
      final data = await _eventApi.createOrder(body: event.params);

      // CreateOrderResult result = CreateOrderResult.fromJson(data.data);
      if (data.statusCode == 200) {
        log('LOADED');

        // log('----------------------------');
        // log(data.data.toString());
        // log('----------------------------');

        emit(CreateOrderLoadedState(data.data['data']['order']['id']));
      } else {
        log('FAILED');
        emit(
          CreateOrderFailedState(data),
        );
      }
    } on DioError catch (error) {
      emit(CreateOrderErrorState(error.message));
    }
  }

  _onGetPayment(GetPaymentEvent event, Emitter<EventsState> emit) async {
    emit(GetPaymentLoadingState());
    try {
      final data = await _eventApi.getPayment(params: event.params);

      if (data.statusCode == 200) {
        log('Loaded content');
        ResponseData responseData = ResponseData.fromJson(data.data);
        PaymentResult paymentResult = PaymentResult.fromJson(responseData.data);
        emit(GetPaymentLoadedState(paymentResult));
      } else {
        log('Failed content');
        emit(GetFailedLoadedState('failed'));
      }
    } on DioError catch (error) {
      log('Error content');
      emit(GetPaymentErrorState(error.message));
    }
  }

  _onGetPaymentStatus(
      GetPaymentStatusEvent event, Emitter<EventsState> emit) async {
    emit(GetPaymentStatusLoadingState());
    try {
      final data = await _eventApi.getPaymentStatus(id: event.orderId);
      ResponseData responseData = ResponseData.fromJson(data.data);
      PaymentStatusResult paymentStatusResult =
          PaymentStatusResult.fromJson(responseData.data);

      log('Loaded content');
      emit(GetPaymentStatusLoadedState(paymentStatusResult));
    } on DioError catch (error) {
      log('Error content');
      emit(GetPaymentStatusErrorState(error.message));
    }
  }

  _onPostUpdateStatus(
      PostUpdateStatusEvent event, Emitter<EventsState> emit) async {
    emit(PostUpdateStatusLoadingState());
    try {
      final data = await _eventApi.postUpdateStatus(id: event.orderId);

      if (data.statusCode == 200) {
        emit(PostUpdateStatusLoadedState(data));
      } else {
        emit(PostUpdateStatusFailedState('Failed'));
      }
    } on DioError catch (error) {
      log('Error content');
      emit(PostUpdateStatusErrorState(error.message));
    }
  }

  _onGetVoucherDetail(
      GetVoucherDetailEvent event, Emitter<EventsState> emit) async {
    emit(GetVoucherDetailLoadingState());
    try {
      final data = await _eventApi.getVoucherDetail(voucherCode: event.voucer);

      if (data.statusCode == 200) {
        ResponseData responseData = ResponseData.fromJson(data.data);
        VoucherDetailResult result =
            VoucherDetailResult.fromJson(responseData.data);

        if (result.voucher != null) {
          emit(GetVoucherDetailLoadedState(result));
        } else {
          emit(GetVoucherDetailNotFoundState('Kode voucher tidak ditemukan'));
        }
      } else {
        emit(GetVoucherDetailFailedState('Gagal memuat voucher'));
      }
    } on DioError catch (error) {
      log('Error content');
      emit(GetVoucherDetailErrorState('Error memuat voucher'));
    }
  }
}
