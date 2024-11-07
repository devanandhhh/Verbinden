// validation_service.dart

class ValidationService {
  static String? validateName(String name) {
    if (name.isEmpty ) {
      return 'Name is Empty';
    }else if(name.length <= 3){
      return 'Name should be atleast 4 character';
    }
    return null;
  }

  static String? validateUsername(String username) {
    final nameRegExp=RegExp(r'^[a-zA-Z]*$');
    if (username.isEmpty ) {
      return 'Username is Empty'; 
    }else if(username.length <= 3){
      return 'Name should be atleast 4 character';
    }else if(!nameRegExp.hasMatch(username)){
      return 'Please Enter in letters without space';
    }else if(username==username.toLowerCase()){
      return 'Enter your name in Lower case';
    }
    return null;
    
  }

  static String? validateEmail(String email) {
    final emailRegExp = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$',
    );

    if (email.isEmpty) {
      return 'Email cannot be empty';
    } else if (!emailRegExp.hasMatch(email)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  static String? validatePassword(String password) {
    final passwordRegExp = RegExp(
      r'^(?=.*[A-Z])(?=.*[!@#$&*])(?=.*[0-9]).{5,}$',
    );

    //password contain capital letter
    final regexp = RegExp(r'^[^A-Z]*$');

    if (password.isEmpty) {
      return 'Password cannot be empty';
    } else if (password.length < 8) {
      return 'Password must be at least 8 characters long';
    } else if (regexp.hasMatch(password)) {
      return 'Password must contain an uppercase letter';
    } else if (!passwordRegExp.hasMatch(password)) {
      return 'Password must contain an special character, a number';
    }
    return null;
  }

  static String? validateConfirmPassword(
      String password, String confirmPassword) {
    if (confirmPassword.isEmpty) {
      return 'Confirm password cannot be empty';
    } else if (password != confirmPassword) {
      return 'Passwords do not match';
    }
    return null;
  }

static String? validateCaption(String caption) {
    if (caption.isEmpty ) {
      return 'caption is Empty';
    }else if(caption.length<=1){
      return 'add a good caption';
    }
    return null;
  }

}
