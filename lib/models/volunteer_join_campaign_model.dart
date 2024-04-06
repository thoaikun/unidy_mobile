import 'dart:convert';

List<VolunteerJoinCampaign> listVolunteerJoinCampaignFromJson(String str) => List<VolunteerJoinCampaign>.from(json.decode(str).map((x) => VolunteerJoinCampaign.fromJson(x)));

VolunteerJoinCampaign volunteerJoinCampaignFromJson(String str) => VolunteerJoinCampaign.fromJson(json.decode(str));

String volunteerJoinCampaignToJson(VolunteerJoinCampaign data) => json.encode(data.toJson());

enum CampaignJoinStatus {
  notApproveYet,
  approve,
  reject,
}

class VolunteerJoinCampaign {
  int userId;
  String fullName;
  int age;
  String job;
  String workLocation;
  DateTime timeJoin;
  CampaignJoinStatus status;
  int campaignId;
  String? linkImage;

  VolunteerJoinCampaign({
    required this.userId,
    required this.fullName,
    required this.age,
    required this.job,
    required this.workLocation,
    required this.timeJoin,
    required this.status,
    required this.campaignId,
    this.linkImage,
  });

  factory VolunteerJoinCampaign.fromJson(Map<String, dynamic> json) => VolunteerJoinCampaign(
    userId: json["userId"],
    fullName: json["fullName"],
    age: json["age"],
    job: json["job"],
    workLocation: json["workLocation"],
    timeJoin: DateTime.parse(json["timeJoin"]),
    status: toCampaignJoinStatus(json["status"]),
    campaignId: json["campaignId"],
    linkImage: json["linkImage"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "fullName": fullName,
    "age": age,
    "job": job,
    "workLocation": workLocation,
    "timeJoin": timeJoin.toIso8601String(),
    "status": status,
    "campaignId": campaignId,
    "linkImage": linkImage,
  };

  static toCampaignJoinStatus(String status) {
    switch (status) {
      case 'NOT_APPROVE_YET':
        return CampaignJoinStatus.notApproveYet;
      case 'APPROVE':
        return CampaignJoinStatus.approve;
      case 'REJECT':
        return CampaignJoinStatus.reject;
      default:
        return CampaignJoinStatus.notApproveYet;
    }
  }
}
