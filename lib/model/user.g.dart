// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['_id'] as String?,
      username: json['username'] as String?,
      fullName: json['fullName'] as String?,
      eMail: json['eMail'] as String?,
      phoneNo: json['phoneNo'] as String?,
      password: json['password'] as String?,
      followers: json['followers'] as List<dynamic>?,
      following: json['following'] as List<dynamic>?,
      userImage: json['userImage'] as String?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      '_id': instance.id,
      'username': instance.username,
      'fullName': instance.fullName,
      'eMail': instance.eMail,
      'phoneNo': instance.phoneNo,
      'password': instance.password,
      'followers': instance.followers,
      'following': instance.following,
      'userImage': instance.userImage,
    };
