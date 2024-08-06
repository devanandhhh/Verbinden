import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:verbinden/core/endpoints.dart';
// import 'package:verbinden/data/api/access_regenerator/access_token.dart';
import 'package:verbinden/data/api/profile_repo/section_2/profile_section_service.dart';
import 'package:verbinden/data/models/profile/edit_profile.dart';
import 'package:verbinden/data/models/profile/profile_model.dart';
import 'package:verbinden/data/secure_storage/secure_storage.dart';

class ProfileService {
  // AccessTokenGenerator accessTokenReGenerator = AccessTokenGenerator();
  SecureStorageService secureStorage = SecureStorageService();
  GetTokensHere tokens = GetTokensHere();
  Future<ProfileModel?> getUserDetails() async {
    String? accessToken = await tokens.getAccessToken();
    //await secureStorage.readSecureStorage('AccessToken');
    String? refreshToken = await tokens.getRefreshToken();
    //await secureStorage.readSecureStorage('RefreshToken');
    if (accessToken != null && refreshToken != null) {
      final uri = Uri.parse('${EndPoints.baseUrl}${EndPoints.profile}');
      final header = {
        'x-api-key': 'apikey@ciao',
        'x-access-token': accessToken
      };
      try {
        final response = await http.get(uri, headers: header);

        log(response.body);

        if (response.statusCode == 200) {
          log('response 200 from getuserdetails');
          Map<String, dynamic> jsonModel = jsonDecode(response.body);
          ProfileModel modelProfile = ProfileModel.fromJson(jsonModel);
          log('---------------------------${modelProfile.toString()}');
          return modelProfile;
        } else if (response.statusCode == 400) {
          log('response 400 from getuserdetails');
          String newAccessToken = await tokens.getAccessTokenRegenerator();
          // await accessTokenReGenerator.accessReGenerator(accessToken, refreshToken);
          log('$newAccessToken newaccessToken');
          secureStorage.writeSecureStorage('AccessToken', newAccessToken);
          accessToken = newAccessToken;
          return getUserDetails();
        }
      } catch (e) {
        log('$e error1');
        // log(accessToken.toString());
      }
    }
    return null;
  }

  //edit user Details
  Future<int?> editUserDetails(UserEditModel model) async {
    String? accessToken = await tokens.getAccessToken();
    // await secureStorage.readSecureStorage('AccessToken');
    String? refreshToken = await tokens.getRefreshToken();
    // await secureStorage.readSecureStorage('RefreshToken');
    if (accessToken != null && refreshToken != null) {
      final uri = Uri.parse(
          '${EndPoints.baseUrl}${EndPoints.profile}${EndPoints.editprofile}');
      final header = {
        'x-api-key': 'apikey@ciao',
        'x-access-token': accessToken
      };
      final body = {
        "name": model.name,
        "username": model.username,
        "bio": model.bio,
      };
      try {
        final response = await http.patch(uri, headers: header, body: body);
        log(response.toString());
        if (response.statusCode == 200) {
          log('200 ---------response pach');
          return response.statusCode;
        } else if (response.statusCode == 400) {
          String newAccessToken = await tokens.getAccessTokenRegenerator();
          // await accessTokenReGenerator.accessReGenerator(aToken, reToken);
          log('$newAccessToken newAccessToken');
          secureStorage.writeSecureStorage('AccessToken', newAccessToken);

          accessToken = newAccessToken;
          return editUserDetails(model);
          //response.statusCode;
        }
        return null;
      } catch (e) {
        log('$e error edituserdetails');
        //log(aToken.toString());
      }
    }
    return null;
  }

  //add user profile photo
  Future<int>addUserProfilePhoto(String? imagefile) async {
    String? accessToken = await tokens.getAccessToken();
    // await secureStorage.readSecureStorage('AccessToken');
    String? refreshToken = await tokens.getRefreshToken();
    // await secureStorage.readSecureStorage('RefreshToken');
    final url = Uri.parse(
        '${EndPoints.baseUrl}${EndPoints.profile}${EndPoints.setProfileImage}');

    if (accessToken != null && refreshToken != null) {
      final header = {
        'x-api-key': 'apikey@ciao',
        'x-access-token': accessToken,
      };

      try {
        var request = http.MultipartRequest('POST', url);
        request.headers.addAll(header);
        
        if (imagefile!.isNotEmpty) {
          request.files
              .add(await http.MultipartFile.fromPath('ProfileImg', imagefile));
        }
        var response = await request.send();
        print(response.statusCode);
        if (response.statusCode == 200) {
          print('Student added sucessfully');
          return response.statusCode;
        } else if (response.statusCode == 400) {
          print('Status code is 400');
          String newAccessToken = await tokens.getAccessTokenRegenerator();
          // await accessTokenReGenerator.accessReGenerator(aToken, reToken);
          log('$newAccessToken gresponse');
          secureStorage.writeSecureStorage('AccessToken', newAccessToken);
          accessToken = newAccessToken;
          return  addUserProfilePhoto(
            imagefile,
          );
        } else {
          log('Failed to upload image, status code: ${response.statusCode}');

          return 00;
        }
      } catch (e) {
        log('error by $e from addUserProfilePhoto');
        return 00;
      }
    } else {
      return 00;
    }
  }
}
