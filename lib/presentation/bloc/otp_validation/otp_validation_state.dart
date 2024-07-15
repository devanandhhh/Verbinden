part of 'otp_validation_bloc.dart';

@immutable
abstract class OtpValidationState {}

class OtpValidationInitial extends OtpValidationState {}

class OtpIntialState extends OtpValidationState {}

class OtpLoadingState extends OtpValidationState {}

class OtpSuccessState extends OtpValidationState {
  final String otp;
  OtpSuccessState(this.otp);
}

class OtpFaliureState extends OtpValidationState {
  final String error;
  OtpFaliureState(this.error);
}
//
class OtpResendState extends OtpValidationState {}

class OtpResetSuccesstate extends OtpValidationState {}

class OtpResetFaliurestate extends OtpValidationState{}
