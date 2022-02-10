// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel1 userModelFromJson1(String str) =>
    UserModel1.fromJson(json.decode(str));

String userModelToJson(UserModel1 data) => json.encode(data.toJson());

class UserModel1 {
  String mobileNo;
  String password;

  UserModel1({
    this.mobileNo,
    this.password,
  });

  factory UserModel1.fromJson(Map<String, dynamic> json) => UserModel1(
        mobileNo: json["MobileNo"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "MobileNo": mobileNo,
        "password": password,
      };
}
