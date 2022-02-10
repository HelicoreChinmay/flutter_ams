import 'dart:convert';

RejectTicketModel rejectTicketModelFromJson(String str) => RejectTicketModel.fromJson(json.decode(str));

String rejectTicketModelToJson(RejectTicketModel data) => json.encode(data.toJson());

class RejectTicketModel {
  String id;
  String reject_by;
  
  RejectTicketModel({
    this.id,
    this.reject_by,
  });

  factory RejectTicketModel.fromJson(Map<String, dynamic> json) => RejectTicketModel(
        id: json["id"],
        reject_by: json["reject_by"],
  );

  Map<String, dynamic> toJson() => {
        "id": id,
        "reject_by": reject_by,
        
      };
}
