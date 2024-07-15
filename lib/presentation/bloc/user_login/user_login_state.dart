part of 'user_login_bloc.dart';

abstract class UserLoginState {}

class UserLoginInitialState extends UserLoginState {}

class UserLoginLoadingState extends UserLoginState {}

class UserLoginSuccessState extends UserLoginState {
  // final String accessToken;
  // final String refreshToken;
  // UserLoginSuccessState(
      // {required this.accessToken, required this.refreshToken});
}

class UserLoginFalirureState extends UserLoginState {
  final String error;
  UserLoginFalirureState({required this.error});
}
class UserSignupState extends UserLoginState{}
class UserForgotPasswordState extends UserLoginState{}
