part of 'signup_bloc.dart';

// @immutable
class SignupEvent {}

class SignupSubmittedEvent extends SignupEvent {
  UserModel? user;

  SignupSubmittedEvent({required this.user});
}
