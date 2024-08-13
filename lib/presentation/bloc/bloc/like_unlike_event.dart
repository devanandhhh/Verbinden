part of 'like_unlike_bloc.dart';

@immutable
abstract class LikeUnlikeEvent {}
class LikeEvent extends LikeUnlikeEvent{
  final int postId;

  LikeEvent({required this.postId});
}
class UnlikeEvent extends LikeUnlikeEvent{
  final int postId;

  UnlikeEvent({required this.postId});
  
}
