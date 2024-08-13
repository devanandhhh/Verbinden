import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:verbinden/data/models/user_relation/user_relation.dart';

import '../../../data/api/relation_repo/relation.dart';

part 'get_connections_event.dart';
part 'get_connections_state.dart';

class GetConnectionsBloc
    extends Bloc<GetConnectionsEvent, GetConnectionsState> {
  GetConnectionsBloc() : super(GetConnectionsInitial()) {
    on<FollowersListFetchEvent>(onFollowersListFetched);
    on<FollowingListFetchEvent>(onFollowingListFetched);
  }
  RelationService service = RelationService();
  FutureOr<void> onFollowersListFetched(
      FollowersListFetchEvent event, Emitter<GetConnectionsState> emit) async {
    emit(GetConnectionLoadingState());

    try {
      final List<UserRelation> followerList = await service.getFollowersList();
      print('followers list $followerList');
      if(followerList.isEmpty){
        emit(FollowerListFaliureState(error: 'No followers')); 
      }
      if (followerList.isNotEmpty) {
        log('in followlist isnot Empty');
        emit(FollowerListLoadedState(followerList: followerList));
      } else {
        emit(FollowerListFaliureState(error: 'No Followers Found'));
      }
    } catch (e) {
      log('error is $e');
    }
  }

  FutureOr<void> onFollowingListFetched(
      FollowingListFetchEvent event, Emitter<GetConnectionsState> emit) async {
    emit(GetConnectionLoadingState());
    try {
      final List<UserRelation> followingList =
          await service.getFollowingList();
      if (followingList.isNotEmpty) {
        emit(FollowingListLoadedState(followingList: followingList));
      } else {
        emit(FollowingListFaliureState(error: 'No Following Found'));
      }
    } catch (e) {
       log('error is $e');
    }
  }
}
