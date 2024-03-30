import 'dart:convert';

List<Comment> commentListFromJson(String str) => List<Comment>.from(json.decode(str).map((x) => Comment.fromJson(x)));

Comment commentNodeFromJson(String str) => Comment.fromJson(json.decode(str));

String commentNodeToJson(Comment data) => json.encode(data.toJson());

class Comment {
  UserInfo user;
  CommentBody body;
  List<Comment> replies;
  bool haveReply;

  Comment({
    required this.user,
    required this.body,
    this.replies = const [],
    required this.haveReply
  });

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
    user: UserInfo.fromJson(json["user"]),
    body: CommentBody.fromJson(json["comment"]),
    replies: json["replies"] == null ? [] : List<Comment>.from(json["replies"].map((x) => Comment.fromJson(x))),
    haveReply: json["haveReply"]
  );

  Map<String, dynamic> toJson() => {
    "user": user.toJson(),
    "comment": body.toJson(),
    "replies": List<dynamic>.from(replies.map((x) => x.toJson())),
    "haveReply": haveReply
  };

  void addReply(Comment reply) {
    replies.add(reply);
  }

  void addAllReplies(List<Comment> replies) {
    this.replies.addAll(replies);
  }
}

class UserInfo {
  int userId;
  String fullName;
  bool isBlock;
  String? profileImageLink;
  String? role;

  UserInfo({
    required this.userId,
    required this.fullName,
    required this.isBlock,
    this.profileImageLink,
    this.role
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
    userId: json["userId"],
    fullName: json["fullName"],
    isBlock: json["isBlock"],
    profileImageLink: json["profileImageLink"],
    role: json["role"]
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "fullName": fullName,
    "isBlock": isBlock,
    "profileImageLink": profileImageLink,
    "role": role
  };
}

class CommentBody {
  int commentId;
  String body;

  CommentBody({
    required this.commentId,
    required this.body
  });

  factory CommentBody.fromJson(Map<String, dynamic> json) => CommentBody(
    commentId: json["commentId"],
    body: json["body"]
  );

  Map<String, dynamic> toJson() => {
    "commentId": commentId,
    "body": body
  };
}