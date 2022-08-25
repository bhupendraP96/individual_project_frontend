class ResponseUser {
  bool? success;
  String? token;
  String? uId;

  ResponseUser({this.success, this.token, this.uId});

  factory ResponseUser.fromJson(Map<String, dynamic> json) {
    return ResponseUser(
        success: json['success'], token: json['token'], uId: json['uId']);
  }
}
