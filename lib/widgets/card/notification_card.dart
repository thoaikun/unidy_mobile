import 'package:flutter/material.dart';
import 'package:unidy_mobile/config/themes/color_config.dart';
import 'package:unidy_mobile/models/notification_model.dart';
import 'package:unidy_mobile/utils/formatter_util.dart';

class NotificationCard extends StatelessWidget {
  final NotificationItem notificationItem;
  final void Function()? onTap;

  const NotificationCard({
    super.key,
    required this.notificationItem,
    this.onTap
  });

  BoxDecoration _getBoxDecoration() {
    return BoxDecoration(
      color: notificationItem.seenTime == null ? PrimaryColor.primary50 : Colors.white
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: _getBoxDecoration(),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(
            notificationItem.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          subtitle: Text(
            Formatter.formatTime(notificationItem.createdTime, 'dd/MM/yyyy - HH:mm') ?? Formatter.formatTime(DateTime.now(), 'dd/MM/yyyy - HH:mm').toString(),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: TextColor.textColor300)
          ),
          trailing: CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(
              notificationItem.owner.linkImage ?? 'https://api.dicebear.com/7.x/initials/png?seed=${notificationItem.owner.fullName}',
            ),
          ),
        ),
      ),
    );
  }
}
