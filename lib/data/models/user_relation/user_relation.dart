class UserRelation {
  final int userId;
  final String name;
  final String userName;
   String? userProfileImgUrl;

  UserRelation(
      {required this.userId,
      required this.name,
      required this.userName,
       this.userProfileImgUrl});

  factory UserRelation.froJson(Map<String, dynamic> json) {
    return UserRelation(
        userId: json['UserId'],
        name: json["Name"],
        userName: json["UserName"],
        userProfileImgUrl: json['ProfileImageURL']);
  }
}
