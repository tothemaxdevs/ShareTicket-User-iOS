import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:shareticket/core/auth/model/response_model/response.dart';
import 'package:shareticket/modules/account/api/account.api.dart';
import 'package:shareticket/modules/account/model/account_data_result/account_data_result.dart';
import 'package:shareticket/modules/account/model/change_password_result/change_password_result.dart';
import 'package:shareticket/modules/account/model/update_phone_result/update_phone_result.dart';
import 'package:shareticket/modules/account/model/user_account/user_account_result.dart';
import 'package:shareticket/modules/account/model/user_account_list/user_account_list_result.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final AccountApi _accountApi;
  AccountBloc({AccountApi? api})
      : _accountApi = api ?? AccountApi(),
        super(AccountBlocInitial()) {
    on<GetAccountEvent>(_getMe);
    on<GetUserAccountListEvent>(_getUserList);
    on<DeleteUserEvent>(_onDeleteUser);
    on<ChangePasswordEvent>(_onChangePassword);
    on<UpdatePhoneEvent>(_onUpdatePhone);
  }

  _getMe(GetAccountEvent event, Emitter<AccountState> emit) async {
    emit(GetAccountLoadingState());
    try {
      final data = await _accountApi.getMe();
      if (data.statusCode == 200) {
        ResponseData responseData = ResponseData.fromJson(data.data);
        AccountDataResult accountDataResult =
            AccountDataResult.fromJson(responseData.data);
        emit(GetAccountLoadedState(accountDataResult));
      }
    } on DioError catch (error) {
      emit(GetAccountErrorState(error.message));
    }
  }

  // _onLoadFeed(GetFeedEvent event, Emitter<FeedState> emit) async {
  //   emit(FeedLoadingState());
  //   try {
  //     final data = await _api.getPost();
  //     FeedResult _feed = FeedResult.fromJson(data.data);
  //     if (_feed.post!.length != 0) {
  //       print('loaded');
  //       emit(FeedLoadedState(_feed));
  //     } else {
  //       print('empty');
  //       emit(FeedEmptyState('Feed Kosong', _feed));
  //     }
  //   } on DioError catch (error) {
  //     emit(FeedErrorState("${error.message}"));
  //   }
  // }

  _getUserList(
      GetUserAccountListEvent event, Emitter<AccountState> emit) async {
    emit(GetUserAccountListLoadingState());
    try {
      final data = await _accountApi.getUserList();
      ResponseData responseData = ResponseData.fromJson(data.data);
      UserAccountListResult userAccountListResult =
          UserAccountListResult.fromJson(responseData.data);
      if (userAccountListResult.users!.isNotEmpty) {
        log('loaded');
        emit(GetUserAccountListLoadedState(userAccountListResult));
      } else {
        log('empty');
        emit(
            GetUserAccountListEmptyState('Feed Kosong', userAccountListResult));
      }
    } on DioError catch (error) {
      emit(GetUserAccountListErrorState(error.message));
    }
  }

  _onDeleteUser(DeleteUserEvent event, Emitter<AccountState> emit) async {
    emit(DeleteUserAccountLoadingState());
    try {
      final data = await _accountApi.deleteUser(
        id: event.userId,
      );
      emit(DeleteUserAccountLoadedState());
    } on DioError catch (error) {
      emit(DeleteUserAccountErrorState(error.message));
    }
  }

  _onChangePassword(
      ChangePasswordEvent event, Emitter<AccountState> emit) async {
    emit(PostChangePasswordLoadingState());
    try {
      Response data = await _accountApi.postChangePassword(body: event.params);
      log('Ini respon server $data');
      if (data.statusCode == 200) {
        if (data.data['data']['message'] == 'Password changed successfully') {
          log('loaded');
          emit(PostChangePasswordLoadedState(data));
        } else if (data.data['data']['message'] ==
            'Current password is incorrect') {
          log('Failed');
          emit(PostChangePasswordFailedState(data));
        }
      }
    } on DioError catch (error) {
      emit(PostChangePasswordErrorState(error.message));
    }
  }

  _onUpdatePhone(UpdatePhoneEvent event, Emitter<AccountState> emit) async {
    emit(PostUpdatePhoneLoadingState());
    try {
      Response data = await _accountApi.postUpdatePhone(body: event.params);
      log('Ini respon server $data');
      if (data.statusCode == 200) {
        UpdatePhoneResult result = UpdatePhoneResult.fromJson(data.data);

        if (result.code == 200) {
          log('loaded');
          emit(PostUpdatePhoneLoadedState(result));
        } else {
          log('Failed');
          emit(PostUpdatePhoneFailedState(result.message!));
        }
      }
    } on DioError catch (error) {
      emit(PostUpdatePhoneErrorState(error.message));
    }
  }
}
