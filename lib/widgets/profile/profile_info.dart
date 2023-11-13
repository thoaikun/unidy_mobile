import 'package:flutter/material.dart';
import 'package:unidy_mobile/utils/formatter_util.dart';

class ProfileInfo extends StatelessWidget {
  const ProfileInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                onPressed: () {},
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
                Formatter.formatTime(DateTime.now()).toString(),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w300),
              )
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              Text('Giới tính: ', style: Theme.of(context).textTheme.labelLarge,),
              Text('Nam', style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w300),)
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              Text('Công việc: ', style: Theme.of(context).textTheme.labelLarge,),
              Text('Sinh viên', style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w300),)
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              Text('Tại: ', style: Theme.of(context).textTheme.labelLarge,),
              Text('Đại học Bách Khoa Tp.HCM', style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w300),)
            ],
          )
        ],
      ),
    );
  }
}
