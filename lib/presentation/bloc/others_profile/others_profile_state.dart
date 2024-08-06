part of 'others_profile_bloc.dart';

@immutable
abstract class OthersProfileState {}

class OthersProfileInitial extends OthersProfileState {}

class OthersProfileClickedState extends OthersProfileState{
  final int userId;

  OthersProfileClickedState({required this.userId});
  
}

class OthersProfileLoadingState extends OthersProfileState{}

class OthersProfileLoadedState extends OthersProfileState{
  final ProfileModel? model;

  OthersProfileLoadedState({required this.model});
}

class OthersProfileFaliureState extends OthersProfileState{
  final String error;

  OthersProfileFaliureState({required this.error});
  
}
