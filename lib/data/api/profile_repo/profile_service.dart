import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:verbinden/core/endpoints.dart';
import 'package:verbinden/data/api/access_regenerator/access_token.dart';
import 'package:verbinden/data/models/profile/edit_profile.dart';
import 'package:verbinden/data/models/profile/profile_model.dart';
import 'package:verbinden/data/secure_storage/secure_storage.dart';

class ProfileService {
  AccessTokenGenerator accessTokenReGenerator = AccessTokenGenerator();
  SecureStorageService secureStorage = SecureStorageService();

  Future<ProfileModel?> getUserDetails() async {
    String? aToken = await secureStorage.readSecureStorage('AccessToken');
    String? reToken = await secureStorage.readSecureStorage('RefreshToken');
    if (aToken != null && reToken != null) {
      final uri = Uri.parse('${EndPoints.baseUrl}${EndPoints.profile}');
      final header = {'x-api-key': 'apikey@ciao', 'x-access-token': aToken};
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
          String gResponse =
              await accessTokenReGenerator.accessReGenerator(aToken, reToken);
          log('$gResponse gresponse');
          secureStorage.writeSecureStorage('AccessToken', gResponse);

          aToken = gResponse;
        }
      } catch (e) {
        log('$e error1');
        log(aToken.toString());
      }
    }
    return null;

    // return null;
  }

  //edit user Details
  Future<int?> editUserDetails(UserEditModel model) async {
    String? aToken = await secureStorage.readSecureStorage('AccessToken');
    String? reToken = await secureStorage.readSecureStorage('RefreshToken');
    if (aToken != null && reToken != null) {
      final uri = Uri.parse(
          '${EndPoints.baseUrl}${EndPoints.profile}${EndPoints.editprofile}');
      final header = {'x-api-key': 'apikey@ciao', 'x-access-token': aToken};
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
          String gResponse =
              await accessTokenReGenerator.accessReGenerator(aToken, reToken);
          log('$gResponse gresponse');
          secureStorage.writeSecureStorage('AccessToken', gResponse);

          aToken = gResponse;
          return response.statusCode;
        }
        return null;
      } catch (e) {
        log('$e error edituserdetails');
        //log(aToken.toString());
      }
    }
    return null;
  }
}
