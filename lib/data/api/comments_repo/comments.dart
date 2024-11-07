import 'dart:convert';
import 'dart:developer';

import 'package:verbinden/core/endpoints.dart';
import 'package:verbinden/data/api/profile_repo/section_2/profile_section_service.dart';
import 'package:verbinden/data/models/comment_model/comment_model.dart';

import '../../secure_storage/secure_storage.dart';
import 'package:http/http.dart' as http;

class CommentService {
  SecureStorageService secureStorage = SecureStorageService();
  GetTokensHere tokens = GetTokensHere();
  Future<int?> addComment(
      {required int postId, required String comment}) async {
    String? accessToken = await tokens.getAccessToken();
    String? refreshToken = await tokens.getRefreshToken();

    final url =
        Uri.parse('${EndPoints.baseUrl}${EndPoints.post}${EndPoints.comment}');
    if (accessToken != null && refreshToken != null) {
      final header = {
        'x-api-key': 'apikey@ciao',
        'x-access-token': accessToken,
        'Content-Type': 'application/json',
      };
      final body = jsonEncode({'PostID': postId, 'CommentText': comment});
      try {
        log('flag one -> $url');
        final response = await http.post(url, headers: header, body: body);
        log('response from add comment is ${response.statusCode}');
        if (response.statusCode == 200) {
          log(response.body);
          return response.statusCode;
        } else if (response.statusCode == 400) {
          String newAccessToken = await tokens.getAccessTokenRegenerator();
          // await accessTokenReGenerator.accessReGenerator(aToken, reToken);
          log('$newAccessToken newAccessToken');
          secureStorage.writeSecureStorage('AccessToken', newAccessToken);

          accessToken = newAccessToken;
          log('add commet 400 again trying->${response.body}');
          return response.statusCode;
          //return addComment(postId: postId, comment: comment);
          
        }
      } catch (e) {
        log('$e errorcatch from addcomment');
      }
    } else {
      log('tokken expired from addComment');
    }
    return null;
  }

//
  Future<List<CommentModel>?> getComments({required int postId}) async {
    String? accessToken = await tokens.getAccessToken();
    String? refreshToken = await tokens.getRefreshToken();

    final url = Uri.parse(
        '${EndPoints.baseUrl}${EndPoints.post}${EndPoints.comment}/$postId');

    if (accessToken != null && refreshToken != null) {
      final header = {
        'x-api-key': 'apikey@ciao',
        'x-access-token': accessToken,
        // 'Content-Type': 'application/json',
      };
      // final body ={'CommentId':4,'CommentText':" comment test text edited"};
      try {
        print('in try getcommets api');
        final response = await http.get(url, headers: header);
        log('response from getComment ${response.statusCode}');
        if (response.statusCode == 200) {
          print("----------------------response 200 ${response.body}");

          log('getComment fetched');
          final data = jsonDecode(response.body);
          print(data);
          List<CommentModel>? commentModel = [];
          for (var item in data['after execution']['ParentComments']) {
            print('$item item');
            commentModel.add(CommentModel.fromJson(item));
          }
          return commentModel;
        } else if (response.statusCode == 400) {
          String newAccessToken = await tokens.getAccessTokenRegenerator();
          // await accessTokenReGenerator.accessReGenerator(aToken, reToken);
          log('$newAccessToken newAccessToken');
          secureStorage.writeSecureStorage('AccessToken', newAccessToken);

          accessToken = newAccessToken;
          return [];
          //getComments(postId: postId);
        }
        return null;
        // throw Exception('error on get comment');
      } catch (e) {
        log('$e for getComments');
        throw Exception('error $e');
      }
    } else {
      log('token expired frm getComment');
      throw Exception('token is missing');
    }
   
  }

