import 'dart:convert';

import 'package:http/http.dart';
import 'package:android_assignment/response/user_resp.dart';
import '../model/user.dart';

class HttpConnectUser {
  String baseurl = 'http://192.168.0.106:90';
  static String token = '';
  static String uid = '';

// for registering new user
  Future<bool> registerPost(User user) async {
    Map<String, dynamic> userMap = {
      "username": user.username,
      "fullName": user.fullName,
      "eMail": user.eMail,
      "phoneNo": user.phoneNo,
      "password": user.password
    };

    final response =
        await post(Uri.parse(baseurl + '/user/register'), body: userMap);
    final jsonData = jsonDecode(response.body);

    if (jsonData['success']) {
      return true;
    }
    return false;
  }

  //for logging in

  Future<bool> loginPost(String username, String password) async {
    Map<String, dynamic> loginMap = {
      "username": username,
      "password": password
    };

    final response =
        await post(Uri.parse(baseurl + '/user/login'), body: loginMap);

    final loginData = ResponseUser.fromJson(jsonDecode(response.body));
    if (loginData.success!) {
      token = loginData.token!;
      uid = loginData.uId!;
      return true;
    }
    return false;
  }

//get user info
  Future<User> myProfileGet() async {
    String config = 'Bearer $token';
    final response = await get(Uri.parse(baseurl + '/user/profile'),
        headers: {'Authorization': config});
    if (response.statusCode == 200) {
      var uData = User.fromJson(jsonDecode(response.body));

      return uData;
    }
    throw Exception('Failed to load Photo information');
  }

  //delete users
  Future<bool> deleteUser() async {
    String url = baseurl + '/user/profile/delete';
    String config = 'Bearer $token';

    final response =
        await delete(Uri.parse(url), headers: {'Authorization': config});
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

//update user information
  Future<bool> updateUser(User user) async {
    Map<String, dynamic> userMap = {
      "fullName": user.fullName,
      "eMail": user.eMail,
      "phoneNo": user.phoneNo,
    };
    String url = baseurl + '/user/profile/update';
    String config = 'Bearer $token';

    try {
      final response = await put(Uri.parse(url),
          body: userMap, headers: {'Authorization': config});
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (err) {
      return false;
    }
  }
}
