part of 'edit_profile_bloc.dart';


abstract class EditProfileState {}

final class EditProfileInitial extends EditProfileState {}

class EditProfileLoadingState extends EditProfileState{}

class EditProfileSuccessState extends EditProfileState{}

class EditProfileFaliureState extends EditProfileState{}

class EditProfileErrorState extends EditProfileState{
  final String error;
  EditProfileErrorState(this.error);

}