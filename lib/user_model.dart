// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String birthDate;
  String bloodGroup;
  String currentHome;
  String degree;
  String education;
  String familySurname;
  String fathername;
  String firstName;
  String gender;
  String gotra;
  String imageType;
  String maritialStatus;
  String mobileNo;
  String mothername;
  String occupation;
  String officialSurname;
  String otherInfo;
  String profileImage;
  String sakha;
  String village;
  String college;
  String passyear;
  String email;
  String password;
  
  

  UserModel({
    this.birthDate,
    this.bloodGroup,
    this.currentHome,
    this.degree,
    this.education,
    this.familySurname,
    this.fathername,
    this.firstName,
    this.gender,
    this.gotra,
    this.imageType,
    this.maritialStatus,
    this.mobileNo,
    this.mothername,
    this.occupation,
    this.officialSurname,
    this.otherInfo,
    this.profileImage,
    this.sakha,
    this.village,
    this.college,
    this.passyear,
    this.email,
    this.password,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        birthDate: json["BirthDate"],
        bloodGroup: json["BloodGroup"],
        currentHome: json["CurrentHome"],
        degree: json["Degree"],
        education: json["Education"],
        familySurname: json["FamilySurname"],
        fathername: json["Fathername"],
        firstName: json["FirstName"],
        gender: json["Gender"],
        gotra: json["Gotra"],
        imageType: json["ImageType"],
        maritialStatus: json["MaritialStatus"],
        mobileNo: json["MobileNo"],
        mothername: json["Mothername"],
        occupation: json["Occupation"],
        officialSurname: json["OfficialSurname"],
        otherInfo: json["OtherInfo"],
        profileImage: json["ProfileImage"],
        sakha: json["Sakha"],
        village: json["Village"],
        college: json["college"],
        passyear: json["passyear"],
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "BirthDate": birthDate,
        "BloodGroup": bloodGroup,
        "CurrentHome": currentHome,
        "Degree": degree,
        "Education": education,
        "FamilySurname": familySurname,
        "Fathername": fathername,
        "FirstName": firstName,
        "Gender": gender,
        "Gotra": gotra,
        "ImageType": imageType,
        "MaritialStatus": maritialStatus,
        "MobileNo": mobileNo,
        "Mothername": mothername,
        "Occupation": occupation,
        "OfficialSurname": officialSurname,
        "OtherInfo": otherInfo,
        "ProfileImage": profileImage,
        "Sakha": sakha,
        "Village": village,
        "college": college,
        "passyear": passyear,
        "email": email,
        "password": password,
      };
}
