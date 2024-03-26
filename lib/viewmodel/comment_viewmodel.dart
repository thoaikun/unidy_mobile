import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:unidy_mobile/models/comment_model.dart';
import 'package:unidy_mobile/models/user_model.dart';
import 'package:unidy_mobile/services/campaign_service.dart';
import 'package:unidy_mobile/services/post_service.dart';

enum ECommentType {
  campaignComment,
  postComment
}

class CommentViewModel extends ChangeNotifier {
  final FocusNode focusNode = FocusNode();
  final TextEditingController commentController = TextEditingController();
  final PostService _postService = GetIt.instance<PostService>();
  final CampaignService _campaignService = GetIt.instance<CampaignService>();

  final int LIMIT = 3;
  bool isFirstLoading = true;
  bool isLoading = false;
  bool error = false;
  bool isLoadMoreVisible = false;
  dynamic id;
  ECommentType commentType;
  int? focusCommentId;

  CommentViewModel({required this.id, required this.commentType}) {
    initData();
    focusNode.addListener(() {
      if (!focusNode.hasFocus) {
        focusCommentId = null;
      }
    });
  }

  List<Comment> _commentList = [];
  List<Comment> get commentList => _commentList;

  void setFocusCommentId(int? value) {
    focusCommentId = value;
    focusNode.requestFocus();
  }

  void setCommentList(List<Comment> value) {
    _commentList = [..._commentList, ...value];
    notifyListeners();
  }

  void setIsFirstLoading(bool value) {
    isFirstLoading = value;
    notifyListeners();
  }

  void setIsLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  void setError(bool value) {
    error = value;
    notifyListeners();
  }

  void setLoadMoreVisible(bool value) {
    isLoadMoreVisible = value;
    notifyListeners();
  }

  void initData() async {
    try {
      List<Comment> comments = [];
      if (commentType == ECommentType.campaignComment) {
        comments = await _campaignService.getComments(id as String, limit: LIMIT);
      }
      else {
        comments = await _postService.getComments(id as String, limit: LIMIT);
      }
      setCommentList(comments);
    }
    catch (error) {
      setError(true);
    }
    finally {
      setIsFirstLoading(false);
    }
  }

  void loadMore() async {
    setIsLoading(true);
    try {
      List<Comment> comments = [];
      if (commentType == ECommentType.campaignComment) {
        comments = await _campaignService.getComments(id as String, skip: _commentList.length, limit: LIMIT);
      }
      else {
        comments = await _postService.getComments(id as String, skip: _commentList.length, limit: LIMIT);
      }
      setCommentList(comments);
    }
    catch (error) {
      setError(true);
    }
    finally {
      setIsLoading(false);
    }
  }

  void loadReplies(int commentId, int skip) async {
    try {
      List<Comment> replies = [];
      if (commentType == ECommentType.campaignComment) {
        replies = await _campaignService.getReplies(id as String, commentId, skip: skip, limit: LIMIT);
      }
      else {
        replies = await _postService.getReplies(id as String, commentId, skip: skip, limit: LIMIT);
      }
      appendReplies(commentId, replies, _commentList, 0);
      if (replies.length < LIMIT) {
        updateHaveReply(commentId, _commentList, _commentList, 0, false);
      }
    }
    catch (error) {
      setError(true);
    }
  }

  void appendReplies(int commentId, List<Comment> replies, List<Comment> baseComment, int level) {
    if (level > 3) return;

    for (Comment comment in baseComment) {
      if (comment.body.commentId == commentId) {
        comment.addAllReplies(replies);
        if (replies.length < LIMIT) {
          comment.haveReply = false;
        }
        notifyListeners();
        return;
      }
    }

    for (Comment comment in baseComment) {
      return appendReplies(commentId, replies, comment.replies, level + 1);
    }
  }

  void updateHaveReply(int commentId, List<Comment> replies, List<Comment> baseComment, int level, bool value) {
    if (level > 3) return;

    for (Comment comment in baseComment) {
      if (comment.body.commentId == commentId) {
        comment.haveReply = value;
        notifyListeners();
        return;
      }
    }

    for (Comment comment in baseComment) {
      return updateHaveReply(commentId, replies, comment.replies, level + 1, value);
    }
  }

  void onWriteComment(User user) async {
    try {
      if (focusCommentId != null) {
        if (commentType == ECommentType.campaignComment) {
          await _campaignService.createReply(id as String, focusCommentId!, commentController.text);
        }
        else {
          await _postService.createReply(id as String, focusCommentId!, commentController.text);
        }
        Comment newReply = Comment(
          user: UserInfo(
            userId: user.userId,
            fullName: user.fullName ?? 'Ẩn danh',
            isBlock: false,
            profileImageLink: user.image,
            role: user.role
          ),
          body: CommentBody(
            commentId: Random().nextInt(1000),
            body: commentController.text,
          ),
          replies: [],
          haveReply: false
        );
        appendReplies(focusCommentId!, [newReply], _commentList, 0);
      }
      else {
        if (commentType == ECommentType.campaignComment) {
          await _campaignService.createComment(id as String, commentController.text);
        }
        else {
          await _postService.createComment(id as String, commentController.text);
        }
        Comment newComment = Comment(
          user: UserInfo(
            userId: user.userId,
            fullName: user.fullName ?? 'Ẩn danh',
            isBlock: false,
            profileImageLink: user.image,
            role: user.role
          ),
          body: CommentBody(
            commentId: Random().nextInt(1000),
            body: commentController.text,
          ),
          replies: [],
          haveReply: false
        );
        setCommentList([newComment]);
      }
      commentController.clear();
    }
    catch (error) {
      setError(true);
    }
  }
}