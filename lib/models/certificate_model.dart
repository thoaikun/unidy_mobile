import 'dart:convert';

List<Certificate> certificateListFromJson(String str) => List<Certificate>.from(json.decode(str).map((x) => Certificate.fromJson(x)));

Certificate certificateFromJson(String str) => Certificate.fromJson(json.decode(str));

String certificateToJson(Certificate data) => json.encode(data.toJson());

class Certificate {
  int certificateId;
  int campaignId;
  String campaignName;
  int organizationId;
  String organizationName;
  String certificateLink;

  Certificate({
    required this.certificateId,
    required this.campaignId,
    required this.campaignName,
    required this.organizationId,
    required this.organizationName,
    required this.certificateLink,
  });

  factory Certificate.fromJson(Map<String, dynamic> json) => Certificate(
    certificateId: json["certificateId"],
    campaignId: json["campaignId"],
    campaignName: json["campaignName"],
    organizationId: json["organizationId"],
    organizationName: json["organizationName"],
    certificateLink: json["certificateLink"],
  );

  Map<String, dynamic> toJson() => {
    "certificateId": certificateId,
    "campaignId": campaignId,
    "campaignName": campaignName,
    "organizationId": organizationId,
    "organizationName": organizationName,
    "certificateLink": certificateLink,
  };
}