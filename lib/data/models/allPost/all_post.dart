class OthersPost {
  final int userId;
  final String userName;
  final String userProfileImgUrl;
  final int postId;
  final String? caption;
  final String postAge;
  final List<String> mediaUrl;
  final int? commentsCount;
  final bool? likeStatus;
  final int? likesCount;

  OthersPost({
    required this.userId,
    required this.userName,
    required this.userProfileImgUrl,
    required this.postId,
    this.caption,
    required this.postAge,
    required this.mediaUrl,
    this.commentsCount,
    this.likeStatus,
    this.likesCount,
  });

  factory OthersPost.fromJson(Map<String, dynamic> json) {
    return OthersPost(
      userId: json['UserId'],
      userName: json['UserName'],
      userProfileImgUrl: json['UserProfileImgURL'],
      postId: json['PostId'],
      caption: json['Caption'],
      postAge: json['PostAge'],
      mediaUrl: List<String>.from(json['MediaUrl']),
      commentsCount: json['CommentsCount'],
      likeStatus: json['LikeStatus'],
      likesCount: json['LikesCount'],
    );
  }

  // Map<String, dynamic> toJson() {
  //   return {
  //     'UserId': userId,
  //     'UserName': userName,
  //     'UserProfileImgURL': userProfileImgUrl,
  //     'PostId': postId,
  //     'Caption': caption,
  //     'PostAge': postAge,
  //     'MediaUrl': mediaUrl,
  //     'CommentsCount': commentsCount,
  //     'LikeStatus': likeStatus,
  //     'LikesCount': likesCount,
  //   };
  // }
}
//not using
class PostsResponse {
  final int statusCode;
  final String message;
  final List<OthersPost> postsData;

  PostsResponse({
    required this.statusCode,
    required this.message,
    required this.postsData,
  });

  factory PostsResponse.fromJson(Map<String, dynamic> json) {
    var list = json['after execution']['PostsData'] as List;
    List<OthersPost> postsList = list.map((i) => OthersPost.fromJson(i)).toList();

    return PostsResponse(
      statusCode: json['status_code'],
      message: json['message'],
      postsData: postsList,
    );
  }

  // Map<String, dynamic> toJson() {
  //   return {
  //     'status_code': statusCode,
  //     'message': message,
  //     'after execution': {
  //       'PostsData': postsData.map((post) => post.toJson()).toList(),
  //     },
  //   };
  // }
}
