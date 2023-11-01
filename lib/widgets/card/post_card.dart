import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:unidy_mobile/config/themes/color_config.dart';
import 'package:unidy_mobile/widgets/avatar/avatar_card.dart';
import 'package:unidy_mobile/widgets/comment/comment_tree.dart';
import 'package:unidy_mobile/widgets/image/image_slider.dart';
import 'package:unidy_mobile/widgets/input.dart';

class PostCard extends StatelessWidget {
  const PostCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: AvatarCard(showTime: true, description: 'Đã chia sẽ một kỉ niệm'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: _buildPostContent(context),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: _buildImageSlide(),
            ),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: _buildPostInteraction(context),
            )
          ],
        ),
      ),
    );
  }

  Widget searchResult(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 20, 0, 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImageList(context),
            const AvatarCard(showTime: true, description: 'Đã chia sẽ một kỉ niệm'),
            const SizedBox(height: 15),
            _buildPostContent(context),
            const SizedBox(height: 15),
            _buildPostInteraction(context)
          ],
        ),
      ),
    );
  }

  Widget _buildPostContent(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.start,
      crossAxisAlignment: WrapCrossAlignment.center,
      runSpacing: 5,
      children: [
        ReadMoreText(
          'Cake or pie? I can tell a lot about you by which one you pick. It may seem silly, but cake people and pie people are really different. I know which one I hope you are, but that\'s not for me to decide. So, what is it? Cake or pie? ',
          trimLines: 3,
          trimMode: TrimMode.Line,
          trimCollapsedText: 'Đọc thêm',
          trimExpandedText: '',
          moreStyle: Theme.of(context).textTheme.labelLarge?.copyWith(color: TextColor.textColor300),
        ),
        Text(
          '#dieforone #gogo',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(color: PrimaryColor.primary500),
        )
      ],
    );
  }

  Widget _buildPostInteraction(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.favorite_border_rounded)
            ),
            Text('4 lượt thích', style: Theme.of(context).textTheme.bodySmall)
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
        IconButton(onPressed: () {}, icon: const Icon(Icons.share_rounded))
      ],
    );
  }

  Widget _buildCommentSheetModal(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      minChildSize: 0.4,
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
                itemCount: 2,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (_, index) {
                  return CommentTree();
                },
              )
          ),
          AnimatedPadding(
            padding: MediaQuery.of(context).viewInsets,
            duration: const Duration(milliseconds: 100),
            curve: Curves.easeInOut,
            child:  Container(
                decoration: const BoxDecoration(
                    color: PrimaryColor.primary100
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                alignment: Alignment.bottomCenter,
                child: Input(
                    label: 'Bình luận',
                    placeholder: 'Nhập bình luận',
                    suffixIcon: IconButton(onPressed: () {}, icon: const Icon(Icons.send_rounded))
                )
            ),
          )
        ],
      ),
    );
  }

  Widget _buildImageSlide() {
    return const ImageSlider(imageUrls: [
      'https://upload.wikimedia.org/wikipedia/commons/6/6c/Vilnius_Marathon_2015_volunteers_by_Augustas_Didzgalvis.jpg',
      'https://kindful.com/wp-content/uploads/volunteer-management_Feature.jpg',
      'https://images.ctfassets.net/81iqaqpfd8fy/57NATA4649mbTvRfGpd6R1/911f94cdfd6089a77aefb4b1e9ebac7a/Teenvolunteercover.jpg'
    ]);
  }

  Widget _buildImageList(BuildContext context) {
    List<String> imgs = [
      'https://upload.wikimedia.org/wikipedia/commons/6/6c/Vilnius_Marathon_2015_volunteers_by_Augustas_Didzgalvis.jpg',
      'https://kindful.com/wp-content/uploads/volunteer-management_Feature.jpg',
      'https://images.ctfassets.net/81iqaqpfd8fy/57NATA4649mbTvRfGpd6R1/911f94cdfd6089a77aefb4b1e9ebac7a/Teenvolunteercover.jpg'
    ];
    List<Widget> result = [];

    for (int i = 0; i < imgs.length; i++) {
      if ( i < 2) {
        result.add(
          Image.network(
              imgs[i],
              width: ((MediaQuery.of(context).size.width - 70) / 3),
              height: ((MediaQuery.of(context).size.width - 70) / 3),
              loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) return child;
                return SizedBox(
                  width: ((MediaQuery.of(context).size.width - 70) / 3),
                  height: ((MediaQuery.of(context).size.width - 70) / 3),
                  child: const Center(
                    child: SizedBox(
                        width: 25,
                        height: 25,
                        child: CircularProgressIndicator()
                    ),
                  ),
                );
              },
              errorBuilder: (BuildContext context, Object child, StackTrace? error) => const Icon(Icons.error),
              fit: BoxFit.contain
          )
        );
      }
      else {
        result.add(Stack(
          children: [
            Image.network(
              imgs[i],
              width: ((MediaQuery.of(context).size.width - 70) / 3),
              height: ((MediaQuery.of(context).size.width - 70) / 3),
              loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) return child;
                return SizedBox(
                  width: ((MediaQuery.of(context).size.width - 70) / 3),
                  height: ((MediaQuery.of(context).size.width - 70) / 3),
                  child: const Center(
                    child: SizedBox(
                      width: 25,
                      height: 25,
                      child: CircularProgressIndicator(),
                    ),
                  ),
                );
              },
              errorBuilder: (BuildContext context, Object child, StackTrace? error) => const Icon(Icons.error),
              fit: BoxFit.contain,
            ),
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.5),
                child: Center(
                  child: Text(
                    '+ ${imgs.length - 2}',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white),
                  ),
                ),// Adjust opacity as needed
              ),
            ),
          ],
        ));
        break;
      }
    }

    return Wrap(
      spacing: 15,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      children: result
    );
  }
}
