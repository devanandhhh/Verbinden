part of 'others_posts_bloc.dart';

@immutable
abstract class OthersPostsEvent {}
 
 class OthersPostsFetchEvent extends OthersPostsEvent{
  final int userId;

  OthersPostsFetchEvent({required this.userId});
 }