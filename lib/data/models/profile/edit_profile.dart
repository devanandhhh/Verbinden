class UserEditModel {
  final String name;
  final String username;
  final String bio;
 

  UserEditModel({
    required this.name,
    required this.username,
    required this.bio,
   
  });

  // Factory constructor to create a User from a JSON map
  factory UserEditModel.fromJson(Map<String, dynamic> json) {
    return UserEditModel(
      name: json['name'] as String,
      username: json['username'] as String,
      bio: json['bio'] as String,
     
    );
  }


}