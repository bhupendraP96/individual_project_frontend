import 'package:json_annotation/json_annotation.dart';

part 'photo.g.dart';

@JsonSerializable()
class Photo {
  @JsonKey(name: '_id')
  String? id;
  String? userId;
  String? owner;
  String? title;
  String? description;
  String? location;
  String? category;
  List<String>? likes;
  String? imageName;
  String? uploaded;

  Photo(
      {this.id,
      this.userId,
      this.owner,
      this.title,
      this.description,
      this.location,
      this.category,
      this.likes,
      this.imageName,
      this.uploaded});

  factory Photo.fromJson(Map<String, dynamic> obj) => _$PhotoFromJson(obj);
  Map<String, dynamic> toJson() => _$PhotoToJson(this);
}
