import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unidy_mobile/bloc/profile_cubit.dart';
import 'package:unidy_mobile/config/themes/color_config.dart';
import 'package:unidy_mobile/models/comment_model.dart';
import 'package:unidy_mobile/models/user_model.dart';
import 'package:unidy_mobile/viewmodel/comment_viewmodel.dart';
import 'package:unidy_mobile/widgets/comment/comment_card.dart';
import 'package:unidy_mobile/widgets/error.dart';
import 'package:unidy_mobile/widgets/input/input.dart';

class CommentTree extends StatefulWidget {
  final dynamic id;
  final ECommentType commentType;
  const CommentTree({super.key, required this.id, required this.commentType});

  @override
  State<CommentTree> createState() => _CommentTreeState();
}

class _CommentTreeState extends State<CommentTree> {
  Widget _buildCommentTree(Comment comment, double intend) {
    if (comment.replies.isEmpty) {
      return CommentCard(comment: comment, intend: intend,);
    }

    List<Widget> replies = comment.replies.map((Comment reply) => _buildCommentTree(reply, intend + 1)).toList();

    Widget commentTree = Column(
      children: [
        CommentCard(comment: comment, intend: intend ,),
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

  Widget _buildComments(BuildContext context, ScrollController controller) {
    return Consumer<CommentViewModel>(
      builder: (BuildContext context, CommentViewModel commentViewModel, Widget? child) {
        if (commentViewModel.isFirstLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (commentViewModel.error) {
          return const ErrorPlaceholder();
        }

        return ListView.builder(
          itemCount: commentViewModel.commentList.length + 1,
          controller: controller,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            if (index == commentViewModel.commentList.length) {
              if (commentViewModel.isLoading) {
                return const Center(child:
                  SizedBox(
                    height: 15,
                    width: 15,
                    child: CircularProgressIndicator(strokeWidth: 2,)
                  )
                );
              }
              return const SizedBox(height: 20);
            }
            else {
              return _buildCommentTree(commentViewModel.commentList[index], 1);
            }
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CommentViewModel(id: widget.id, commentType: widget.commentType),
      child: Consumer<CommentViewModel>(
        builder: (BuildContext context, CommentViewModel commentViewModel, Widget? child) {
          return DraggableScrollableSheet(
            initialChildSize: 0.6,
            minChildSize: 0.4,
            maxChildSize: 0.9,
            expand: false,
            builder: (_, controller) {
              controller.addListener(() {
                if (controller.position.pixels == controller.position.maxScrollExtent) {
                  commentViewModel.setLoadMoreVisible(true);
                }
              });

              return Column(
                children: [
                  const Icon(
                    Icons.remove,
                    size: 40,
                    color: TextColor.textColor200,
                  ),
                  Expanded(
                    child: _buildComments(context, controller),
                  ),
                  Visibility(
                    visible: commentViewModel.isLoadMoreVisible,
                    child: TextButton(
                      onPressed: () => commentViewModel.loadMore(),
                      child: const Text('Xem thêm bình luận'),
                    ),
                  ),
                  AnimatedPadding(
                    padding: MediaQuery.of(context).viewInsets,
                    duration: const Duration(milliseconds: 100),
                    curve: Curves.easeInOut,
                    child:  Container(
                        decoration: const BoxDecoration(
                            color: PrimaryColor.primary100
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        alignment: Alignment.bottomCenter,
                        child: Input(
                            controller: commentViewModel.commentController,
                            focusNode: commentViewModel.focusNode,
                            label: 'Bình luận',
                            placeholder: 'Nhập bình luận',
                            suffixIcon: IconButton(
                                onPressed: () {
                                  commentViewModel.onWriteComment();
                                },
                                icon: const Icon(Icons.send_rounded))
                        )
                    ),
                  )
                ],
              );
            },
          );
        }
      ),
    );
  }
}
