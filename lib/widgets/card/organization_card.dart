import 'package:flutter/material.dart';
import 'package:unidy_mobile/config/themes/color_config.dart';
import 'package:unidy_mobile/models/friend_model.dart';

class OrganizationCard extends StatelessWidget {
  final bool followed;
  final Friend organization;
  const OrganizationCard({super.key, required this.followed, required this.organization});

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
      leading: CircleAvatar(
        radius: 20,
        backgroundImage: NetworkImage(
          organization.profileImageLink ?? 'https://api.dicebear.com/7.x/initials/png?seed=${organization.fullName}',
        ),
      ),
      title: Text(
        organization.fullName,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: _buildFollowBtn(),
      contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 15),
    );
  }
}
