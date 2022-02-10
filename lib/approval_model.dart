import 'dart:convert';

ApprovalModel approvalModelFromJson(String str) => ApprovalModel.fromJson(json.decode(str));

String approvalModelToJson(ApprovalModel data) => json.encode(data.toJson());

class ApprovalModel {
  String id;
  String approve_by;
  
  ApprovalModel({
    this.id,
    this.approve_by,
  });

  factory ApprovalModel.fromJson(Map<String, dynamic> json) => ApprovalModel(
        id: json["id"],
        approve_by: json["approve_by"],
  );

  Map<String, dynamic> toJson() => {
        "id": id,
        "approve_by": approve_by,
        
      };
}
