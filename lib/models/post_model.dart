// To parse this JSON data, do
//
//     final post = postFromJson(jsonString);

import 'dart:convert';

List<Post> postListFromJson(String str) => List<Post>.from(json.decode(str).map((x) => Post.fromJson(x)));

Post postFromJson(String str) => Post.fromJson(json.decode(str));

String postToJson(List<Post> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Post {
  String postId;
  String content;
  String status;
  String createDate;
  String? updateDate;
  bool isBlock;
  String linkImage;
  UserNodes? userNodes;
  int? likeCount;

  Post({
    required this.postId,
    required this.content,
    required this.status,
    required this.createDate,
    required this.updateDate,
    required this.isBlock,
    required this.linkImage,
    required this.userNodes,
    required this.likeCount,
  });

  factory Post.fromJson(Map<String, dynamic> json) => Post(
    postId: json["postId"],
    content: json["content"],
    status: json["status"],
    createDate: json["createDate"],
    updateDate: json["updateDate"],
    isBlock: json["isBlock"],
    linkImage: json["linkImage"],
    userNodes: UserNodes.fromJson(json["userNodes"]),
    likeCount: json["likeCount"],
  );

  Map<String, dynamic> toJson() => {
    "postId": postId,
    "content": content,
    "status": status,
    "createDate": createDate,
    "updateDate": updateDate,
    "isBlock": isBlock,
    "linkImage": linkImage,
    "userNodes": userNodes?.toJson(),
    "likeCount": likeCount,
  };
}

class UserNodes {
  int userId;
  String fullName;
  bool isBlock;
  dynamic profileImageLink;

  UserNodes({
    required this.userId,
    required this.fullName,
    required this.isBlock,
    required this.profileImageLink,
  });

  static UserNodes? fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return null;
    }
    return UserNodes(
      userId: json["userId"],
      fullName: json["fullName"],
      isBlock: json["isBlock"],
      profileImageLink: json["profileImageLink"],
    );
  }

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "fullName": fullName,
    "isBlock": isBlock,
    "profileImageLink": profileImageLink,
  };
}