  //get count
  Future<int> getCommentCount({required int postId}) async {
    String? accessToken = await tokens.getAccessToken();
    String? refreshToken = await tokens.getRefreshToken();

    final url = Uri.parse(
        '${EndPoints.baseUrl}${EndPoints.post}${EndPoints.comment}/${postId}');

    if (accessToken != null && refreshToken != null) {
      final header = {
        'x-api-key': 'apikey@ciao',
        'x-access-token': accessToken,
        // 'Content-Type': 'application/json',
      };
      try {
        final response = await http.get(url, headers: header);
        if (response.statusCode == 200) {
          log('getComment count fetched');
          final data = jsonDecode(response.body);
          print(response.body);
          int commentCount = data['after execution']['ParentCommentsCount'];
          return commentCount;
        } else if (response.statusCode == 400) {
          String newAccessToken = await tokens.getAccessTokenRegenerator();
          // await accessTokenReGenerator.accessReGenerator(aToken, reToken);
          log('$newAccessToken newAccessToken');
          secureStorage.writeSecureStorage('AccessToken', newAccessToken);

          accessToken = newAccessToken;
          return response.statusCode;
          //getCommentCount(postId: postId);
        }
        return 0;
        //throw Exception('error in get comment count');
      } catch (e) {
        log('$e for getCommentscount');
        throw Exception('error $e');
      }
    } else {
      log('token expired frm getCommentCount');
      throw Exception('token is missing');
    }
  }

//edit commmet
  Future<int?> editComment(
      {required int commentId, required String commentText}) async {
    String? accessToken = await tokens.getAccessToken();
    String? refreshToken = await tokens.getRefreshToken();
// log('AT:$accessToken || RT : $refreshToken');
    final url = Uri.parse(
        '${EndPoints.baseUrl}${EndPoints.post}${EndPoints.comment}');

    if (accessToken != null && refreshToken != null) {
      final header = {
        'x-api-key': 'apikey@ciao',
        'x-access-token': accessToken,
         'Content-Type': 'application/json',
      };
      final body = jsonEncode({'CommentId': commentId, 'CommentText': commentText});
      try {
        log('befor res ${body}');
        final response = await http.patch(url, headers: header, body: body);
        log('response edit comment = ${response.body}');
        if (response.statusCode == 200) {
          log('edit successfuly');
          return response.statusCode;
        } else if (response.statusCode == 400) {
         
          log('response status code is ${response.statusCode}');
          String newAccessToken = await tokens.getAccessTokenRegenerator();
          log('newAccessToken is $newAccessToken');
          secureStorage.writeSecureStorage('AccessToken', newAccessToken);
          accessToken = newAccessToken;
          return response.statusCode;
          //editComment(commentId: commentId, commentText: commentText);
        }else{
          return response.statusCode;
        }
      } catch (e) {
        log('error $e');
      }
    }
    return null;
  }

//delete comment
  Future<int?> deleteComment({required int commentId}) async {
    String? accessToken = await tokens.getAccessToken();
    String? refreshToken = await tokens.getRefreshToken();

    final url = Uri.parse(
        '${EndPoints.baseUrl}${EndPoints.post}${EndPoints.comment}/$commentId');

    if (accessToken != null && refreshToken != null) {
      final header = {
        'x-api-key': 'apikey@ciao',
        'x-access-token': accessToken,
        // 'Content-Type': 'application/json',
      };
      try {
        final response = await http.delete(url, headers: header);
        if (response.statusCode == 200) {
          log('response 200 in delete');
          return response.statusCode;
        } else if (response.statusCode == 400) {
          String newAccessToken = await tokens.getAccessTokenRegenerator();
          // await accessTokenReGenerator.accessReGenerator(aToken, reToken);
          log('$newAccessToken newAccessToken');
          secureStorage.writeSecureStorage('AccessToken', newAccessToken);

          accessToken = newAccessToken;
          return response.statusCode;
          //deleteComment(commentId: commentId);
        }
        return 00;
      } catch (e) {
        log(e.toString());
      }
    }
    return null;
  }
}
