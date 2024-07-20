part of 'user_post_fech_bloc.dart';

@immutable
abstract class UserPostFechEvent {}


class ProfileFetchPostEvent extends UserPostFechEvent{}

class DeletePostEvent extends UserPostFechEvent{ 
  final int postId;

  DeletePostEvent({required this.postId});
}