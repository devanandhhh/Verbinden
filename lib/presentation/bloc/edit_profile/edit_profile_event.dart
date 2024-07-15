part of 'edit_profile_bloc.dart';


abstract class EditProfileEvent {}

class EditProfileSubmitted extends EditProfileEvent{
  UserEditModel model;
  EditProfileSubmitted(this.model);
}