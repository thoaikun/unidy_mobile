import 'package:flutter/material.dart';
import 'package:unidy_mobile/config/color_config.dart';
import 'package:unidy_mobile/widgets/avatar/avatar_card.dart';

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

  Widget request(BuildContext context) {
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
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          OutlinedButton(
            onPressed: () {},
            style: const ButtonStyle(
                padding: MaterialStatePropertyAll(EdgeInsets.all(5))
            ),
            child: Text('Xóa', style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 10, color: TextColor.textColor900)),
          ),
          const SizedBox(width: 5),
          FilledButton(
              onPressed: () {},
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

  Widget addFriend(BuildContext context) {
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
          icon: const Icon(
              Icons.add_circle_outline,
              color: TextColor.textColor300,
              size: 18
          ),
          label: Text(
              'Kết bạn',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(color: TextColor.textColor300)
          )
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 15),
    );
  }
}
