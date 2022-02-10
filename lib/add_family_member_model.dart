import 'dart:convert';

AddFamilyMember userModelFromJson(String str) =>
    AddFamilyMember.fromJson(json.decode(str));

String userModelToJson(AddFamilyMember data) => json.encode(data.toJson());

class AddFamilyMember {
  String address;
  String age;
  String birthdate;
  String bloodgroup;
  String degree;
  String fathername;
  String gender;
  String maritial;
  String mobile;
  String name;
  String occupation;
  String passyear;
  String type;
  String univercity;
  String profile;
  String imageType;

  AddFamilyMember({
    this.address,
    this.age,
    this.birthdate,
    this.bloodgroup,
    this.degree,
    this.fathername,
    this.gender,
    this.maritial,
    this.mobile,
    this.name,
    this.occupation,
    this.passyear,
    this.type,
    this.univercity,
    this.profile,
    this.imageType,
  });

  factory AddFamilyMember.fromJson(Map<String, dynamic> json) =>
      AddFamilyMember(
        address: json["address"],
        age: json["age"],
        birthdate: json["birthdate"],
        bloodgroup: json["bloodgroup"],
        degree: json["degree"],
        fathername: json["fathername"],
        gender: json["gender"],
        maritial: json["maritial"],
        mobile: json["mobile"],
        name: json["name"],
        occupation: json["occupation"],
        passyear: json["passyear"],
        type: json["type"],
        univercity: json["univercity"],
        profile: json["profile"],
        imageType: json["ImageType"],
      );

  Map<String, dynamic> toJson() => {
        "address": address,
        "age": age,
        "birthdate": birthdate,
        "bloodgroup": bloodgroup,
        "degree": degree,
        "fathername": fathername,
        "gender": gender,
        "maritial": maritial,
        "mobile": mobile,
        "name": name,
        "occupation": occupation,
        "passyear": passyear,
        "type": type,
        "univercity": univercity,
        "profile": profile,
        "ImageType": imageType,
      };
}
