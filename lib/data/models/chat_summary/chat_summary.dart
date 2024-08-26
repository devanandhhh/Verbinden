class ChatSummary {
  final String userID;
  final String userName;
  final String userProfileURL;
  final String lastMessageContent;
  final String lastMessageTimeStamp;

  ChatSummary({
    required this.userID,
    required this.userName,
    required this.userProfileURL,
    required this.lastMessageContent,
    required this.lastMessageTimeStamp,
  });

  // Factory constructor to create a model from JSON
  factory ChatSummary.fromJson(Map<String, dynamic> json) {
    return ChatSummary(
      userID: json['UserID'],
      userName: json['UserName'],
      userProfileURL: json['UserProfileURL'],
      lastMessageContent: json['LastMessageContent'],
      lastMessageTimeStamp: json['LastMessageTimeStamp'],
    );
  }

  // Convert model to JSON
  // Map<String, dynamic> toJson() {
  //   return {
  //     'UserID': userID,
  //     'UserName': userName,
  //     'UserProfileURL': userProfileURL,
  //     'LastMessageContent': lastMessageContent,
  //     'LastMessageTimeStamp': lastMessageTimeStamp,
  //   };
  // }
}
