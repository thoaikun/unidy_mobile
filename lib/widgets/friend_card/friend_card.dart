import 'package:flutter/material.dart';
import 'package:unidy_mobile/config/color_config.dart';
import 'package:unidy_mobile/widgets/avatar/avatar_card.dart';

class FriendCard extends StatelessWidget {
  const FriendCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const AvatarCard(),
          TextButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.people_alt, size: 18),
            label: const Text('Bạn bè')
          )
        ],
      ),
    );
  }

  Widget request(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const AvatarCard(),
          Row(
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
          )
        ],
      ),
    );
  }

  Widget addFriend(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const AvatarCard(),
          TextButton.icon(
              onPressed: () {},
              icon: const Icon(
                Icons.add_circle_outline,
                color: TextColor.textColor300,
                size: 18
              ),
              label: Text(
                'Kết bạn',
                style: Theme.of(context).textTheme.labelMedium?.copyWith(color: TextColor.textColor300)
              )
          )
        ],
      ),
    );
  }
}
