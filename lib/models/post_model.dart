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
  UserNode? userNode;
  int likeCount;
  bool isLiked;

  Post({
    required this.postId,
    required this.content,
    required this.status,
    required this.createDate,
    required this.updateDate,
    required this.isBlock,
    required this.linkImage,
    required this.userNode,
    required this.likeCount,
    required this.isLiked
  });

  factory Post.fromJson(Map<String, dynamic> json) => Post(
    postId: json["postId"],
    content: json["content"],
    status: json["status"],
    createDate: json["createDate"],
    updateDate: json["updateDate"],
    isBlock: json["isBlock"],
    linkImage: json["linkImage"],
    userNode: UserNode.fromJson(json["userNode"]),
    likeCount: json["likeCount"] ?? 0,
    isLiked: json["isLiked"] ?? false
  );

  Map<String, dynamic> toJson() => {
    "postId": postId,
    "content": content,
    "status": status,
    "createDate": createDate,
    "updateDate": updateDate,
    "isBlock": isBlock,
    "linkImage": linkImage,
    "userNodes": userNode?.toJson(),
    "likeCount": likeCount,
    "isLiked": isLiked
  };
}

class UserNode {
  int userId;
  String fullName;
  bool isBlock;
  dynamic profileImageLink;

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
