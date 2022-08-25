// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photo_resp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponsePhoto _$ResponsePhotoFromJson(Map<String, dynamic> json) =>
    ResponsePhoto(
      success: json['success'] as bool,
      result: (json['result'] as List<dynamic>)
          .map((e) => Photo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ResponsePhotoToJson(ResponsePhoto instance) =>
    <String, dynamic>{
      'success': instance.success,
      'result': instance.result.map((e) => e.toJson()).toList(),
    };
