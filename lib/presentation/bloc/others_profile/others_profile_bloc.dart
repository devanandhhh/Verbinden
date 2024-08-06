import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:verbinden/data/api/others_profile_repo/others_profile_repo.dart';
import 'package:verbinden/data/api/relation_repo/relation.dart';
import 'package:verbinden/data/models/profile/profile_model.dart';

part 'others_profile_event.dart';
part 'others_profile_state.dart';

class OthersProfileBloc extends Bloc<OthersProfileEvent, OthersProfileState> {
  OthersProfileBloc() : super(OthersProfileInitial()) {
    on<OthersProfileDataFetchEvent>(onOtherProfileDataFetched);
    on<FollowButtonClicked>(onFollowButtonClicked);
    on<UnfollowButtonClicked>(onUnfollowButtonClicked);
    // on<OthersProfileClickEvent>(onProfileClicked);
  }

  OthersProfileService service = OthersProfileService();
  RelationService relationSerice = RelationService();
  FutureOr<void> onOtherProfileDataFetched(OthersProfileDataFetchEvent event,
      Emitter<OthersProfileState> emit) async {
    emit(OthersProfileLoadingState());
    try {
      ProfileModel? model =
          await service.getOthersDetails(userid: event.userId);
      if (model != null) {
        emit(OthersProfileLoadedState(model: model));
      }
    } catch (e) {
      log(e.toString());
      emit(OthersProfileFaliureState(error: e.toString()));
    }
  }

  FutureOr<void> onFollowButtonClicked(
      FollowButtonClicked event, Emitter<OthersProfileState> emit) async {
    emit(OthersProfileLoadingState());
    try {
      int responseCode =
          await relationSerice.followRequest(userId: event.userId.toString());
      if (responseCode == 200) {
        log('follow requested accepted');
         ProfileModel? model =
          await service.getOthersDetails(userid: event.userId);
         emit(OthersProfileLoadedState(model: model));
      } else {
        log('error in on followbutton');
      }
      log('error in othersprofile bloc onfollowbutton clicked');
    } catch (e) {
      log(e.toString());
      emit(OthersProfileFaliureState(error: e.toString()));
    }
  }

  FutureOr<void> onUnfollowButtonClicked(
      UnfollowButtonClicked event, Emitter<OthersProfileState> emit) async {
    emit(OthersProfileLoadingState());
    try {
      int responseCode =
          await relationSerice.unfollowRequest(userId: event.userId.toString());
      if (responseCode == 200) {
        log('follow requested accepted');
        ProfileModel? model =
          await service.getOthersDetails(userid: event.userId);
         emit(OthersProfileLoadedState(model: model));
      } else {
        log('error in on followbutton');
      }
      log('error in othersprofile bloc onfollowbutton clicked');
    } catch (e) {
      log(e.toString());
      emit(OthersProfileFaliureState(error: e.toString()));
    }
  }
}
