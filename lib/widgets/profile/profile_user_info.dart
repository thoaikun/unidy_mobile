import 'package:flutter/material.dart';
import 'package:unidy_mobile/models/user_model.dart';
import 'package:unidy_mobile/utils/formatter_util.dart';

class ProfileUserInfo extends StatelessWidget {
  final User? user;

  const ProfileUserInfo({
    super.key,
    required this.user
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Thông tin cá nhân',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              IconButton(
                  onPressed: () => Navigator.pushNamed(context, '/profile/edit'),
                  icon: const Icon(
                    Icons.edit,
                    size: 20,
                  )
              )
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              Text(
                'Ngày sinh: ',
                style: Theme.of(context).textTheme.labelLarge,
              ),
              Text(
                Formatter.formatTime(user?.dayOfBirth ?? DateTime.now()).toString(),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w300),
              )
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              Text('Giới tính: ', style: Theme.of(context).textTheme.labelLarge,),
              Text(user?.sex ?? 'Không rõ', style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w300),)
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              Text('Công việc: ', style: Theme.of(context).textTheme.labelLarge,),
              Text(user?.job ?? 'không rõ', style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w300),)
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              Text('Tại: ', style: Theme.of(context).textTheme.labelLarge,),
              Text(user?.workLocation ?? 'Không rõ', style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w300),)
            ],
          )
        ],
      ),
    );
  }
}
