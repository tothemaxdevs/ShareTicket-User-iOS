part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class HomeBlocInitial extends HomeState {}

class GetEventCategoryLoadingState extends HomeState {
  GetEventCategoryLoadingState();
}

class GetEventCategoryLoadedState extends HomeState {
  final CategoryResult data;
  GetEventCategoryLoadedState(this.data);
}

class GetEventCategoryErrorState extends HomeState {
  final String message;
  GetEventCategoryErrorState(this.message);
}

class GetEventCategoryEmtptyState extends HomeState {
  final String message;
  GetEventCategoryEmtptyState(this.message);
}

class GetEventGroupLoadingState extends HomeState {
  GetEventGroupLoadingState();
}

class GetEventGroupLoadedState extends HomeState {
  final EventGroupResult data;
  GetEventGroupLoadedState(this.data);
}

class GetEventGroupErrorState extends HomeState {
  final String message;
  GetEventGroupErrorState(this.message);
}

class GetEventGroupEmtptyState extends HomeState {
  final String message;
  GetEventGroupEmtptyState(this.message);
}

class GetEventListWidgetLoadingState extends HomeState {
  GetEventListWidgetLoadingState();
}

class GetEventListWidgetLoadedState extends HomeState {
  final EventResult data;
  GetEventListWidgetLoadedState(this.data);
}

class GetEventListWidgetErrorState extends HomeState {
  final String message;
  GetEventListWidgetErrorState(this.message);
}

class GetEventListWidgetEmptyState extends HomeState {
  final String message;
  GetEventListWidgetEmptyState(this.message);
}

class GetEventLoadingState extends HomeState {
  final LoadStatus? loadStatus;
  final PageMode? status;
  GetEventLoadingState({this.status, this.loadStatus});
}

class GetEventLoadedState extends HomeState {
  final LoadStatus? loadStatus;
  final EventResult? data;
  final PageMode? status;
  GetEventLoadedState({this.data, this.status, this.loadStatus});
}

class GetEventErrorState extends HomeState {
  final LoadStatus? loadStatus;
  final String? message;
  final PageMode? status;
  GetEventErrorState({this.message, this.status, this.loadStatus});
}

class GetEventEmptyState extends HomeState {
  final LoadStatus? loadStatus;
  final String? message;
  final PageMode? status;
  GetEventEmptyState({this.message, this.status, this.loadStatus});
}

class GetEventMaximumPageState extends HomeState {
  final LoadStatus? loadStatus;
  final String? message;
  GetEventMaximumPageState({this.message, this.loadStatus});
}

class GetContentLoadingState extends HomeState {
  GetContentLoadingState();
}

class GetContentLoadedState extends HomeState {
  final ContentResult data;
  GetContentLoadedState(this.data);
}

class GetContentErrorState extends HomeState {
  final String message;
  GetContentErrorState(this.message);
}

class GetContentEmtptyState extends HomeState {
  final String message;
  GetContentEmtptyState(this.message);
}

class GetProvinceLoadingState extends HomeState {
  GetProvinceLoadingState();
}

class GetProvinceLoadedState extends HomeState {
  final ProvinceResult data;
  GetProvinceLoadedState(this.data);
}

class GetProvinceErrorState extends HomeState {
  final String message;
  GetProvinceErrorState(this.message);
}

class GetProvinceEmtptyState extends HomeState {
  final String message;
  GetProvinceEmtptyState(this.message);
}

class GetCityLoadingState extends HomeState {
  GetCityLoadingState();
}

class GetCityLoadedState extends HomeState {
  final CityResult data;
  GetCityLoadedState(this.data);
}

class GetCityErrorState extends HomeState {
  final String message;
  GetCityErrorState(this.message);
}

class GetCityEmtptyState extends HomeState {
  final String message;
  GetCityEmtptyState(this.message);
}
