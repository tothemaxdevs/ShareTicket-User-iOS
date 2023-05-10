import 'dart:async';
import 'package:dio/dio.dart';
import 'package:shareticket/utils/environment/environment.dart';
import 'package:shareticket/utils/services/api_service.dart';

class EventApi {
  final ApiService _apiService;

  EventApi() : _apiService = ApiService();
  static const String api = Environment.endpointApi;
  static const String event = 'api/event';
  static const String vaList = 'api/va/list';
  static const String order = 'api/order';
  static const String payment = 'api/payment-guide';
  static const String voucher = 'api/voucher';

  Future<Response> getOneEvent({id}) async {
    Response response = await _apiService.get('$api$event/$id');
    return response;
  }

  Future<Response> getPayment({params}) async {
    Response response =
        await _apiService.get('$api$payment', queryParam: params);
    return response;
  }

  Future<Response> getPaymentMethod(params) async {
    Response response =
        await _apiService.get('$api$vaList', queryParam: params);
    return response;
  }

  Future<Response> getPaymentStatus({id}) async {
    Response response = await _apiService.get('$api$order/$id');
    return response;
  }

  Future<Response> createOrder({body}) async {
    Response response = await _apiService.post('$api$order', body);
    return response;
  }

  Future<Response> cancelPreviousOrder({body}) async {
    Response response = await _apiService.post('$api$order', body);
    return response;
  }

  Future<Response> postUpdateStatus({id}) async {
    Response response = await _apiService.get('${api}api/va/callback/$id');
    return response;
  }

  Future<Response> getVoucherDetail({voucherCode}) async {
    Response response = await _apiService.get('$api$voucher/$voucherCode');
    return response;
  }
}
