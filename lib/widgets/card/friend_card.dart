import 'package:flutter/material.dart';
import 'package:unidy_mobile/config/themes/color_config.dart';
import 'package:unidy_mobile/models/friend_model.dart';
import 'package:unidy_mobile/utils/formatter_util.dart';

class FriendCard extends StatelessWidget {
  const FriendCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(
        radius: 20,
        backgroundImage: NetworkImage(
          'https://media.istockphoto.com/id/1335941248/photo/shot-of-a-handsome-young-man-standing-against-a-grey-background.jpg?s=612x612&w=0&k=20&c=JSBpwVFm8vz23PZ44Rjn728NwmMtBa_DYL7qxrEWr38=',
        ),
      ),
      title: Text(
        'Trương Huy Thái',
        style: Theme.of(context).textTheme.bodyMedium,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: TextButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.people_alt, size: 18),
          label: const Text('Bạn bè')
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 15),
    );
  }
}

class RequestFriendCard extends StatelessWidget {
  final FriendRequest? friendRequest;
  final Future<bool> Function(FriendRequest? friendRequest)? onAccept;
  final Future<bool> Function(FriendRequest? friendRequest)? onDecline;
  const RequestFriendCard({
    super.key,
    this.friendRequest,
    this.onAccept,
    this.onDecline
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 20,
        backgroundImage: NetworkImage(
          friendRequest?.profileImageLink != null ? getImageUrl('profiles/${friendRequest?.profileImageLink}') : 'https://api.dicebear.com/7.x/initials/png?seed=${friendRequest?.fullName}',
        ),
      ),
      title: Text(
        friendRequest?.fullName ?? '',
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

  const AddFriendCard({
    super.key,
    this.friendSuggestion,
    this.onSendFriendRequest,
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
          widget.friendSuggestion?.fiendSuggest.profileImageLink ?? 'https://api.dicebear.com/7.x/initials/png?seed=${widget.friendSuggestion?.fiendSuggest.fullName}',
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
    );
  }
}

