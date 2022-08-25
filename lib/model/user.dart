import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  //@PrimaryKey(autoGenerate: true);
  @JsonKey(name: '_id')
  final String? id;
  final String? username;
  final String? fullName;
  final String? eMail;
  final String? phoneNo;
  final String? password;
  final List? followers;
  final List? following;
  final String? userImage;

  User(
      {this.id,
      this.username,
      this.fullName,
      this.eMail,
      this.phoneNo,
      this.password,
      this.followers,
      this.following,
      this.userImage});

  factory User.fromJson(Map<String, dynamic> obj) => _$UserFromJson(obj);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
