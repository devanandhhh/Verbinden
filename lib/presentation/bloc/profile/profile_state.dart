part of 'profile_bloc.dart';

@immutable
abstract class ProfileState {
  // @override
  // List<Object?> get props=>[];
}

class ProfileInitial extends ProfileState {}

class ProfileLoadingState extends ProfileState {}

class ProfileLoadedState extends ProfileState {
  final ProfileModel profileData;
  ProfileLoadedState(this.profileData);
  // @override
  // List<Object?> get props=>[profileData];
}

class ProfileFaliureState extends ProfileState {
  final String error;
  ProfileFaliureState(this.error);
  // @override
  // List<Object?> get props=>[error];
}
//---------------

// class ProfileViewLoading extends ProfileState{}

// class ProfileViewLoaded extends ProfileState{
//   final ProfileModel model;
//   ProfileViewLoaded(this.model);
// }
// class ProfileViewFaliure extends ProfileState{
//   final String error;
//   ProfileViewFaliure(this.error);
// }