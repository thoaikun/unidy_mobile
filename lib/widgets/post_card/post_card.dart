import 'package:flutter/material.dart';
import 'package:unidy_mobile/config/color_config.dart';
import 'package:unidy_mobile/widgets/avatar/avatar_card.dart';
import 'package:unidy_mobile/widgets/comment_card.dart';
import 'package:unidy_mobile/widgets/image_slider.dart';

class PostCard extends StatelessWidget {
  const PostCard({super.key});

  Widget _buildPostContent(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Cake or pie? I can tell a lot about you by which one you pick. It may seem silly, but cake people and pie people are really different. I know which one I hope you are, but that\'s not for me to decide. So, what is it? Cake or pie?',
          maxLines: 4,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 5),
        Text(
          '#dieforone #gogo',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(color: PrimaryColor.primary500),
        )
      ],
    );
  }

  Widget _buildPostInteration(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          children: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.favorite_border_rounded)),
            const Text('4 lượt thích')
          ],
        ),
        IconButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              isDismissible: true,
              shape: const RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.vertical(top: Radius.circular(8))
              ),
              builder: (BuildContext context) => _buildCommentSheetModal(context)
            );
          },
          icon: const Icon(Icons.chat_bubble_outline_rounded)
        ),
        IconButton(onPressed: () {}, icon: const Icon(Icons.send_rounded))
      ],
    );
  }

  Widget _buildCommentSheetModal(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.4,
      minChildSize: 0.2,
      maxChildSize: 0.9,
      expand: false,
      builder: (_, controller) => Column(
        children: [
          const Icon(
            Icons.remove,
            size: 40,
            color: TextColor.textColor200,
          ),
          Expanded(
            child: ListView.builder(
              controller: controller,
              itemCount: 5,
              itemBuilder: (_, index) {
                return const CommentCard();
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AvatarCard(showTime: true, description: 'Đã chia sẽ một kỉ niệm'),
            const SizedBox(height: 15),
            _buildPostContent(context),
            const SizedBox(height: 15),
            const ImageSlider(imageUrls: [
              'https://upload.wikimedia.org/wikipedia/commons/6/6c/Vilnius_Marathon_2015_volunteers_by_Augustas_Didzgalvis.jpg',
              'https://kindful.com/wp-content/uploads/volunteer-management_Feature.jpg',
              'https://images.ctfassets.net/81iqaqpfd8fy/57NATA4649mbTvRfGpd6R1/911f94cdfd6089a77aefb4b1e9ebac7a/Teenvolunteercover.jpg'
            ]),
            const SizedBox(height: 15),
            _buildPostInteration(context)
          ],
        ),
      ),
    );
  }
}
