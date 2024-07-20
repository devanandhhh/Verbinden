part of 'user_post_fech_bloc.dart';

@immutable
abstract class UserPostFechState {}

class UserPostFechInitial extends UserPostFechState {}

class ProfilePostLoadingState extends UserPostFechState {}

class ProfilePostsLoadedState extends UserPostFechState {
  final List<Post> posts;
  ProfilePostsLoadedState(this.posts);
}

class ProfilePostsFailureState extends UserPostFechState {
  final String error;
  ProfilePostsFailureState(this.error);
}
