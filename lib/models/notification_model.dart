import 'dart:convert';

List<NotificationItem> notificationItemListFromJson(String str) => List<NotificationItem>.from(json.decode(str).map((x) => NotificationItem.fromJson(x)));

NotificationItem notificationItemFromJson(String str) => NotificationItem.fromJson(json.decode(str));

String notificationInfoToJson(NotificationItem data) => json.encode(data.toJson());

enum ENotificationItemType {
  newCampaign,
  campaignEnd,
  friendRequest,
  friendAccept,
}

class Notification {
  List<NotificationItem> notificationItems;
  int totalUnseen;

  Notification({
    required this.notificationItems,
    this.totalUnseen = 0,
  });
}

class NotificationItem {
  int notificationId;
  String title;
  String description;
  DateTime createdTime;
  DateTime? seenTime;
  ENotificationItemType type;
  Extra extra;
  int receiver;
  Owner owner;

  NotificationItem({
    required this.notificationId,
    required this.title,
    required this.description,
    required this.createdTime,
    required this.seenTime,
    required this.type,
    required this.extra,
    required this.receiver,
    required this.owner,
  });

  factory NotificationItem.fromJson(Map<String, dynamic> json) => NotificationItem(
    notificationId: json["notificationId"],
    title: json["title"],
    description: json["description"],
    createdTime: DateTime.parse(json["createdTime"]),
    seenTime: json["seenTime"] == null ? null : DateTime.parse(json["seenTime"]),
    type: toNotificationItemType(json["type"]),
    extra: Extra.fromJson(json["extra"]),
    receiver: json["receiver"],
    owner: Owner.fromJson(json["owner"]),
  );

  Map<String, dynamic> toJson() => {
    "notificationId": notificationId,
    "title": title,
    "description": description,
    "createdTime": createdTime.toIso8601String(),
    "seenTime": seenTime,
    "type": type,
    "extra": extra.toJson(),
    "receiver": receiver,
    "owner": owner.toJson(),
  };
}

class Owner {
  int userId;
  String? fullName;
  String? linkImage;

  Owner({
    required this.userId,
    this.fullName,
    this.linkImage,
  });

  factory Owner.fromJson(Map<String, dynamic> json) => Owner(
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

class Extra {
  String id;

  Extra({
    required this.id
  });

  factory Extra.fromJson(Map<String, dynamic> json) => Extra(
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
  };
}

ENotificationItemType toNotificationItemType(String type) {
  switch (type) {
    case 'NEW_CAMPAIGN':
      return ENotificationItemType.newCampaign;
    case 'CAMPAIGN_END':
      return ENotificationItemType.campaignEnd;
    case 'FRIEND_REQUEST':
      return ENotificationItemType.friendRequest;
    case 'FRIEND_ACCEPT':
      return ENotificationItemType.friendAccept;
    default:
      return ENotificationItemType.newCampaign;
  }
}