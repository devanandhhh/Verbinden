part of 'profile_bloc.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoadingState extends ProfileState {}

class ProfileLoadedState extends ProfileState {
  final ProfileModel profileData;
  ProfileLoadedState(this.profileData);

}

class ProfileFaliureState extends ProfileState {
  final String error;
  ProfileFaliureState(this.error);

 }
// class ProfilePostLoadingState extends ProfileState{}

// class ProfilePostsLoadedState extends ProfileState{
//   final List<Post> posts;
//   ProfilePostsLoadedState(this.posts);
// }
// class ProfilePostsFailureState extends ProfileState {
//   final String error;
//   ProfilePostsFailureState(this.error);
// }