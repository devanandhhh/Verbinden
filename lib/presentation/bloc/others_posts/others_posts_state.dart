part of 'others_posts_bloc.dart';

@immutable
abstract class OthersPostsState {}

 class OthersPostsInitial extends OthersPostsState {}

class OthersPostsLoadingState extends OthersPostsState{}

class OthersPostLoadedState extends OthersPostsState{
  final List<OthersPost?> othersPost ;

  OthersPostLoadedState({required this.othersPost});
  
}

class OthersPostsFaliureState extends OthersPostsState{
  final String error;

  OthersPostsFaliureState({required this.error});
  
}