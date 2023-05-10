import 'dart:async';
import 'package:dio/dio.dart';
import 'package:shareticket/utils/environment/environment.dart';
import 'package:shareticket/utils/services/api_service.dart';

class TicketApi {
  final ApiService _apiService;

  TicketApi() : _apiService = ApiService();
  static const String api = Environment.endpointApi;
  static const String history = 'api/history';

  Future<Response> getHistory() async {
    Response response = await _apiService.get('$api$history');
    return response;
  }

  Future<Response> getHistoryById({id}) async {
    Response response = await _apiService.get('$api$history/$id');
    return response;
  }

  Future<Response> postUpdateStatus({id}) async {
    Response response = await _apiService.get('${api}api/va/callback/$id');
    return response;
  }

  Future<Response> postCancelOrder({body}) async {
    Response response = await _apiService.post('${api}api/order/cancel', body);
    return response;
  }
}
