part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoadingState extends HomeState{}

class HomeLoadedState extends HomeState{
 final List<OthersPost>othersPost;

  HomeLoadedState({required this.othersPost});

}
class HomeFaliureState extends HomeState{
  final String error;
  HomeFaliureState(this.error);
}
