part of 'others_profile_bloc.dart';

@immutable
abstract class OthersProfileEvent {}


// class OthersProfileClickEvent extends OthersProfileEvent{
//   final int userId;
//   OthersProfileClickEvent({required this.userId});
// }
class OthersProfileDataFetchEvent extends OthersProfileEvent{
  final int userId;

  OthersProfileDataFetchEvent({required this.userId}); 
}

class FollowButtonClicked extends OthersProfileEvent{
  final int userId;

  FollowButtonClicked({required this.userId});
}
class UnfollowButtonClicked extends OthersProfileEvent{
  final int userId;

  UnfollowButtonClicked({required this.userId});
}
