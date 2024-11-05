import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:verbinden/data/api/comments_repo/comments.dart';
import 'package:verbinden/data/models/comment_model/comment_model.dart';

part 'post_comment_event.dart';
part 'post_comment_state.dart';

class PostCommentBloc extends Bloc<PostCommentEvent, PostCommentState> {
  PostCommentBloc() : super(PostCommentInitial()) {
    on<AddCommentButtonClickEvent>(onAddComment);
    on<FetchAllCommentsEvent>(onFetchComment);
    on<DeleteCommentEvent>(onDeleteComment);
    on<EditCommentEvent>(onEditComment);
    // on<FetchCommentsCountEvent>(onFetchCommentCount);
  }
  CommentService service = CommentService();
  FutureOr<void> onAddComment(
      AddCommentButtonClickEvent event, Emitter<PostCommentState> emit) async {
    emit(PostCommentLoadingState());
    try {
      final response = await service.addComment(
        postId: event.postId,
        comment: event.comment.toString(),
      );
      if (response == 200) {
        log('response from commed added $response');
        emit(PostCommentClickedState());
      } else {
        log('response from commed added $response');
        emit(CommentsFetchFaliureState(error: 'not 200'));
      }
    } catch (e) {
      log('$e error on addcomment ');
      emit(CommentsFetchFaliureState(error: 'error catch'));
    }
  }

  FutureOr<void> onFetchComment(
      FetchAllCommentsEvent event, Emitter<PostCommentState> emit) async {
    emit(PostCommentLoadingState());
    try {
      final commentList = await service.getComments(postId: event.postId);
      final commentCount = await service.getCommentCount(postId: event.postId);
      // if(commentCount==null&&commentList!.isNotEmpty){
      log('commentlist have value');
      emit(CommentsFetchedState(
          modelComment: commentList!, commentCount: commentCount));
      // }else{

      //}
    } catch (e) {
      log('error $e');
      emit(CommentsFetchFaliureState(error: 'error frm fetch event'));
    }
  }

  // FutureOr<void> onFetchCommentCount(FetchCommentsCountEvent event, Emitter<PostCommentState> emit)async {
  //   emit(PostCommentLoadingState());
  //   try {
  //     final commentCount =await service.getCommentCount(postId: event.postId);
  //     if(commentCount>0){
  //       emit(CommentsCountFetchState(commentCount: commentCount));
  //     }else{
  //       emit(CommentsCountFaliureState(error: 'commentcount is 0'));
  //     }
  //   } catch (e) {
  //     log(e.toString());
  //   }
  // }

  FutureOr<void> onDeleteComment(
      DeleteCommentEvent event, Emitter<PostCommentState> emit) async {
    emit(PostCommentLoadingState());
    try {
      final responseCode =
          await service.deleteComment(commentId: event.commentId);

      if (responseCode == 200) {
        log('Comment Delete Successfully');
        // emit(CommentsFetchedState(modelComment:commentList! , commentCount: commentCount));
      } else {
        log('status code not 200');
        //  emit(CommentsFetchFaliureState(error: 'Error'));
      }
    } catch (e) {
      log(' error $e');
    }
  }

  FutureOr<void> onEditComment(
      EditCommentEvent event, Emitter<PostCommentState> emit) async {
    emit(PostCommentLoadingState());
    try {
      final responseCode = await service.editComment(
          commentId: event.commentId, commentText: event.commentText);
          log('responsecode is $responseCode');
      if (responseCode == 200) {
        log('Comment Edited Successfully');
      } else {
        log('Something went Wrong');
      }
    } catch (e) {
      log('$e form on edit comment');
    }
  }
}
