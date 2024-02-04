import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:unidy_mobile/config/themes/color_config.dart';
import 'package:unidy_mobile/models/campaign_model.dart';
import 'package:unidy_mobile/models/post_model.dart';
import 'package:unidy_mobile/widgets/avatar/avatar_card.dart';
import 'package:unidy_mobile/widgets/comment/comment_tree.dart';
import 'package:unidy_mobile/widgets/image/image_slider.dart';
import 'package:unidy_mobile/widgets/input/input.dart';

class PostCard extends StatelessWidget {
  final Post? post;
  final String? userName;
  final String? avatarUrl;
  final void Function()? onLikePost;

  const PostCard({
    super.key,
    this.post,
    this.userName,
    this.avatarUrl,
    this.onLikePost
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () => onLikePost?.call(),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: AvatarCard(
                showTime: true,
                userName: userName,
                avatarUrl: avatarUrl,
                createdAt: post?.createDate,
                description: 'Đang cảm thấy ${post?.status.toLowerCase()}'
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: _buildPostContent(context),
            ),
            const SizedBox(height: 15),
            Visibility(
              visible: post?.linkImage != null,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _buildImageSlide(),
              ),
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

  Widget buildSkeleton(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: AvatarCard(
                  showTime: true,
                  userName: userName,
                  avatarUrl: avatarUrl,
                  createdAt: post?.createDate,
                  description: 'Đang cảm thấy ${post?.status.toLowerCase()}'
              ),
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

  Widget _buildPostContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ReadMoreText(
          post?.content ?? 'Không có nội dung',
          trimLines: 3,
          trimMode: TrimMode.Line,
          trimCollapsedText: 'Đọc thêm',
          trimExpandedText: '',
          moreStyle: Theme.of(context).textTheme.labelLarge?.copyWith(color: TextColor.textColor300),
        ),
      ],
    );
  }

  Widget _buildPostInteraction(BuildContext context) {
    int totalLike = 0;
    if (post?.isLiked == true) {
      totalLike = (post?.likeCount ?? 0) + 1;
    }
    else if (post?.isLiked == false) {
      totalLike = post?.likeCount ?? 0;
    }
    else {
      totalLike = 0;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          children: [
            IconButton(
              onPressed: () => onLikePost?.call(),
              icon: post?.isLiked ?? false ? const Icon(Icons.favorite_rounded, color: ErrorColor.error500) : const Icon(Icons.favorite_border_rounded)
            ),
            Text('$totalLike lượt thích', style: Theme.of(context).textTheme.bodySmall)
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
    List<dynamic> imageUrls = [];
    if (post?.linkImage != "") {
      imageUrls = List<String>.from(jsonDecode(post?.linkImage ?? '[]'));
      List<String> result = [];
      for (String image in imageUrls) {
        result.add(image);
      }
      return Skeleton.replace(
        replacement: Container(
          width: double.infinity,
          height: 200,
          color: TextColor.textColor200
        ),
        child: ImageSlider(imageUrls: result)
      );
    }
    return const SizedBox();
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

class CampaignPostCard extends StatelessWidget {
  final Campaign campaign;

  const CampaignPostCard({
    super.key,
    required this.campaign
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () => {},
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: AvatarCard(
                  showTime: true,
                  userName: 'Tạm để',
                  avatarUrl: null,
                  createdAt: '2021-09-01T00:00:00',
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: _buildPostContent(context),
            ),
            const SizedBox(height: 15),
            Visibility(
              visible: campaign.linkImage != null,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _buildImageSlide(),
              ),
            ),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: _buildPostInteraction(context),
            ),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: FilledButton(
                onPressed: () => {},
                child: const Text('Tham gia ngay', style: TextStyle(color: Colors.white)),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildPostContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(campaign.title ?? 'Không có tiêu đề', style: Theme.of(context).textTheme.titleMedium),
        ReadMoreText(
          campaign.description ?? 'Không có nội dung',
          trimLines: 3,
          trimMode: TrimMode.Line,
          trimCollapsedText: 'Đọc thêm',
          trimExpandedText: '',
          moreStyle: Theme.of(context).textTheme.labelLarge?.copyWith(color: TextColor.textColor300),
        ),
        const SizedBox(height: 5),
        Visibility(
          visible: campaign.hagTag != null,
          child: Text(campaign.hagTag ?? '', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: PrimaryColor.primary500)),
        )
      ],
    );
  }

  Widget _buildPostInteraction(BuildContext context) {
    // int totalLike = 0;
    // if (post?.isLiked == true) {
    //   totalLike = (post?.likeCount ?? 0) + 1;
    // }
    // else if (post?.isLiked == false) {
    //   totalLike = post?.likeCount ?? 0;
    // }
    // else {
    //   totalLike = 0;
    // }

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          children: [
            IconButton(
                onPressed: () => {},
                icon: const Icon(Icons.favorite_border_rounded)
            ),
            Text('0 lượt thích', style: Theme.of(context).textTheme.bodySmall)
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
    List<dynamic> imageUrls = [];
    if (campaign.linkImage != "") {
      imageUrls = List<String>.from(jsonDecode(campaign.linkImage ?? '[]'));
      List<String> result = [];
      for (String image in imageUrls) {
        result.add(image);
      }
      return Skeleton.replace(
          replacement: Container(
              width: double.infinity,
              height: 200,
              color: TextColor.textColor200
          ),
          child: ImageSlider(imageUrls: result)
      );
    }
    return const SizedBox();
  }
}
