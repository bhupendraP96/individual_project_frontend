import 'dart:convert';
import 'dart:io';

import 'package:android_assignment/http/httpuser.dart';
import 'package:android_assignment/response/photo_resp.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:android_assignment/model/photo.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HttpConnectPhoto {
  String baseurl = 'http://192.168.0.106:90';
  String token = HttpConnectUser.token;

//upload image
  Future<bool> uploadImage(String filepath, String id) async {
    try {
      String url = baseurl + '/android/photos/update/' + id;

      var request = http.MultipartRequest('PUT', Uri.parse(url));

      request.headers.addAll({'Authorization': 'Bearer $token'});

      var filename = filepath.split('/').last;
      //print("Filepath 11111:" + filepath);

      request.files.add(
        http.MultipartFile('addimage', File(filepath).readAsBytes().asStream(),
            File(filepath).lengthSync(),
            filename: filename),
      );

      var response = await request.send();
      // print("response message:: " + response.statusCode.toString());
      // response.stream.transform(utf8.decoder).listen((value) {
      //   print(value);
      // });

      // skipped something
      if (response.statusCode == 200) {
        return true;
      }
    } catch (err) {
      return false;
    }
    return false;
  }

//add image description
  addPhotoPost(Photo photo, File file) async {
    Map<String, dynamic> photoMap = {
      "title": photo.title,
      "description": photo.description,
      "location": photo.location,
      "category": photo.category,
    };
    String config = 'Bearer $token';
    try {
      final response = await http.post(
          Uri.parse(baseurl + "/android/photos/upload"),
          body: photoMap,
          headers: {'Authorization': config});

      if (response.statusCode == 200) {
        // print("body1111111111" + response.body);
        Map<String, dynamic> jsonData = jsonDecode(response.body);
        //    print("json data :" + jsonData.toString());
        bool isAdded = await uploadImage(file.path, jsonData['result']['_id']);
        if (isAdded) {
          Fluttertoast.showToast(
            msg: "Image successfully uploaded",
            backgroundColor: Colors.green,
          );
        }
      }
    } catch (err) {
      //   print('upload error: ' + err.toString());
      Fluttertoast.showToast(
        msg: "Upload failed. Try Again",
        backgroundColor: Colors.red,
      );
    }
  }

  //view all posts
  Future<List<Photo>> viewAllPhotoGet() async {
    final response = await http.get(Uri.parse(baseurl + '/photos/view'));

    if (response.statusCode == 200) {
      var photoData = ResponsePhoto.fromJson(jsonDecode(response.body));
      print("dfdddddd: ${photoData.result}");
      return photoData.result;
    } else {
      Fluttertoast.showToast(
        msg: "Something went wrong. Try refreshing again",
        backgroundColor: Colors.red,
      );
      throw Exception('Failed to load students');
    }
  }

//update posts
  Future<bool> updateImagePut(Photo photo) async {
    Map<String, dynamic> photoMap = {
      "title": photo.title,
      "description": photo.description,
      "location": photo.location,
      "category": photo.category,
      "pid": photo.id
    };
    String config = 'Bearer $token';
    try {
      final response = await http.put(Uri.parse(baseurl + '/photos/update'),
          body: photoMap, headers: {'Authorization': config});
      if (response.statusCode == 200) {
        return true;
      }
    } catch (err) {
      return false;
    }
    return false;
  }

//single posts data
  Future<Photo> photoDataGet(String pid) async {
    final String url = baseurl + '/viewimage/' + pid;
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var photoData = jsonDecode(response.body);
      //var id = photoData['_id'];
      // print("thi is idddddd:" + id);
      var pData = Photo.fromJson(photoData);
      return pData;
    }
    throw Exception('Failed to load Photo information');
  }

  //user specific posts
  Future<List<Photo>> usersPostsGet(String? uid) async {
    String url = baseurl + '/photos/myphotos/' + uid!;

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var photoData = ResponsePhoto.fromJson(jsonDecode(response.body));
      return photoData.result;
    }
    throw Exception("Unable to load data.");
  }

//deleting posts
  Future<bool> deletePost(String pid) async {
    String config = 'Bearer $token';
    String url = baseurl + '/photos/delete/' + pid;

    final response =
        await http.delete(Uri.parse(url), headers: {'Authorization': config});
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> likePhoto(String pid, String uid) async {
    String url = baseurl + '/photos/like/' + pid + '/' + uid;
    final res = await http.put(Uri.parse(url));
    if (res.statusCode == 200) {
      return true;
    } else if (res.statusCode == 201) {
      return false;
    }
    throw Exception("Something went wrong. Please try again");
  }
}
