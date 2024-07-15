part of 'signup_bloc.dart';

@immutable
abstract class SignupState {}

 class SignupInitialState extends SignupState {}

 class SignupLoadingState extends SignupState{}

 class SignupSuccessState extends SignupState{
  
  final String? token;
  
  SignupSuccessState({required this.token});
 }

 class SignupFailureState extends SignupState{
  final String error;
  SignupFailureState({required this.error});
 }
