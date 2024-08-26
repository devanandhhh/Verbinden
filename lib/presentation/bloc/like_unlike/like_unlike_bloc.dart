import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/api/like_unlike/like_and_unlike.dart';

part 'like_unlike_event.dart';
part 'like_unlike_state.dart';

class LikeUnlikeBloc extends Bloc<LikeUnlikeEvent, LikeUnlikeState> {
  LikeUnlikeBloc() : super(LikeUnlikeInitial()) {
    on<LikeEvent>(onLiked);
    on<UnlikeEvent>(onUnliked);
  }
  LikeAndUnlikeRepo likeAndUnlikeRepo = LikeAndUnlikeRepo();

  FutureOr<void> onLiked(LikeEvent event, Emitter<LikeUnlikeState> emit)async {
    final responseCode =await likeAndUnlikeRepo.likeFunction(postId: event.postId);
    if(responseCode==200){
      log('liked successfully');
      emit(LikedState());
    }else{
      log('something went wrong');
      emit(FaliureState(error: 'error'));
    }
  }

  FutureOr<void> onUnliked(UnlikeEvent event, Emitter<LikeUnlikeState> emit)async {
    final responseCode =await likeAndUnlikeRepo.unLikeFunction(postId: event.postId);
    print(responseCode);
    if(responseCode==200){
      log('successfully unlike');
      emit(UnlikeState());
    }else{
      log('something went wrorn');
      emit(FaliureState(error: 'error'));
    }
  }
}
