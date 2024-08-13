part of 'post_comment_bloc.dart';

@immutable
abstract class PostCommentState {}

class PostCommentInitial extends PostCommentState {}

class PostCommentLoadingState extends PostCommentState {}

class PostCommentClickedState extends PostCommentState {}

class CommentsFetchedState extends PostCommentState {
  final List<CommentModel?> modelComment;
  final int commentCount;
  CommentsFetchedState({required this.modelComment,required this.commentCount});
}

class CommentsFetchFaliureState extends PostCommentState {
  final String error;

  CommentsFetchFaliureState({required this.error});
}

// class CommentsCountFetchState extends PostCommentState {
//   final int commentCount;

//   CommentsCountFetchState({required this.commentCount});
// }
// class CommentsCountFaliureState extends PostCommentState{
//   final String error;

//   CommentsCountFaliureState({required this.error});
// }
