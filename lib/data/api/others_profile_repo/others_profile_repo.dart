import 'dart:convert';
import 'dart:developer';

import 'package:verbinden/core/endpoints.dart';
import 'package:verbinden/data/models/profile/profile_model.dart';

import '../../secure_storage/secure_storage.dart';
import '../profile_repo/section_2/profile_section_service.dart';
import 'package:http/http.dart'as http;
class OthersProfileService {
  SecureStorageService secureStorage = SecureStorageService();
  GetTokensHere tokens = GetTokensHere();

  //get data details of Others
  Future<ProfileModel?> getOthersDetails({required int userid}) async {
    String? accessToken = await tokens.getAccessToken();
    //await secureStorage.readSecureStorage('AccessToken');
    String? refreshToken = await tokens.getRefreshToken();
    if (accessToken != null && refreshToken != null) {
      final url =
          Uri.parse('${EndPoints.baseUrl}${EndPoints.explore}${EndPoints.profile}/${userid.toString()}');
     final header = {
        'x-api-key': 'apikey@ciao',
        'x-access-token': accessToken
      };
      try{
        final response =await http.get(url,headers: header);
        log('response from othersprofiledata $response');
        if(response.statusCode==200){
           Map<String ,dynamic>jsonModel =jsonDecode(response.body);
        ProfileModel modelOthersProfile =ProfileModel.fromJson(jsonModel);
        return modelOthersProfile;
        }else if(response.statusCode==400){
          String newAccessToken = await tokens.getAccessTokenRegenerator();
          // await accessTokenReGenerator.accessReGenerator(accessToken, refreshToken);
          log('$newAccessToken newaccessToken');
          secureStorage.writeSecureStorage('AccessToken', newAccessToken);
          accessToken = newAccessToken;
          return getOthersDetails(userid: userid);
        }
       
      }catch(e){
        log(e.toString());

      }
    }
    return null;
  }
}
