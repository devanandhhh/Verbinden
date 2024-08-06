class GetSearchResult {
  final int userId;
  final String name;
  final String userName;
  final String? profileImageURL;

  GetSearchResult(
      {required this.userId,
      required this.name,
      required this.userName,
      this.profileImageURL});

  factory GetSearchResult.fromJson(Map<String, dynamic> json) {
    return GetSearchResult(
        userId: json['UserId'],
        name: json['Name'],
        userName: json['UserName'],
        profileImageURL: json['ProfileImageURL']);
  }
}
