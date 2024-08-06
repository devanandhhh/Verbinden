part of 'explore_bloc.dart';

@immutable
abstract class ExploreState {}

class ExploreInitial extends ExploreState {}

class ExploreLoadingState extends ExploreState{}
 
class ExploreLoadedState extends ExploreState{
 final List<OthersPost>exploreData;

  ExploreLoadedState({required this.exploreData});
}

class ExploreFaliureState extends ExploreState{
  final String error;
  ExploreFaliureState(this.error);
}