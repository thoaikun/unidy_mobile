import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:unidy_mobile/widgets/card/notification_card.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thông báo'),
        actions: [
          TextButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.checklist),
            label: const Text('Đã đọc')
          )
        ],
      ),
      body: Skeletonizer(
        enabled: false,
        child: ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            if (index % 4 == 0) {
              return const NotificationCard(
                isRead: false,
                content: 'Đây là thông báo chưa đọc, ban dã đăng ký thành công '
                    'lớp học thiện nguyện, chúng tôi cố gắng tạo ra bug để sửa'
              );
            }
            return const NotificationCard(isRead: true, content: 'Đây là thông báo chưa đọc');
          },
          separatorBuilder: (BuildContext context, int index) => const Divider(height: 0.5),
          itemCount: 7
        ),
      ),
    );
  }
}
