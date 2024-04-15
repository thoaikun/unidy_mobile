import 'dart:convert';

CampaignData campaignDataFromJson(String str) => CampaignData.fromJson(json.decode(str));

List<CampaignPost> campaignPostListFromJson(String str) => List<CampaignPost>.from(json.decode(str).map((x) => CampaignPost.fromJson(x)));

List<Campaign> listCampaignFromJson(String str) => List<Campaign>.from(json.decode(str).map((x) => Campaign.fromJson(x)));

CampaignPost campaignPostFromJson(String str) => CampaignPost.fromJson(json.decode(str));

Campaign campaignFromJson(String str) => Campaign.fromJson(json.decode(str));

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
  CampaignCategory? campaignType;

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
    this.campaignType,
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
    linkImage: json["linkImage"] ?? json['link_image'],
    userNode: json["userNode"],
    donate: json["donate"],
    donationBudget: json["donationBudget"],
    donationBudgetReceived: json["donationBudgetReceived"],
    userLikes: List<dynamic>.from(json["userLikes"]?.map((x) => x) ?? []),
    campaignType: json["campaignType"] != null ? CampaignCategory.fromJson(json["campaignType"]) : null,
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
    "campaignType": campaignType?.toJson(),
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
    case 'COMPLETE':
      return CampaignStatus.done;
    case 'CANCELED':
      return CampaignStatus.canceled;
    default:
      return CampaignStatus.inProgress;
  }
}

class CampaignCategory {
  int typeId;
  int campaignId;
  double communityType;
  double education;
  double research;
  double helpOther;
  double environment;
  double healthy;
  double emergencyPreparedness;

  CampaignCategory({
    required this.typeId,
    required this.campaignId,
    required this.communityType,
    required this.education,
    required this.research,
    required this.helpOther,
    required this.environment,
    required this.healthy,
    required this.emergencyPreparedness,
  });

  factory CampaignCategory.fromJson(Map<String, dynamic> json) => CampaignCategory(
    typeId: json["typeId"],
    campaignId: json["campaignId"],
    communityType: json["communityType"]?.toDouble(),
    education: json["education"]?.toDouble(),
    research: json["research"]?.toDouble(),
    helpOther: json["helpOther"]?.toDouble(),
    environment: json["environment"]?.toDouble(),
    healthy: json["healthy"]?.toDouble(),
    emergencyPreparedness: json["emergencyPreparedness"],
  );

  Map<String, dynamic> toJson() => {
    "typeId": typeId,
    "campaignId": campaignId,
    "communityType": communityType,
    "education": education,
    "research": research,
    "helpOther": helpOther,
    "environment": environment,
    "healthy": healthy,
    "emergencyPreparedness": emergencyPreparedness,
  };
}
