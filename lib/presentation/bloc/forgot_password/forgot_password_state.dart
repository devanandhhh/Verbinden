part of 'forgot_password_bloc.dart';

@immutable
abstract class ForgotPasswordState {}

class ForgotPasswordInitial extends ForgotPasswordState {}

class ForgotPasswordLoadingState extends ForgotPasswordState {}

class ForgotPasswordSuccessState extends ForgotPasswordState {
  final String tempToken;
  ForgotPasswordSuccessState({required this.tempToken});
  // final int otp;
  // ForgotPasswordSuccessState({required this.otp});
}

class ForgotPasswordFaliurState extends ForgotPasswordState {
  final String error;
  ForgotPasswordFaliurState(this.error);
}
