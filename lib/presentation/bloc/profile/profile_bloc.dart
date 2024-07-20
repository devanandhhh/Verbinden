import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:verbinden/data/api/profile_repo/profile_service.dart';
import 'package:verbinden/data/models/profile/profile_model.dart';


part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<ProfileFetchDataEvent>(onProfiledatafeched);
    // on<ProfileFetchPostEvent>(onProfilePostFeched);
   
  }
  ProfileService service = ProfileService();

  Future<void> onProfiledatafeched(
      ProfileFetchDataEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileLoadingState());
    try {
      log('loading');
      ProfileModel? model = await service.getUserDetails();
      if (model != null) {
        emit(ProfileLoadedState(model));
      }
    } catch (e) {
      log('$e is error');
      emit(ProfileFaliureState(e.toString()));
    }
  }

 

  // FutureOr<void> onProfilePostFeched(ProfileFetchPostEvent event, Emitter<ProfileState> emit)async {
  // emit(ProfilePostLoadingState());
  // try { 
  //   log('loading the userpost');
  //   List<Post>posts= await service.getUserPosts();
  //   log('postlist is $posts');
  //   emit(ProfilePostsLoadedState(posts));
  // } catch (e) {
  //    log('$e is error');
  //     emit(ProfilePostsFailureState(e.toString()));
  // }
  // }
}
