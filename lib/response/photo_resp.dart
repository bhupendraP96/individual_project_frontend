import 'package:android_assignment/model/photo.dart';
import 'package:json_annotation/json_annotation.dart';

part 'photo_resp.g.dart';

@JsonSerializable(explicitToJson: true)
class ResponsePhoto {
  final bool success;
  final List<Photo> result;

  ResponsePhoto({required this.success, required this.result});

  factory ResponsePhoto.fromJson(Map<String, dynamic> obj) =>
      _$ResponsePhotoFromJson(obj);

  Map<String, dynamic> toJson() => _$ResponsePhotoToJson(this);
}
