import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:shareticket/core/auth/model/response_model/response.dart';
import 'package:shareticket/modules/event/model/one_event_result/one_event_result.dart';
import 'package:shareticket/modules/event/model/va_list_result/va_list_result.dart';
import 'package:shareticket/modules/ticket/api/ticket.api.dart';
import 'package:shareticket/modules/ticket/model/order_ticket_by_id_result/order_ticket_by_id_result.dart';
import 'package:shareticket/modules/ticket/model/order_ticket_result/order_ticket_result.dart';

part 'ticket_event.dart';
part 'ticket_state.dart';

class TicketBloc extends Bloc<TicketEvent, TicketState> {
  final TicketApi _ticketApi;
  TicketBloc({TicketApi? api})
      : _ticketApi = api ?? TicketApi(),
        super(TicketBlocInitial()) {
    on<GetTicketOrderEvent>(_getOrderTicket);
    on<GetTicketOrderByIdEvent>(_getOrderTicketById);
    on<PostUpdateStatusEvent>(_onPostUpdateStatus);
    on<PostCancelOrderEvent>(_onPostCancelOrder);
  }

  _getOrderTicket(GetTicketOrderEvent event, Emitter<TicketState> emit) async {
    emit(GetTicketOrderLoadingState());
    try {
      final data = await _ticketApi.getHistory();
      ResponseData responseData = ResponseData.fromJson(data.data);
      OrderTicketResult orderTicketResult =
          OrderTicketResult.fromJson(responseData.data);
      if (orderTicketResult.orders!.isNotEmpty) {
        log('Loaded Order');
        emit(GetTicketOrderLoadedState(orderTicketResult));
      } else {
        log('Empty Order');
        emit(GetTicketOrderEmptyState('Kosong'));
      }
    } on DioError catch (error) {
      log('Error Order');
      emit(GetTicketOrderErrorState(error.message));
    }
  }

  _getOrderTicketById(
      GetTicketOrderByIdEvent event, Emitter<TicketState> emit) async {
    emit(GeTicketOrderByIdLoadingState());
    try {
      final data = await _ticketApi.getHistoryById(id: event.ticketId);
      ResponseData responseData = ResponseData.fromJson(data.data);
      OrderTicketByIdResult orderTicketByIdResult =
          OrderTicketByIdResult.fromJson(responseData.data);

      log('Loaded content');
      emit(GeTicketOrderByIdLoadedState(orderTicketByIdResult));
    } on DioError catch (error) {
      log('Error content');
      emit(GeTicketOrderByIdErrorState(error.message));
    }
  }

  _onPostUpdateStatus(
      PostUpdateStatusEvent event, Emitter<TicketState> emit) async {
    emit(PostUpdateStatusLoadingState());
    try {
      final data = await _ticketApi.postUpdateStatus(id: event.orderId);

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

  _onPostCancelOrder(
      PostCancelOrderEvent event, Emitter<TicketState> emit) async {
    emit(PostCancelOrderLoadingState());
    try {
      final data = await _ticketApi.postCancelOrder(body: event.body);

      if (data.statusCode == 200) {
        emit(PostCancelOrderLoadedState(data));
      } else {
        emit(PostCancelOrderFailedState('Failed'));
      }
    } on DioError catch (error) {
      log('Error content');
      emit(PostCancelOrderErrorState(error.message));
    }
  }
}
