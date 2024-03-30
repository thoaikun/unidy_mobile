import 'package:flutter/material.dart';
import 'package:unidy_mobile/config/themes/color_config.dart';
import 'package:unidy_mobile/models/friend_model.dart';

class OrganizationCard extends StatelessWidget {
  final Friend organization;
  final void Function()? onTap;

  const OrganizationCard({
    super.key,
    required this.organization,
    this.onTap
  });

  Widget _buildFollowBtn() {
    return TextButton.icon(
        onPressed: () {},
        icon: organization.isFollow != true ?
          const Icon(Icons.star_border_rounded) :
          const Icon(Icons.star_rounded, color: PrimaryColor.primary500),
        label: Text(organization.isFollow != true ? 'Theo dõi' : 'Đã theo dõi')
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
      onTap: onTap,
    );
  }
}
