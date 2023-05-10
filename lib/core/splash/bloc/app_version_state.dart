part of 'app_version_bloc.dart';

@immutable
abstract class AppVersionState extends Equatable {}

class AppVersionInitialState extends AppVersionState {
  @override
  List<Object?> get props => [];
}

// class AppVersionLoadingState extends AppVersionState {
//   @override
//   List<Object?> get props => [];
// }

class AppVersionLoadedState extends AppVersionState {
  AppVersion appVersion;
  AppVersionLoadedState(this.appVersion);
  @override
  List<Object?> get props => [appVersion];
}

// class AppVersionEmptyState extends AppVersionState {
//   @override
//   List<Object?> get props => [];
// }

class AppVersionNoConnectionState extends AppVersionState {
  @override
  List<Object?> get props => [];
}

class AppVersionErrorState extends AppVersionState {
  String message;
  AppVersionErrorState(this.message);
  @override
  List<Object?> get props => [message];
}

class AppVersionInfoLoadedState extends AppVersionState {
  String appVersion;
  AppVersionInfoLoadedState(this.appVersion);
  @override
  List<Object?> get props => [appVersion];
}

class AppVersionInfoEmptyState extends AppVersionState {
  @override
  List<Object?> get props => [];
}
