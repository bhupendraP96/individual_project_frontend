import 'package:floor/floor.dart';

@entity
class FUser {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String? username;
  final String? fullName;
  final String? eMail;
  final String? phoneNo;
  final String? password;

  FUser({
    this.id,
    this.username,
    this.fullName,
    this.eMail,
    this.phoneNo,
    this.password,
  });
}
