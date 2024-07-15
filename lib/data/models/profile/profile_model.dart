
class ProfileModel {
  int statusCode;
  String message;
  UserProfileData afterExecution;

  ProfileModel({
    required this.statusCode,
    required this.message,
    required this.afterExecution,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      statusCode: json['status_code'],
      message: json['message'],
      afterExecution: UserProfileData.fromJson(json['after execution']),
    );
  }

  // Map<String, dynamic> toJson() {
  //   return {
  //     'status_code': statusCode,
  //     'message': message,
  //     'after execution': afterExecution.toJson(),
  //   };
  // }
}

class UserProfileData {
  int userId;
  String name;
  String userName;
  String bio;
  String links;
  String userProfileImageURL;
  int postsCount;
  int followersCount;
  int followingCount;

  UserProfileData({
    required this.userId,
    required this.name,
    required this.userName,
    required this.bio,
    required this.links,
    required this.userProfileImageURL,
    required this.postsCount,
    required this.followersCount,
    required this.followingCount,
  });

  factory UserProfileData.fromJson(Map<String, dynamic> json) {
    return UserProfileData(
      userId: json['UserId'],
      name: json['Name'],
      userName: json['UserName'],
      bio: json['Bio'],
      links: json['Links'],
      userProfileImageURL: json['UserProfileImageURL'],
      postsCount: json['PostsCount'],
      followersCount: json['FollowersCount'],
      followingCount: json['FollowingCount'],
    );
  }

  // Map<String, dynamic> toJson() {
  //   return {
  //     'UserId': userId,
  //     'Name': name,
  //     'UserName': userName,
  //     'Bio': bio,
  //     'Links': links,
  //     'UserProfileImageURL': userProfileImageURL,
  //     'PostsCount': postsCount,
  //     'FollowersCount': followersCount,
  //     'FollowingCount': followingCount,
  //   };
  // }
}