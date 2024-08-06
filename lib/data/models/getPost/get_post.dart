class Post {
  final int userId;
  final String userName;
  final String? userProfileImgURL;
  final int postId;
  final String? caption;
  final String postAge;
  final List<String> mediaUrl;
  final int? likesCount;
  final int? commentsCount;

  Post({
    required this.userId,
    required this.userName,
     this.userProfileImgURL,
    required this.postId,
    this.caption,
    required this.postAge,
    required this.mediaUrl,
    this.likesCount,
    this.commentsCount,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      userId: json['UserId'],
      userName: json['UserName'],
      userProfileImgURL: json['UserProfileImgURL'],
      postId: json['PostId'],
      caption: json['Caption'],
      postAge: json['PostAge'],
      mediaUrl: List<String>.from(json['MediaUrl']),
      likesCount: json['LikesCount'],
      commentsCount: json['CommentsCount'],
    );
  }

  
}
// not using
class PostsResponse {
  final int statusCode;
  final String message;
  final List<Post> posts;

  PostsResponse({
    required this.statusCode,
    required this.message,
    required this.posts,
  });

  factory PostsResponse.fromJson(Map<String, dynamic> json) {
    var postsData = json['after execution']['PostsData'] as List;
    List<Post> postsList = postsData.map((i) => Post.fromJson(i)).toList();

    return PostsResponse(
      statusCode: json['status_code'],
      message: json['message'],
      posts: postsList,
    );
  }

}