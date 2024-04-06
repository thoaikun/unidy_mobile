import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:unidy_mobile/screens/user/campaign_detail/campaign_detail_screen_container.dart';
import 'package:unidy_mobile/screens/user/detail_profile/volunteer_profile/volunteer_profile_container.dart';
import 'package:unidy_mobile/viewmodel/notification_viewmodel.dart';
import 'package:unidy_mobile/widgets/card/notification_card.dart';
import 'package:unidy_mobile/models/notification_model.dart';
import 'package:unidy_mobile/widgets/empty.dart';
import 'package:unidy_mobile/widgets/list_item.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {

  @override
  Widget build(BuildContext context) {
    NotificationViewModel notificationViewModel = Provider.of<NotificationViewModel>(context, listen: true);

    if (notificationViewModel.notificationItems.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Thông báo'),
          actions: [
            TextButton.icon(
              onPressed: null,
              icon: const Icon(Icons.checklist),
              label: const Text('Đã đọc')
            )
          ],
        ),
        body: const Center(
          child: Empty(description: 'Không có thông báo nào')
        )
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Thông báo'),
        actions: [
          TextButton.icon(
            onPressed: notificationViewModel.onMarkAsRead,
            icon: const Icon(Icons.checklist),
            label: const Text('Đã đọc')
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          return Future.delayed(const Duration(seconds: 1))
              .then((value) => notificationViewModel.onRefresh());
        },
        backgroundColor: Colors.white,
        strokeWidth: 2,
        notificationPredicate: (ScrollNotification notification) {
          return notification.depth == 0;
        },
        child: ListItem<NotificationItem>(
          items: notificationViewModel.notificationItems,
          length: notificationViewModel.notificationItems.length,
          itemBuilder: (BuildContext context, int index) {
            NotificationItem item = notificationViewModel.notificationItems[index];
            return NotificationCard(
              notificationItem: item,
              onTap: () {
                notificationViewModel.onMarkAsReadItem(item.notificationId);
                _handleNavigate(item);
              }
            );
          },
          separatorBuilder: (BuildContext context, int index) => const Divider(height: 0.5),
          onLoadMore: notificationViewModel.loadMore,
          onRetry: notificationViewModel.loadMore,
          error: notificationViewModel.error,
          isFirstLoading: notificationViewModel.isFirstLoading,
          isLoading: notificationViewModel.isLoadMoreLoading,
        ),
      )
    );
  }

  void _handleNavigate(NotificationItem item) {
    switch(item.type) {
      case ENotificationItemType.friendRequest:
        Navigator.push(context, MaterialPageRoute(builder: (context) => VolunteerProfileContainer(volunteerId: int.parse(item.extra.id))));
        break;
      case ENotificationItemType.friendAccept:
        Navigator.push(context, MaterialPageRoute(builder: (context) => VolunteerProfileContainer(volunteerId: int.parse(item.extra.id))));
        break;
      case ENotificationItemType.newCampaign:
        break;
      case ENotificationItemType.campaignEnd:
        Navigator.push(context, MaterialPageRoute(builder: (context) => CampaignDetailScreenContainer(campaignId: item.extra.id)));
    }
  }
}
