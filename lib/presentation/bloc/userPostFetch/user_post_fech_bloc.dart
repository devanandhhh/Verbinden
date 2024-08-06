import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:verbinden/data/models/edit_post/edit_post.dart';

import '../../../data/api/profile_repo/section_2/profile_section_service.dart';
import '../../../data/models/getPost/get_post.dart';

part 'user_post_fech_event.dart';
part 'user_post_fech_state.dart';

class UserPostFechBloc extends Bloc<UserPostFechEvent, UserPostFechState> {
  UserPostFechBloc() : super(UserPostFechInitial()) {
    on<ProfileFetchPostEvent>(onProfilePostFeched);
    on<DeletePostEvent>(onDeletePost);
    //adding edit event
    on<EditPostEvent>(onEditPost);
  }

   ProfilePostSectionService service = ProfilePostSectionService();
  FutureOr<void> onProfilePostFeched(ProfileFetchPostEvent event, Emitter<UserPostFechState> emit)async {
  emit(ProfilePostLoadingState());
  try { 
    log('loading the userpost');
    List<Post>posts= await service.getUserPosts();
    log('postlist is $posts');
    emit(ProfilePostsLoadedState(posts));
  } catch (e) {
     log('$e is error');
      emit(ProfilePostsFailureState(e.toString()));
  }
  }

  FutureOr<void> onDeletePost(DeletePostEvent event, Emitter<UserPostFechState> emit) async{
    emit(ProfilePostLoadingState());
    try {
      log('deleting post by ${event.postId}');
      await service.deleteUserPost(event.postId);
      log('delete post');
      List<Post> posts=await service.getUserPosts();
      emit(ProfilePostsLoadedState(posts));
    } catch (e) {
      log(e.toString());
      emit(ProfilePostsFailureState(e.toString()));
    }
  }

  FutureOr<void> onEditPost(EditPostEvent event, Emitter<UserPostFechState> emit)async {
    emit(ProfilePostLoadingState());
    try{
     log('edit post successfully id ${event.model.postId}');
    await service.editUserPost(EditPostModel(caption: event.model.caption, postId: event.model.postId));
    List<Post>posts=await service.getUserPosts();
    emit(ProfilePostsLoadedState(posts));
    }catch(e){
       log(e.toString());
      emit(ProfilePostsFailureState(e.toString()));
    }
    
  }
}
