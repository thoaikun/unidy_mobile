import 'package:flutter/material.dart';
import 'package:unidy_mobile/config/themes/color_config.dart';
import 'package:unidy_mobile/models/friend_model.dart';
import 'package:unidy_mobile/utils/formatter_util.dart';

class FriendCard extends StatelessWidget {
  final Friend? friend;
  final void Function(int? userId)? onUnfriend;
  final void Function()? onTap;

  const FriendCard({
    super.key,
    this.friend,
    this.onUnfriend,
    this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 20,
        backgroundImage: NetworkImage(
          friend?.profileImageLink != null ? '${friend?.profileImageLink}' : 'https://api.dicebear.com/7.x/initials/png?seed=${friend?.fullName}',
        ),
      ),
      title: Text(
        friend?.fullName ?? '',
        style: Theme.of(context).textTheme.bodyMedium,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: TextButton.icon(
          onPressed: () => showAlertDialog(context),
          icon: const Icon(Icons.people_alt, size: 18),
          label: const Text('Bạn bè')
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 15),
      onTap: () => onTap?.call(),
    );
  }

  void showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Xác nhận'),
          content: const Text('Bạn có chắc chắn muốn xóa bạn bè này?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Hủy'),
            ),
            TextButton(
              onPressed: () {
                onUnfriend?.call(friend?.userId);
                Navigator.pop(context);
              },
              child: const Text('Xóa'),
            ),
          ],
        );
      },
    );
  }
}

class RequestFriendCard extends StatelessWidget {
  final FriendRequest? friendRequest;
  final Future<bool> Function(FriendRequest? friendRequest)? onAccept;
  final Future<bool> Function(FriendRequest? friendRequest)? onDecline;
  final void Function()? onTap;
  const RequestFriendCard({
    super.key,
    this.friendRequest,
    this.onAccept,
    this.onDecline,
    this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 20,
        backgroundImage: NetworkImage(
          friendRequest?.userRequest.profileImageLink != null ? '${friendRequest?.userRequest.profileImageLink}' : 'https://api.dicebear.com/7.x/initials/png?seed=${friendRequest?.userRequest.fullName}',
        ),
      ),
      title: Text(
        friendRequest?.userRequest.fullName ?? '',
        style: Theme.of(context).textTheme.bodyMedium,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          OutlinedButton(
            onPressed: () {
              onDecline?.call(friendRequest)
                  .then((value) => ScaffoldMessenger.of(context).showSnackBar(_buildSnakeBar(value ? 'Đã xóa lời mời' : 'Có lỗi xảy ra')));
            },
            style: const ButtonStyle(
                padding: MaterialStatePropertyAll(EdgeInsets.all(5))
            ),
            child: Text('Xóa', style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 10, color: TextColor.textColor900)),
          ),
          const SizedBox(width: 5),
          FilledButton(
              onPressed: () {
                onAccept?.call(friendRequest)
                    .then((value) => ScaffoldMessenger.of(context).showSnackBar(_buildSnakeBar(value ? 'Đã chập nhận lời mời' : 'Có lỗi xảy ra')));
              },
              style: const ButtonStyle(
                  padding: MaterialStatePropertyAll(EdgeInsets.symmetric(horizontal: 8, vertical: 5))
              ),
              child: Text('Chấp nhận', style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 10, color: Colors.white))
          )
        ],
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 15),
      onTap: onTap,
    );
  }

  SnackBar _buildSnakeBar(String content) {
    return SnackBar(
      content:Text(content),
      duration: const Duration(seconds: 2),
    );
  }
}

class AddFriendCard extends StatefulWidget {
  final FriendSuggestion? friendSuggestion;
  final Future<void> Function(int? userId)? onSendFriendRequest;
  final void Function()? onTap;

  const AddFriendCard({
    super.key,
    this.friendSuggestion,
    this.onSendFriendRequest,
    this.onTap
  });

  @override
  State<AddFriendCard> createState() => _AddFriendCardState();
}

class _AddFriendCardState extends State<AddFriendCard> {
  bool? isSentRequest;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 20,
        backgroundImage: NetworkImage(
          widget.friendSuggestion?.fiendSuggest.profileImageLink != null ? '${widget.friendSuggestion?.fiendSuggest.profileImageLink}' : 'https://api.dicebear.com/7.x/initials/png?seed=${widget.friendSuggestion?.fiendSuggest.fullName}',
        ),
      ),
      title: Text(
        widget.friendSuggestion?.fiendSuggest.fullName ?? '',
        style: Theme.of(context).textTheme.bodyMedium,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: TextButton.icon(
          onPressed: () {
            widget.onSendFriendRequest?.call(widget.friendSuggestion?.fiendSuggest.userId)
                .then((_) => setState(() => isSentRequest = true));
          },
          icon: Icon(
              isSentRequest == true ? Icons.check_rounded : Icons.add_circle_outline,
              color:  isSentRequest == true ? PrimaryColor.primary500 : TextColor.textColor300,
              size: 18
          ),
          label: Text(
              isSentRequest == true ? 'Đã gửi' : 'Kết bạn',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(color: isSentRequest == true ? PrimaryColor.primary500 : TextColor.textColor300)
          )
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 15),
      onTap: widget.onTap,
    );
  }
}

