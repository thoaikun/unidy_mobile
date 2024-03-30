import 'dart:convert';

CampaignData campaignDataFromJson(String str) => CampaignData.fromJson(json.decode(str));

List<CampaignPost> campaignPostListFromJson(String str) => List<CampaignPost>.from(json.decode(str).map((x) => CampaignPost.fromJson(x)));

CampaignPost campaignPostFromJson(String str) => CampaignPost.fromJson(json.decode(str));

String campaignPostToJson(CampaignPost data) => json.encode(data.toJson());

class CampaignData {
  final List<CampaignPost> campaigns;
  final int total;
  final int nextOffset;

  CampaignData({
    required this.campaigns,
    required this.total,
    required this.nextOffset,
  });

  factory CampaignData.fromJson(Map<String, dynamic> json) => CampaignData(
    campaigns: List<CampaignPost>.from(json["campaigns"].map((x) => CampaignPost.fromJson(x))),
    total: json["total"],
    nextOffset: json["nextOffset"],
  );

  Map<String, dynamic> toJson() => {
    "campaigns": List<CampaignPost>.from(campaigns.map((x) => x.toJson())),
    "total": total,
    "nextOffset": nextOffset,
  };
}

class CampaignPost {
  Campaign campaign;
  OrganizationNode organizationNode;
  bool isLiked;
  bool? isJoined;
  int likeCount;

  CampaignPost({
    required this.campaign,
    required this.organizationNode,
    required this.isLiked,
    this.isJoined,
    required this.likeCount,
  });

  factory CampaignPost.fromJson(Map<String, dynamic> json) => CampaignPost(
    campaign: Campaign.fromJson(json["campaign"]),
    organizationNode: OrganizationNode.fromJson(json["organizationNode"]),
    isLiked: json["isLiked"],
    isJoined: json["isJoined"],
    likeCount: json["likeCount"],
  );

  Map<String, dynamic> toJson() => {
    "campaign": campaign.toJson(),
    "organizationNode": organizationNode.toJson(),
    "isLiked": isLiked,
    "isJoined": isJoined,
    "likeCount": likeCount,
  };
}

class Campaign {
  String campaignId;
  String? hashTag;
  String? title;
  String description;
  CampaignStatus status;
  String startDate;
  String endDate;
  String? timeTakePlace;
  String location;
  String? createDate;
  String? updateDate;
  bool? isBlock;
  String? linkImage;
  int? numOfRegister;
  int? numberVolunteerRegistered;
  int? numberVolunteer;
  int? donate;
  int? donationBudget;
  int? donationBudgetReceived;
  dynamic userNode;
  List<dynamic> userLikes;

  Campaign({
    required this.campaignId,
    this.hashTag,
    this.title,
    required this.description,
    required this.status,
    required this.startDate,
    required this.endDate,
    required this.timeTakePlace,
    required this.location,
    this.numOfRegister,
    this.numberVolunteerRegistered,
    this.numberVolunteer,
    required this.createDate,
    this.updateDate,
    this.isBlock,
    this.linkImage,
    required this.userNode,
    this.donate,
    this.donationBudget,
    this.donationBudgetReceived,
    required this.userLikes,
  });

  factory Campaign.fromJson(Map<String, dynamic> json) => Campaign(
    campaignId: json["campaignId"].toString(),
    hashTag: json["hashTag"],
    title: json["title"],
    description: json["content"] ?? json["description"],
    status: toCampaignStatus(json['status']),
    startDate: json["startDate"],
    endDate: json["endDate"],
    timeTakePlace: json["timeTakePlace"],
    location: json["location"],
    numOfRegister: json["numOfRegister"],
    numberVolunteerRegistered: json["numberVolunteerRegistered"],
    numberVolunteer: json["numberVolunteer"],
    createDate: json["createDate"],
    updateDate: json["updateDate"],
    isBlock: json["isBlock"],
    linkImage: json["linkImage"],
    userNode: json["userNode"],
    donate: json["donate"],
    donationBudget: json["donationBudget"],
    donationBudgetReceived: json["donationBudgetReceived"],
    userLikes: List<dynamic>.from(json["userLikes"]?.map((x) => x) ?? []),
  );

  Map<String, dynamic> toJson() => {
    "campaignId": campaignId,
    "hashTag": hashTag,
    "title": title,
    "description": description,
    "status": status,
    "startDate": startDate,
    "endDate": endDate,
    "timeTakePlace": timeTakePlace,
    "location": location,
    "numOfRegister": numOfRegister,
    "numberVolunteerRegistered": numberVolunteerRegistered,
    "numberVolunteer": numberVolunteer,
    "createDate": createDate,
    "updateDate": updateDate,
    "isBlock": isBlock,
    "linkImage": linkImage,
    "userNode": userNode,
    "donate": donate,
    "donationBudget": donationBudget,
    "donationBudgetReceived": donationBudgetReceived,
    "userLikes": userLikes != null ? List<dynamic>.from(userLikes!.map((x) => x)) : null,
  };
}

class OrganizationNode {
  int userId;
  String fullName;
  bool isBlock;
  String? profileImageLink;
  String role;

  OrganizationNode({
    required this.userId,
    required this.fullName,
    required this.isBlock,
    required this.profileImageLink,
    required this.role,
  });

  factory OrganizationNode.fromJson(Map<String, dynamic> json) => OrganizationNode(
    userId: json["userId"],
    fullName: json["fullName"],
    isBlock: json["isBlock"],
    profileImageLink: json["profileImageLink"],
    role: json["role"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "fullName": fullName,
    "isBlock": isBlock,
    "profileImageLink": profileImageLink,
    "role": role,
  };
}

enum CampaignStatus {
  inProgress,
  done,
  canceled
}

CampaignStatus toCampaignStatus(String? value) {
  switch (value) {
    case 'IN_PROGRESS':
      return CampaignStatus.inProgress;
    case 'DONE':
      return CampaignStatus.done;
    case 'CANCELED':
      return CampaignStatus.canceled;
    default:
      return CampaignStatus.inProgress;
  }
}