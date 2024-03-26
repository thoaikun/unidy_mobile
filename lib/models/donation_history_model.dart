import 'dart:convert';
import 'package:unidy_mobile/models/campaign_post_model.dart';

List<DonationHistory> donationHistoryListFromJson(String str) => List<DonationHistory>.from(json.decode(str).map((x) => DonationHistory.fromJson(x)));

DonationHistory donationHistoryFromJson(String str) => DonationHistory.fromJson(json.decode(str));

String donationHistoryToJson(DonationHistory data) => json.encode(data.toJson());

class DonationHistory {
  int transactionId;
  String transactionType;
  DateTime transactionTime;
  int transactionAmount;
  String transactionCode;
  String signature;
  int organizationUserId;
  int campaignId;
  int userId;
  Campaign campaign;

  DonationHistory({
    required this.transactionId,
    required this.transactionType,
    required this.transactionTime,
    required this.transactionAmount,
    required this.transactionCode,
    required this.signature,
    required this.organizationUserId,
    required this.campaignId,
    required this.userId,
    required this.campaign,
  });

  factory DonationHistory.fromJson(Map<String, dynamic> json) => DonationHistory(
    transactionId: json["transactionId"],
    transactionType: json["transactionType"],
    transactionTime: DateTime.parse(json["transactionTime"]),
    transactionAmount: json["transactionAmount"],
    transactionCode: json["transactionCode"],
    signature: json["signature"],
    organizationUserId: json["organizationUserId"],
    campaignId: json["campaignId"],
    userId: json["userId"],
    campaign: Campaign.fromJson(json["campaign"]),
  );

  Map<String, dynamic> toJson() => {
    "transactionId": transactionId,
    "transactionType": transactionType,
    "transactionTime": transactionTime.toIso8601String(),
    "transactionAmount": transactionAmount,
    "transactionCode": transactionCode,
    "signature": signature,
    "organizationUserId": organizationUserId,
    "campaignId": campaignId,
    "userId": userId,
    "campaign": campaign.toJson(),
  };
}