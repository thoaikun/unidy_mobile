import 'package:flutter/material.dart';
import 'package:unidy_mobile/config/themes/color_config.dart';
import 'package:unidy_mobile/utils/formatter_util.dart';

class NotificationCard extends StatelessWidget {
  final String content;
  final DateTime? date;
  final bool isRead;

  const NotificationCard({
    super.key,
    required this.content,
    this.date,
    required this.isRead,
  });

  BoxDecoration _getBoxDecoration() {
    return BoxDecoration(
      color: !isRead ? PrimaryColor.primary50 : Colors.white
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        decoration: _getBoxDecoration(),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(
            content,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          subtitle: Text(
            Formatter.formatTime(date, 'dd/MM/yyyy - HH:mm') ?? Formatter.formatTime(DateTime.now(), 'dd/MM/yyyy - HH:mm').toString(),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: TextColor.textColor300)
          ),
          trailing: const CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(
              'https://images.goabroad.com/image/upload/f_auto/v1/images2/clients/logos/MAIN/pZRf5lMsqv0hXybWIn8Kjj4mLLG9FjcWBAqodXck.png'
            ),
          ),
        ),
      ),
    );
  }
}
