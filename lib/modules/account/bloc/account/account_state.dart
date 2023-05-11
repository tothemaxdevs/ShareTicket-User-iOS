part of 'account_bloc.dart';

@immutable
abstract class AccountState {}

class AccountBlocInitial extends AccountState {}

class GetAccountLoadingState extends AccountState {
  GetAccountLoadingState();
}

class GetAccountLoadedState extends AccountState {
  final AccountDataResult data;
  GetAccountLoadedState(this.data);
}

class GetAccountErrorState extends AccountState {
  final String message;
  GetAccountErrorState(this.message);
}

class GetUserAccountListLoadingState extends AccountState {
  GetUserAccountListLoadingState();
}

class GetUserAccountListLoadedState extends AccountState {
  final UserAccountListResult data;
  GetUserAccountListLoadedState(this.data);
}

class GetUserAccountListErrorState extends AccountState {
  final String message;
  GetUserAccountListErrorState(this.message);
}

class GetUserAccountListEmptyState extends AccountState {
  final UserAccountListResult data;
  final String message;
  GetUserAccountListEmptyState(this.message, this.data);
}

class PostChangePasswordLoadingState extends AccountState {
  PostChangePasswordLoadingState();
}

class PostChangePasswordLoadedState extends AccountState {
  final Response data;
  PostChangePasswordLoadedState(this.data);
}

class PostChangePasswordErrorState extends AccountState {
  final String message;
  PostChangePasswordErrorState(this.message);
}

class PostChangePasswordFailedState extends AccountState {
  final Response data;
  PostChangePasswordFailedState(this.data);
}

class PostUpdatePhoneLoadingState extends AccountState {
  PostUpdatePhoneLoadingState();
}

class PostUpdatePhoneLoadedState extends AccountState {
  final UpdatePhoneResult data;
  PostUpdatePhoneLoadedState(this.data);
}

class PostUpdatePhoneErrorState extends AccountState {
  final String message;
  PostUpdatePhoneErrorState(this.message);
}

class PostUpdatePhoneFailedState extends AccountState {
  final String message;
  PostUpdatePhoneFailedState(this.message);
}

class PostDeleteUserLoadingState extends AccountState {
  PostDeleteUserLoadingState();
}

class PostDeleteUserLoadedState extends AccountState {
  final Response data;
  PostDeleteUserLoadedState(this.data);
}

class PostDeleteUserErrorState extends AccountState {
  final String message;
  PostDeleteUserErrorState(this.message);
}

class PostDeleteUserFailedState extends AccountState {
  final String message;
  PostDeleteUserFailedState(this.message);
}
