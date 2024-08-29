import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:verbinden/core/endpoints.dart';
import 'package:verbinden/data/models/auth/user_model.dart';
import 'package:verbinden/data/secure_storage/secure_storage.dart';

class AuthService {
  Future<Response?> userSigup(UserModel userModel) async {
    final uri = Uri.parse('${EndPoints.baseUrl}${EndPoints.signup}');
    final header = {
      'x-api-key': 'apikey@ciao',
      'Content-Type': 'application/json',
    };
    final body = {
      'name': userModel.name,
      'username': userModel.username,
      'email': userModel.email,
      'password': userModel.password,
      'confirmpassword': userModel.confirmPassword
    };

    try {
      final response =
          await http.post(uri, headers: header, body: jsonEncode(body));
      log(response.body);

      // String token = jsonDecode(response.body)['after execution']['Token'];
      return response;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  ////////////////////// OTP Verification/////////////////////////////

  Future<bool> otpVerify(String token, String otpCode) async {
    final uri = Uri.parse('${EndPoints.baseUrl}${EndPoints.otpVerification}');
    final header = {'x-temp-token': token, 'x-api-key': 'apikey@ciao'};
    final body = {'otp': otpCode};

    try {
      final response = await http.post(uri, headers: header, body: body);

      log(response.body);
      if (response.statusCode == 200) {
        final String accessToken =
            jsonDecode(response.body)['after execution']['AccessToken'];
        final String refreshToken =
            jsonDecode(response.body)['after execution']['RefreshToken'];
        SecureStorageService secureStorage = SecureStorageService();
        secureStorage.writeSecureStorage('AccessToken', accessToken);
        secureStorage.writeSecureStorage('RefreshToken', refreshToken);
        return true;
      }
    } catch (e) {
      log(e.toString());
    }
    return false;
  }

  //User login
  Future<Response?> userLogin(String email, String password) async {
    final uri = Uri.parse('${EndPoints.baseUrl}${EndPoints.login}');
    final header = {
      'x-api-key': 'apikey@ciao',
      //'Content-Type': 'application/json',
    };
    final body = {'email': email, 'password': password};
log('$email $password');
    try {
      final response = await http.post(uri, headers: header, body: body);
      if (response.statusCode == 200) {
        return response;
      }
    } catch (e) {
      log(e.toString());
      return null;
    }
    return null;
  }

  /////////////Forgot  Password
  Future<Response?> userForgotPassword(String email) async {
    final uri = Uri.parse('${EndPoints.baseUrl}${EndPoints.forgotPassword}');
    final header = {
      'x-api-key': 'apikey@ciao',
    };
    final body = {'email': email};

    try {
      final response = await http.post(uri, headers: header, body: body);
      if (response.statusCode == 200) {
        return response;
      } else {
        return null;
      }
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  // reset password
  Future<Response?> resetPassword(
      String otp, String password, String confirmpassword, String token) async {
    final uri = Uri.parse('${EndPoints.baseUrl}${EndPoints.resetPassword}');
    final header = {'x-api-key': 'apikey@ciao', 'x-temp-token': token};
    final body = {
      'otp': otp,
      'password': password,
      'confirmpassword': confirmpassword
    };
    try {
      final resposne = await http.patch(uri, headers: header, body: body);
      if (resposne.statusCode == 200) {
        return resposne;
      } else {
        return null;
      }
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}
