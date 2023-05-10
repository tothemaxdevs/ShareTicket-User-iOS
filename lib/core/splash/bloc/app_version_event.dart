part of 'app_version_bloc.dart';

@immutable
abstract class AppVersionEvent extends Equatable {}

class GetAppVersionFromApiEvent extends AppVersionEvent {
  @override
  List<Object?> get props => [];
  Map<String, dynamic> params;
  GetAppVersionFromApiEvent(this.params);
}

class GetAppVersionFromInfoEvent extends AppVersionEvent {
  @override
  List<Object?> get props => [];
}
