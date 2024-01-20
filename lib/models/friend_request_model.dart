import 'dart:convert';

FriendRequest friendRequestFromJson(String str) => FriendRequest.fromJson(json.decode(str));

String friendRequestToJson(FriendRequest data) => json.encode(data.toJson());

class FriendRequest {
  int userId;
  String fullName;
  bool isBlock;
  String? profileImageLink;

  FriendRequest({
    required this.userId,
    required this.fullName,
    required this.isBlock,
    this.profileImageLink,
  });

  factory FriendRequest.fromJson(Map<String, dynamic> json) => FriendRequest(
    userId: json["userId"],
    fullName: json["fullName"],
    isBlock: json["isBlock"],
    profileImageLink: json["profileImageLink"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "fullName": fullName,
    "isBlock": isBlock,
    "profileImageLink": profileImageLink,
  };
}
