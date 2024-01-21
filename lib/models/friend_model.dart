import 'dart:convert';

List<FriendRequest> friendRequestListFromJson(String str) => List<FriendRequest>.from(json.decode(str).map((x) => FriendRequest.fromJson(x)));

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

List<FriendSuggestion> friendSuggestionListFromJson(String str) => List<FriendSuggestion>.from(json.decode(str).map((x) => FriendSuggestion.fromJson(x)));

FriendSuggestion friendSuggestionFromJson(String str) => FriendSuggestion.fromJson(json.decode(str));

String friendSuggestionToJson(FriendSuggestion data) => json.encode(data.toJson());

class FriendSuggestion {
  FiendSuggest fiendSuggest;
  int numOfMutualFriend;
  List<FiendSuggest> mutualFriends;

  FriendSuggestion({
    required this.fiendSuggest,
    required this.numOfMutualFriend,
    required this.mutualFriends,
  });

  factory FriendSuggestion.fromJson(Map<String, dynamic> json) => FriendSuggestion(
    fiendSuggest: FiendSuggest.fromJson(json["fiendSuggest"]),
    numOfMutualFriend: json["numOfMutualFriend"],
    mutualFriends: List<FiendSuggest>.from(json["mutualFriends"].map((x) => FiendSuggest.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "fiendSuggest": fiendSuggest.toJson(),
    "numOfMutualFriend": numOfMutualFriend,
    "mutualFriends": List<dynamic>.from(mutualFriends.map((x) => x.toJson())),
  };
}

class FiendSuggest {
  int userId;
  String fullName;
  bool isBlock;
  String? profileImageLink;

  FiendSuggest({
    required this.userId,
    required this.fullName,
    required this.isBlock,
    required this.profileImageLink,
  });

  factory FiendSuggest.fromJson(Map<String, dynamic> json) => FiendSuggest(
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
