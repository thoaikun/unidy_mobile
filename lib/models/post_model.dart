import 'dart:convert';

import 'package:unidy_mobile/models/user_model.dart';

List<Post> postListFromJson(String str) => List<Post>.from(json.decode(str).map((x) => Post.fromJson(x)));

String postListToJson(List<Post> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

Post postFromJson(String str) => Post.fromJson(json.decode(str));

String postToJson(Post data) => json.encode(data.toJson());

class Post {
  String postId;
  String content;
  String status;
  String createDate;
  String updateDate;
  bool isBlock;
  String linkImage;
  UserNode? userNodes;

  Post({
    required this.postId,
    required this.content,
    required this.status,
    required this.createDate,
    required this.updateDate,
    required this.isBlock,
    required this.linkImage,
    this.userNodes,
  });

  factory Post.fromJson(Map<String, dynamic> json) => Post(
    postId: json["postId"],
    content: json["content"],
    status: json["status"],
    createDate: json["createDate"],
    updateDate: json["updateDate"],
    isBlock: json["isBlock"],
    linkImage: json["linkImage"],
    userNodes: UserNode.fromJson(json["userNodes"]),
  );

  Map<String, dynamic> toJson() => {
    "postId": postId,
    "content": content,
    "status": status,
    "createDate": createDate,
    "updateDate": updateDate,
    "isBlock": isBlock,
    "linkImage": linkImage,
    "userNode": userNodes?.toJson(),
  };
}

class UserNode {
  int userId;
  String fullName;
  bool isBlock;
  String? profileImageLink;

  UserNode({
    required this.userId,
    required this.fullName,
    required this.isBlock,
    required this.profileImageLink,
  });

  static UserNode? fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return null;
    }
    return UserNode(
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

