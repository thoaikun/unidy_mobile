import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unidy_mobile/config/themes/color_config.dart';
import 'package:unidy_mobile/models/comment_model.dart';
import 'package:unidy_mobile/viewmodel/comment_viewmodel.dart';

class CommentCard extends StatelessWidget {
  final Comment comment;
  final double intend;

  const CommentCard({super.key, required this.comment, required this.intend});

  @override
  Widget build(BuildContext context) {
    return Consumer<CommentViewModel>(
      builder: (BuildContext context, CommentViewModel commentViewModel, Widget? child) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.network(
                    comment.user.profileImageLink ?? 'https://api.dicebear.com/7.x/initials/png?seed=${comment.user.fullName}',
                    width: 30,
                    height: 30,
                    colorBlendMode: BlendMode.clear,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 15),
              SizedBox(
                width: MediaQuery.of(context).size.width - 85 - (intend * 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      comment.user.fullName,
                      style: Theme.of(context).textTheme.titleSmall
                    ),
                    const SizedBox(height: 4),
                    Text(
                      comment.body.body,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodySmall
                    ),
                    const SizedBox(height: 4),
                    TextButton(
                      onPressed: () => commentViewModel.setFocusCommentId(comment.body.commentId),
                      style: const ButtonStyle(
                          padding: MaterialStatePropertyAll<EdgeInsetsGeometry?>(EdgeInsets.symmetric(vertical: 5, horizontal: 0)),
                          minimumSize: MaterialStatePropertyAll<Size?>(Size(45, 20)),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap
                      ),
                      child: Text(
                        'Trả lời',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(color: TextColor.textColor300),
                      )
                    ),
                    Visibility(
                      visible: comment.haveReply,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: TextButton(
                          onPressed: () => commentViewModel.loadReplies(comment.body.commentId, comment.replies.length),
                          style: const ButtonStyle(
                            padding: MaterialStatePropertyAll<EdgeInsetsGeometry?>(EdgeInsets.symmetric(vertical: 5)),
                            minimumSize: MaterialStatePropertyAll<Size?>(Size(45, 20)),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap
                          ),
                          child: Text(
                            'Xem thêm các câu trả lời',
                            style: Theme.of(context).textTheme.labelSmall?.copyWith(color: TextColor.textColor300),
                          )
                        ),
                      ),
                    )
                  ]
                ),
              )
            ],
          ),
        );
      }
    );
  }
}
