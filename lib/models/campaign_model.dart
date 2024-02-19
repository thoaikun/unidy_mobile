import 'dart:convert';

import 'package:unidy_mobile/models/volunteer_category_model.dart';

List<Campaign> campaignListFromJson(String str) => List<Campaign>.from(json.decode(str).map((x) => Campaign.fromJson(x)));

Campaign campaignFromJson(String str) => Campaign.fromJson(json.decode(str));

String campaignToJson(Campaign data) => json.encode(data.toJson());

enum CampaignStatus {
  inProgress,
  done,
  canceled
}

class Campaign {
  int campaignId;
  String title;
  String description;
  String? hagTag;
  String? linkImage;
  List<VolunteerCategory> categories;
  int? numberVolunteer;
  int? numberVolunteerRegistered;
  int? donationBudget;
  int? donationBudgetReceived;
  DateTime startDate;
  DateTime endDate;
  String location;
  CampaignStatus status;
  DateTime createDate;
  DateTime? updateDate;
  DateTime? updateBy;

  Campaign({
    required this.campaignId,
    required this.title,
    required this.description,
    this.hagTag,
    this.linkImage,
    required this.categories,
    this.numberVolunteer,
    this.numberVolunteerRegistered,
    this.donationBudget,
    this.donationBudgetReceived,
    required this.startDate,
    required this.endDate,
    required this.location,
    required this.status,
    required this.createDate,
    this.updateDate,
    this.updateBy,
  });

  factory Campaign.fromJson(Map<String, dynamic> json) => Campaign(
    campaignId: json["campaignId"],
    title: json["title"] ?? '',
    description: json["description"] ?? '',
    // categories: List<VolunteerCategory>.from(json["categories"].map((x) => fromStringToVolunteerCategory(x))),
    categories: json['categories'] != null ? List<VolunteerCategory>.from(json['categories'].map((x) => VolunteerCategory.fromString(x))) : [],
    hagTag: json["hagTag"],
    linkImage: json["linkImage"],
    numberVolunteer: json["numberVolunteer"],
    numberVolunteerRegistered: json["numberVolunteerRegistered"],
    donationBudget: json["donationBudget"],
    donationBudgetReceived: json["donationBudgetReceived"],
    startDate: DateTime.parse(json["startDate"]),
    endDate: DateTime.parse(json["endDate"]),
    location: json["location"],
    status: mapCampaignStatus(json["status"]),
    createDate: DateTime.parse(json["createDate"]),
    updateDate: json["updateDate"],
    updateBy: json["updateBy"],
  );

  Map<String, dynamic> toJson() => {
    "campaignId": campaignId,
    "title": title,
    "description": description,
    "categories": List<dynamic>.from(categories.map((x) => x.toString())),
    "hagTag": hagTag,
    "linkImage": linkImage,
    "numberVolunteer": numberVolunteer,
    "numberVolunteerRegistered": numberVolunteerRegistered,
    "donationBudget": donationBudget,
    "donationBudgetReceived": donationBudgetReceived,
    "startDate": startDate.toIso8601String(),
    "endDate": endDate.toIso8601String(),
    "location": location,
    "status": status,
    "createDate": createDate.toIso8601String(),
    "updateDate": updateDate,
    "updateBy": updateBy,
  };

  static mapCampaignStatus(String status) {
    switch (status) {
      case 'IN_PROGRESS':
        return CampaignStatus.inProgress;
      case 'DONE':
        return CampaignStatus.done;
      case 'CANCEL':
        return CampaignStatus.canceled;
      default:
        return CampaignStatus.inProgress;
    }
  }
}
