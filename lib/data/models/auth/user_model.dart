class UserModel {
  final String name;
  final String username;
  final String email;
  final String password;
  final String confirmPassword;
  UserModel(
      {required this.name,
      required this.username,
      required this.email,
      required this.password,
      required this.confirmPassword});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        name: json['name'],
        username: json['username'],
        email: json['email'],
        password: json['password'],
        confirmPassword: json['confirmpassword']);
  }
  // Map<String,dynamic> tojson(){
  //   return {
  //     'name':name,
  //     'username':username,
  //     'email':email,
  //     'password':password,
  //     'confirmpassword':confirmPassword
  //   };
  // }
}
