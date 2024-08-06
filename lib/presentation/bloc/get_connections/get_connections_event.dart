part of 'get_connections_bloc.dart';

@immutable
abstract class GetConnectionsEvent {}

class FollowersListFetchEvent extends GetConnectionsEvent{
  // final List<UserRelation> getListFollowers;

  // FollowersListFetchEvent({required this.getListFollowers});
}
class FollowingListFetchEvent extends GetConnectionsEvent{}
