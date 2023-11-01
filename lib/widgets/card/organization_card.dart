import 'package:flutter/material.dart';
import 'package:unidy_mobile/config/themes/color_config.dart';

class OrganizationCard extends StatelessWidget {
  final bool followed;
  const OrganizationCard({super.key, required this.followed});

  Widget _buildFollowBtn() {
    return TextButton.icon(
        onPressed: () {},
        icon: !followed ?
          const Icon(Icons.star_border_rounded) :
          const Icon(Icons.star_rounded, color: PrimaryColor.primary500),
        label: Text(followed ? 'Theo dõi' : 'Đã theo dõi')
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(
        radius: 20,
        backgroundImage: NetworkImage(
          'https://media.istockphoto.com/id/1335941248/photo/shot-of-a-handsome-young-man-standing-against-a-grey-background.jpg?s=612x612&w=0&k=20&c=JSBpwVFm8vz23PZ44Rjn728NwmMtBa_DYL7qxrEWr38=',
        ),
      ),
      title: const Text(
        'Tên tổ chức nha',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: const Text(
        '123k người theo dõi',
      ),
      trailing: _buildFollowBtn(),
      contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 15),
    );
  }
}
