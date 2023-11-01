import 'package:flutter/material.dart';
import 'package:unidy_mobile/config/themes/color_config.dart';

class AvatarCard extends StatelessWidget {
  final bool showTime;
  final String? description;

  const AvatarCard({super.key, this.showTime = false, this.description});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(
          radius: 18,
          backgroundImage: NetworkImage(
            'https://media.istockphoto.com/id/1335941248/photo/shot-of-a-handsome-young-man-standing-against-a-grey-background.jpg?s=612x612&w=0&k=20&c=JSBpwVFm8vz23PZ44Rjn728NwmMtBa_DYL7qxrEWr38=',
          ),
        ),
      title: Row(
        children: [
          Text(
            'Tên người dùng',
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
                  '10m',
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
