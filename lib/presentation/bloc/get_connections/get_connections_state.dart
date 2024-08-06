part of 'get_connections_bloc.dart';

@immutable
abstract class GetConnectionsState {}

class GetConnectionsInitial extends GetConnectionsState {}

class GetConnectionLoadingState extends GetConnectionsState {}

class FollowerListLoadedState extends GetConnectionsState {
  final List<UserRelation> followerList;

  FollowerListLoadedState({required this.followerList});
}
class FollowerListFaliureState extends GetConnectionsState{
  final String error;

  FollowerListFaliureState({required this.error});
  
}
//----
// class FollowingListLoadingState extends GetConnectionsState{

// }

class FollowingListLoadedState extends GetConnectionsState{
  final List<UserRelation> followingList;

  FollowingListLoadedState({required this.followingList});
}
class FollowingListFaliureState extends GetConnectionsState{
  final String error;

  FollowingListFaliureState({required this.error});

}