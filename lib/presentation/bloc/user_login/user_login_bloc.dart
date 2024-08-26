import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart';

import '../../../data/api/auth_repo/auth_service.dart';
import '../../../data/secure_storage/secure_storage.dart';
import '../../../data/shared_preference/shared_preference.dart';

part 'user_login_event.dart';
part 'user_login_state.dart';

class UserLoginBloc extends Bloc<UserLoginEvent, UserLoginState> {
  UserLoginBloc() : super(UserLoginInitialState()) {
    on<UserLoginSubmittedEvent>(onUserLoginsubmitted);
    on<UserSignupEvent>(onUserSignupTap);
    on<UserForgotPasswordEvent>(onUserForgotpasswordTap);
  }
  AuthService service = AuthService();
  SecureStorageService secureStorage = SecureStorageService();
///-----------------------------------------------------
  Future<void> onUserLoginsubmitted(
      UserLoginSubmittedEvent event, Emitter<UserLoginState> emit) async {
    emit(UserLoginLoadingState());
    try {

      Response? response = await service.userLogin(event.email, event.password);
       log('respo  $response');
      if (response != null && response.statusCode == 200) {

        final String accessToken =
            jsonDecode(response.body)['after execution']['AccessToken'];

        final String refreshToken =
            jsonDecode(response.body)['after execution']['RefreshToken'];

        
        await secureStorage.writeSecureStorage('AccessToken', accessToken);
        await secureStorage.writeSecureStorage('RefreshToken', refreshToken);
        await SharedPreference.saveboolValue(true);

        emit(UserLoginSuccessState());

      } else { 

        emit(UserLoginFalirureState(error: 'email and password not match'));

      }
    } catch (e) {
      log(e.toString());

      emit(UserLoginFalirureState(error: e.toString()));
    }
  }
  //-------------------------------------------------------------------

  Future<void> onUserSignupTap(
      UserSignupEvent event, Emitter<UserLoginState> emit) async {
    emit(UserSignupState());
  }
  //-------------------------------------------------------------------

  Future<void> onUserForgotpasswordTap(
      UserForgotPasswordEvent event, Emitter<UserLoginState> emit) async {
    emit(UserForgotPasswordState());
  }
}
 