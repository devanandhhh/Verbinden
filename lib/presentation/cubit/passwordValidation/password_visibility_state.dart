part of 'password_visibility_cubit.dart';

@immutable
abstract class PasswordVisibilityState {}

class PasswordVisibilityInitial extends PasswordVisibilityState {
  final bool isVisible; 
  PasswordVisibilityInitial({required this.isVisible});
}
