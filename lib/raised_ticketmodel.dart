import 'dart:convert';

RaisedTicketModel raisedTicketModelFromJson(String str) => RaisedTicketModel.fromJson(json.decode(str));

String raisedTicketModelToJson(RaisedTicketModel data) => json.encode(data.toJson());

class RaisedTicketModel {
  String username;
  String descripation;
  String idea;
  String price;
  String image;

  RaisedTicketModel({
    this.username,
    this.descripation,
    this.idea,
    this.price,
    this.image,
  });

  factory RaisedTicketModel.fromJson(Map<String, dynamic> json) => RaisedTicketModel(
        username: json["username"],
        descripation: json["descripation"],
        idea: json["idea"],
        price: json["price"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "descripation": descripation,
        "idea": idea,
        "price": price,
        "image":image,
      };
}
