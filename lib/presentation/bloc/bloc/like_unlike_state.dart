part of 'like_unlike_bloc.dart';

@immutable
abstract class LikeUnlikeState {}

class LikeUnlikeInitial extends LikeUnlikeState {}

class LikedState extends LikeUnlikeState {}

class UnlikeState extends LikeUnlikeState {}

class FaliureState extends LikeUnlikeState{
  final String error;

  FaliureState({required this.error});
}
