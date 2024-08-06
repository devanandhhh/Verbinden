import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:verbinden/data/models/allPost/all_post.dart';

import '../../../data/api/others_profile_photo_repo/others_posted_photo.dart';

part 'others_posts_event.dart';
part 'others_posts_state.dart';

class OthersPostsBloc extends Bloc<OthersPostsEvent, OthersPostsState> {
  OthersPostsBloc() : super(OthersPostsInitial()) {
    on<OthersPostsFetchEvent>(onOthersPostFetched);
  }
OthersPostedPhotoService service =OthersPostedPhotoService();
  FutureOr<void> onOthersPostFetched(OthersPostsFetchEvent event, Emitter<OthersPostsState> emit)async {

  emit(OthersPostsLoadingState());
  try {
    List<OthersPost?>data = await service.getOthersPosts(userid: event.userId);
    emit(OthersPostLoadedState(othersPost: data));
  } catch (e) {
    log(e.toString());
      emit(OthersPostsFaliureState(error: e.toString())); 
  }  
  }
}
