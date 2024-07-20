// ignore: unused_import
import 'dart:convert';
import 'dart:developer';

import 'package:verbinden/core/endpoints.dart';
import 'package:verbinden/data/api/access_regenerator/access_token.dart';
import 'package:verbinden/data/secure_storage/secure_storage.dart';
import 'package:http/http.dart' as http;

class AddPostService {
  SecureStorageService secureStorage = SecureStorageService();
  AccessTokenGenerator accessTokenReGenerator = AccessTokenGenerator();

  Future<int> addPost(String? imagefile, String caption) async {
    //tokens
    String? aToken = await secureStorage.readSecureStorage('AccessToken');
    String? reToken = await secureStorage.readSecureStorage('RefreshToken');
//uri side
    final url = Uri.parse('${EndPoints.baseUrl}${EndPoints.post}');
    
    if (aToken != null && reToken != null) {
      final header = {'x-api-key': 'apikey@ciao', 'x-access-token': aToken,};
      try{
         var request = http.MultipartRequest('POST', url);
      request.headers.addAll(header);
      request.fields['caption']=caption;
      if(imagefile!.isNotEmpty){
        request.files.add(await http.MultipartFile.fromPath('media', imagefile));
        

      }
      var response = await request.send();
      print(response.statusCode);
      if (response.statusCode == 200) {
        print('Student added sucessfully');
        return response.statusCode;
      } else if(response.statusCode==400) {
        print('Status code is 400');
        String gResponse =
               await accessTokenReGenerator.accessReGenerator(aToken, reToken);
          log('$gResponse gresponse');
          secureStorage.writeSecureStorage('AccessToken', gResponse);
          aToken = gResponse;
          return addPost(imagefile, caption);
      }
      }catch(e){
        log(e.toString());
      }
      //final body = {'caption': caption, 'media': imagefile.path};
      // try {
      //   final response = await http.post(uri, headers: header, body: body);
      //   log(response.body.toString());
      //   if (response.statusCode == 200) {
      //     return response;
      //   } else if (400 == response.statusCode) { 
      //     log('response 400 from addpost');
      //     String gResponse =
      //         await accessTokenReGenerator.accessReGenerator(aToken, reToken);
      //     log('$gResponse gresponse');
      //     secureStorage.writeSecureStorage('AccessToken', gResponse);
      //     aToken = gResponse;
      //     return addPost(imagefile, caption);
      //   }
      //   log('error in add post');
      //   return null;
      // } catch (e) {
      //   print(e);
      // }
    }

return 00;
  }

  // Future<PostsResponse> fetchPosts() async {
  //   final response = await http.get(Uri.parse('$baseUrl/your-endpoint'));

  //   if (response.statusCode == 200) {
  //     return PostsResponse.fromJson(json.decode(response.body));
  //   } else {
  //     throw Exception('Failed to load posts');
  //   }
  // }
}
