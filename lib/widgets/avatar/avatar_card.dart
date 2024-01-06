import 'package:flutter/material.dart';
import 'package:unidy_mobile/config/themes/color_config.dart';
import 'package:unidy_mobile/utils/formatter_util.dart';

class AvatarCard extends StatelessWidget {
  final bool showTime;
  final String? description;
  final String? userName;
  final String? avatarUrl;
  final String? createdAt;

  const AvatarCard({
    super.key,
    this.showTime = false,
    this.description,
    this.userName,
    this.avatarUrl,
    this.createdAt
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
          radius: 18,
          backgroundImage: NetworkImage(
            avatarUrl ?? 'https://api.dicebear.com/7.x/initials/png?seed=$userName'
          ),
        ),
      title: Row(
        children: [
          Text(
            userName ?? 'Tên người dùng',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const SizedBox(width: 10),
          Visibility(
            visible: showTime,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 4,
                  height: 4,
                  decoration: BoxDecoration(
                    color: TextColor.textColor300,
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                const SizedBox(width: 5),
                Text(
                  Formatter.calculateTimeDifference(createdAt),
                  // '1 giờ trước',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w300),
                )
              ],
            ),
          )
        ],
      ),
      subtitle: description != null ?  Text(
          description ?? '',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: TextColor.textColor300)
      ) : null,
      contentPadding: const EdgeInsets.symmetric(horizontal: 0),
    );
  }
}
