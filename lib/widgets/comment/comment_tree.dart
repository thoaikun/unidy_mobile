import 'package:flutter/material.dart';
import 'package:unidy_mobile/widgets/comment/comment_card.dart';

class Comment {
  String body;
  String user;
  List<Comment> replies;

  Comment({
    required this.user,
    required this.body,
    required this.replies
  });
}

class CommentTree extends StatelessWidget {
  final Comment comment = Comment(
    user: 'Thoai Le',
    body: 'Test comment 1',
    replies: [
      Comment(user: 'Zy khung', body: 'Reply comment 1', replies: []),
      Comment(user: 'Zy khung', body: 'Reply comment 1', replies: [
        // Comment(user: 'Thai Truong', body: 'Reply 2', replies: []),
        // Comment(user: 'Thai Truong', body: 'Reply 3', replies: []),
      ]),
    ]
  );

  CommentTree({super.key});

  Widget _buildCommentTree(Comment comment, double intend) {
    if (comment.replies.isEmpty) {
      return CommentCard(user: comment.user, body: comment.body, intend: intend,);
    }

    List<Widget> replies = comment.replies.map((Comment reply) => _buildCommentTree(reply, intend + 1)).toList();

    Widget commentTree = Column(
      children: [
        CommentCard(user: comment.user, body: comment.body, intend: intend ,),
        Row(
          children: [
            SizedBox(width: 20 * intend),
            Column(
              children: replies,
            )
          ]
        )
      ],
    );

    return commentTree;
  }

  @override
  Widget build(BuildContext context) {
    return _buildCommentTree(comment, 1);
  }
}
