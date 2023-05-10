part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {
  const HomeEvent();
}

class GetCategoryEvent extends HomeEvent {
  Map<String, dynamic>? params;
  GetCategoryEvent(this.params);
}

class GetEventGroupEvent extends HomeEvent {
  Map<String, dynamic>? params;
  GetEventGroupEvent(this.params);
}

class GetEventEvent extends HomeEvent {
  Map<String, dynamic>? params;
  GetEventEvent(this.params);
}

class GetListWidgetEventEvent extends HomeEvent {
  Map<String, dynamic>? params;
  GetListWidgetEventEvent(this.params);
}

class GetContentEvent extends HomeEvent {
  Map<String, dynamic>? params;
  GetContentEvent(this.params);
}

class GetCityEvent extends HomeEvent {
  Map<String, dynamic>? params;
  GetCityEvent(this.params);
}

class GetProvinceEvent extends HomeEvent {
  Map<String, dynamic>? params;
  GetProvinceEvent(this.params);
}
