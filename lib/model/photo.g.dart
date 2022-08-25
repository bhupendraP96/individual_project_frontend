// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Photo _$PhotoFromJson(Map<String, dynamic> json) => Photo(
      id: json['_id'] as String?,
      userId: json['userId'] as String?,
      owner: json['owner'] as String?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      location: json['location'] as String?,
      category: json['category'] as String?,
      likes:
          (json['likes'] as List<dynamic>?)?.map((e) => e as String).toList(),
      imageName: json['imageName'] as String?,
      uploaded: json['uploaded'] as String?,
    );

Map<String, dynamic> _$PhotoToJson(Photo instance) => <String, dynamic>{
      '_id': instance.id,
      'userId': instance.userId,
      'owner': instance.owner,
      'title': instance.title,
      'description': instance.description,
      'location': instance.location,
      'category': instance.category,
      'likes': instance.likes,
      'imageName': instance.imageName,
      'uploaded': instance.uploaded,
    };
