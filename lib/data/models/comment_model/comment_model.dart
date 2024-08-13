class CommentModel {
  final int commentId;
  final int postId;
  final int userId;
  final String userName;
  final String? userprofileimageUrl;
  final String commentText;
  final String commentAge;

  CommentModel(
      {required this.commentId,
      required this.postId,
      required this.userId,
      required this.userName,
      this.userprofileimageUrl,
      required this.commentText,
      required this.commentAge});

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
        commentId: json['CommentId'],
        postId: json['PostId'],
        userId: json['UserId'],
        userName: json['UserName'],
        userprofileimageUrl: json['UserProfileImgURL'],
        commentText: json['CommentText'],
        commentAge: json['CommentAge']);
  }
}


    // "CommentId": 1,
    //             "PostId": 14,
    //             "UserId": 2,
    //             "UserName": "devanand",
    //             "UserProfileImgURL": "https://s3.ap-south-1.amazonaws.com/ciao-socialmedia/userprofileimg/68151283-a5b1-4390-bd6f-6d5589c1061b",
    //             "CommentText": "comment test text",
    //             "CommentAge": "3 hrs ago"