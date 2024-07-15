part of 'forgot_password_bloc.dart';

class ForgotPasswordEvent {}

class ForgotPasswordSubmittedEvent extends ForgotPasswordEvent {
  final String email;
  ForgotPasswordSubmittedEvent({required this.email});
}
