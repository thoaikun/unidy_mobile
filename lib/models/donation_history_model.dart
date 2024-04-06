import 'dart:convert';
import 'package:unidy_mobile/models/campaign_post_model.dart';

List<DonationHistory> listDonationHistoryFromJson(String str) => List<DonationHistory>.from(json.decode(str).map((x) => DonationHistory.fromJson(x)));

DonationHistory donationHistoryFromJson(String str) => DonationHistory.fromJson(json.decode(str));

String donationHistoryToJson(DonationHistory data) => json.encode(data.toJson());

class DonationHistory {
  int? transactionId;
  String? transactionType;
  DateTime? transactionTime;
  int transactionAmount;
  String? transactionCode;
  String? signature;
  int organizationUserId;
  int campaignId;
  Campaign? campaign;
  UserInfo user;


  DonationHistory({
    this.transactionId,
    this.transactionType,
    this.transactionTime,
    required this.transactionAmount,
    this.transactionCode,
    this.signature,
    required this.organizationUserId,
    required this.campaignId,
    this.campaign,
    required this.user,
  });

  factory DonationHistory.fromJson(Map<String, dynamic> json) => DonationHistory(
    transactionId: json["transactionId"],
    transactionType: json["transactionType"],
    transactionTime: json["transactionTime"] != null ? DateTime.parse(json["transactionTime"]) : null,
    transactionAmount: json["transactionAmount"],
    transactionCode: json["transactionCode"],
    signature: json["signature"],
    organizationUserId: json["organizationUserId"],
    campaignId: json["campaignId"],
    campaign: json["campaign"] == null ? null : Campaign.fromJson(json["campaign"]),
    user: UserInfo.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "transactionId": transactionId,
    "transactionType": transactionType,
    "transactionTime": transactionTime?.toIso8601String(),
    "transactionAmount": transactionAmount,
    "transactionCode": transactionCode,
    "signature": signature,
    "organizationUserId": organizationUserId,
    "campaignId": campaignId,
    "campaign": campaign?.toJson(),
    "user": user.toJson(),
  };
}

class UserInfo {
  int userId;
  String fullName;
  String? linkImage;

  UserInfo({
    required this.userId,
    required this.fullName,
    required this.linkImage,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
    userId: json["userId"],
    fullName: json["fullName"],
    linkImage: json["linkImage"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "fullName": fullName,
    "linkImage": linkImage,
  };
}
