part of 'otp_validation_bloc.dart';

@immutable
abstract class OtpValidationEvent {}

class OtpSubittedEvent extends OtpValidationEvent{
  final String otp;
  final String tempToken;
  OtpSubittedEvent({required this.otp, required this.tempToken});
}

class OtpResentEvent extends OtpValidationEvent{}

/// Otp forgot screen
class OtpResentFEvent extends OtpValidationEvent{}

class OtpResetSubittedEvent extends OtpValidationEvent{}

class OtpResetSuccessEvent extends OtpValidationEvent{
  final String otp;
  final String password;
  final String confirmpassword;
  final String token;
  OtpResetSuccessEvent({required this.otp,required this.password,required this.confirmpassword,required this.token});
}
