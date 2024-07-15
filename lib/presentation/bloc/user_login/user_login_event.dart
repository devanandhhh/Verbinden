part of 'user_login_bloc.dart';

 class UserLoginEvent {}

 class UserLoginSubmittedEvent extends UserLoginEvent{
 final String email;
 final String password;

  UserLoginSubmittedEvent({required this.email, required this.password});
 
 }
 class UserForgotPasswordEvent extends UserLoginEvent{} 
 class UserSignupEvent extends UserLoginEvent{}
