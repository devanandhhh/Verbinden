part of 'post_comment_bloc.dart';

@immutable
abstract class PostCommentEvent {}
class AddCommentButtonClickEvent extends PostCommentEvent{
  final String comment;
  //final int commentId;
  final int postId;

  AddCommentButtonClickEvent({required this.postId, required this.comment, });
}
//
class FetchAllCommentsEvent extends PostCommentEvent{
 final int postId;

  FetchAllCommentsEvent({required this.postId});
 
}
//
class EditCommentEvent extends PostCommentEvent{
  final int commentId;
  final String commentText;
  //final int postId;

  EditCommentEvent({required this.commentId,required this.commentText});
}
class DeleteCommentEvent extends PostCommentEvent{
  final int commentId;
  final int postId;
  DeleteCommentEvent({required this.commentId,required this.postId});
}
//
// class FetchCommentsCountEvent extends PostCommentEvent{
//   final int postId;

//   FetchCommentsCountEvent({required this.postId});
// }