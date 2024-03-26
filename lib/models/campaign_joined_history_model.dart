import 'dart:convert';
import 'package:unidy_mobile/models/campaign_post_model.dart';

List<CampaignJoinedHistory> campaignJoinedHistoryListFromJson(String str) => List<CampaignJoinedHistory>.from(json.decode(str).map((x) => CampaignJoinedHistory.fromJson(x)));

CampaignJoinedHistory campaignJoinedHistoryFromJson(String str) => CampaignJoinedHistory.fromJson(json.decode(str));

String campaignJoinedHistoryToJson(CampaignJoinedHistory data) => json.encode(data.toJson());

class CampaignJoinedHistory {
  int userId;
  int campaignId;
  DateTime timeJoin;
  String status;
  Campaign campaign;

  CampaignJoinedHistory({
    required this.userId,
    required this.campaignId,
    required this.timeJoin,
    required this.status,
    required this.campaign,
  });

  factory CampaignJoinedHistory.fromJson(Map<String, dynamic> json) => CampaignJoinedHistory(
    userId: json["userId"],
    campaignId: json["campaignId"],
    timeJoin: DateTime.parse(json["timeJoin"]),
    status: json["status"],
    campaign: Campaign.fromJson(json["campaign"]),
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "campaignId": campaignId,
    "timeJoin": timeJoin.toIso8601String(),
    "status": status,
    "campaign": campaign.toJson(),
  };
}