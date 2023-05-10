import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shareticket/core/auth/model/response_model/response.dart';
import 'package:shareticket/main.dart';
import 'package:shareticket/modules/home/api/home.api.dart';
import 'package:shareticket/modules/home/model/category_result/category_result.dart';
import 'package:shareticket/modules/home/model/city_result/city_result.dart';
import 'package:shareticket/modules/home/model/content_result/content_result.dart';
import 'package:shareticket/modules/home/model/event_group_result/event_group_result.dart';
import 'package:shareticket/modules/home/model/event_result/event_result.dart';
import 'package:shareticket/modules/home/model/province_result/province_result.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeApi _homeApi;
  HomeBloc({HomeApi? api})
      : _homeApi = api ?? HomeApi(),
        super(HomeBlocInitial()) {
    on<GetCategoryEvent>(_getCategory);
    on<GetEventEvent>(_getEvent);
    on<GetContentEvent>(_getContent);
    on<GetCityEvent>(_getCity);
    on<GetProvinceEvent>(_getProvince);
    on<GetEventGroupEvent>(_getEventGroup);
    on<GetListWidgetEventEvent>(_getEventListWidget);
  }

  _getCategory(GetCategoryEvent event, Emitter<HomeState> emit) async {
    emit(GetEventCategoryLoadingState());
    try {
      final data = await _homeApi.getCategory(param: event.params);

      if (data.statusCode == 200) {
        // log(data.toString());
        ResponseData responseData = ResponseData.fromJson(data.data);
        CategoryResult categoryResult =
            CategoryResult.fromJson(responseData.data);
        if (categoryResult.eventCategories!.isNotEmpty) {
          emit(GetEventCategoryLoadedState(categoryResult));
        } else {
          emit(GetEventCategoryEmtptyState('Category Empty'));
        }
      }
    } on DioError catch (error) {
      emit(GetEventCategoryErrorState(error.message));
    }
  }

  _getEventGroup(GetEventGroupEvent event, Emitter<HomeState> emit) async {
    emit(GetEventGroupLoadingState());
    try {
      final data = await _homeApi.getEventGroup(param: event.params);

      if (data.statusCode == 200) {
        ResponseData responseData = ResponseData.fromJson(data.data);
        EventGroupResult result = EventGroupResult.fromJson(responseData.data);

        if (result.eventGroups!.isNotEmpty) {
          emit(GetEventGroupLoadedState(result));
        } else {
          emit(GetEventGroupEmtptyState('EventGroup Empty'));
        }
      }
    } on DioError catch (error) {
      emit(GetEventGroupErrorState(error.message));
    }
  }

  _getEventListWidget(
      GetListWidgetEventEvent event, Emitter<HomeState> emit) async {
    emit(GetEventListWidgetLoadingState());
    try {
      final data = await _homeApi.getEvent(param: event.params);
      if (data.statusCode == 200) {
        // log(data.toString());
        ResponseData responseData = ResponseData.fromJson(data.data);
        EventResult eventResult = EventResult.fromJson(responseData.data);
        if (eventResult.events!.isNotEmpty) {
          log('Loaded event');
          emit(GetEventListWidgetLoadedState(eventResult));
        } else {
          log('Empty event');
          emit(GetEventListWidgetEmptyState('Empty'));
        }
      }
    } on DioError catch (error) {
      log('Error event');
      emit(GetEventListWidgetErrorState(error.message));
    }
  }

  _getEvent(GetEventEvent event, Emitter<HomeState> emit) async {
    // if (network.isOnline) {
    emit(GetEventLoadingState(
      status: PageMode.loading,
      loadStatus: LoadStatus.loading,
    ));
    log('LOADING');
    try {
      final data = await _homeApi.getEvent(param: event.params);
      ResponseData responseData = ResponseData.fromJson(data.data);
      EventResult result = EventResult.fromJson(responseData.data);
      if (result.events!.isNotEmpty) {
        log('LOADED');
        emit(GetEventLoadedState(data: result, status: PageMode.loaded));
        if (result.pagination!.currentPage! == result.pagination!.totalPages!) {
          log('MAXIMUM');
          emit(GetEventMaximumPageState(loadStatus: LoadStatus.noMore));
        } else {}
      } else {
        log('EMPTY');
        emit(GetEventEmptyState(
          message: data.statusMessage!,
          status: PageMode.empty,
          loadStatus: LoadStatus.noMore,
        ));
      }
    } on DioError catch (error) {
      log('ERROR');
      emit(GetEventErrorState(
          message: error.message,
          status: PageMode.error,
          loadStatus: LoadStatus.failed));
    }
  }

  _getContent(GetContentEvent event, Emitter<HomeState> emit) async {
    emit(GetContentLoadingState());
    try {
      final data = await _homeApi.getContent(param: event.params);

      if (data.statusCode == 200) {
        ResponseData responseData = ResponseData.fromJson(data.data);
        ContentResult contentResult = ContentResult.fromJson(responseData.data);
        if (contentResult.contents!.isNotEmpty) {
          log('Loaded content');
          emit(GetContentLoadedState(contentResult));
        } else {
          log('Empty content');
          emit(GetContentEmtptyState('Empty'));
        }
      }
    } on DioError catch (error) {
      log('Error content');
      emit(GetContentErrorState(error.message));
    }
  }

  _getCity(GetCityEvent event, Emitter<HomeState> emit) async {
    emit(GetCityLoadingState());
    try {
      final data = await _homeApi.getCity(param: event.params);
      ResponseData responseData = ResponseData.fromJson(data.data);
      CityResult cityResult = CityResult.fromJson(responseData.data);
      if (cityResult.cities!.isNotEmpty) {
        log('Loaded City');
        emit(GetCityLoadedState(cityResult));
      } else {
        log('Empty City');
        emit(GetCityEmtptyState('Empty'));
      }
    } on DioError catch (error) {
      log('Error City');
      emit(GetCityErrorState(error.message));
    }
  }

  _getProvince(GetProvinceEvent event, Emitter<HomeState> emit) async {
    emit(GetProvinceLoadingState());
    try {
      final data = await _homeApi.getProvince(param: event.params);
      ResponseData responseData = ResponseData.fromJson(data.data);
      ProvinceResult provinceResult =
          ProvinceResult.fromJson(responseData.data);
      if (provinceResult.provinces!.isNotEmpty) {
        log('Loaded Province');
        emit(GetProvinceLoadedState(provinceResult));
      } else {
        log('Empty Province');
        emit(GetProvinceEmtptyState('Empty'));
      }
    } on DioError catch (error) {
      log('Error Province');
      emit(GetProvinceErrorState(error.message));
    }
  }
}
