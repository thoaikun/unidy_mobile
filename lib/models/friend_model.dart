import 'dart:convert';

List<Friend> friendListFromJson(String str) => List<Friend>.from(json.decode(str).map((x) => Friend.fromJson(x)));

Friend friendFromJson(String str) => Friend.fromJson(json.decode(str));

String friendToJson(Friend data) => json.encode(data.toJson());

class Friend {
  int userId;
  String fullName;
  bool isBlock;
  String? profileImageLink;
  String? role;

  Friend({
    required this.userId,
    required this.fullName,
    required this.isBlock,
    this.profileImageLink,
    this.role
  });

  factory Friend.fromJson(Map<String, dynamic> json) => Friend(
    userId: json["userId"],
    fullName: json["fullName"],
    isBlock: json["isBlock"],
    profileImageLink: json["profileImageLink"],
    role: json['role']
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "fullName": fullName,
    "isBlock": isBlock,
    "profileImageLink": profileImageLink,
    "role": role
  };
}


List<FriendRequest> friendRequestListFromJson(String str) => List<FriendRequest>.from(json.decode(str).map((x) => FriendRequest.fromJson(x)));

FriendRequest friendRequestFromJson(String str) => FriendRequest.fromJson(json.decode(str));

String friendRequestToJson(FriendRequest data) => json.encode(data.toJson());

class FriendRequest {
  UserRequest userRequest;
  DateTime requestAt;

  FriendRequest({
    required this.userRequest,
    required this.requestAt,
  });

  factory FriendRequest.fromJson(Map<String, dynamic> json) => FriendRequest(
    userRequest: UserRequest.fromJson(json["userRequest"]),
    requestAt: DateTime.parse(json["requestAt"]),
  );

  Map<String, dynamic> toJson() => {
    "userRequest": userRequest.toJson(),
    "requestAt": requestAt.toIso8601String(),
  };
}

class UserRequest {
  int userId;
  String fullName;
  bool isBlock;
  dynamic profileImageLink;

  UserRequest({
    required this.userId,
    required this.fullName,
    required this.isBlock,
    required this.profileImageLink,
  });

  factory UserRequest.fromJson(Map<String, dynamic> json) => UserRequest(
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
