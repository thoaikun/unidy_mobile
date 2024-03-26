import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:unidy_mobile/config/themes/color_config.dart';
import 'package:unidy_mobile/models/campaign_post_model.dart';
import 'package:unidy_mobile/models/post_model.dart';
import 'package:unidy_mobile/screens/user/confirm_participant_campaign/confirm_participant_campaign_container.dart';
import 'package:unidy_mobile/screens/user/detail_profile/volunteer_profile/volunteer_profile_container.dart';
import 'package:unidy_mobile/screens/user/donation/donation_screen_container.dart';
import 'package:unidy_mobile/utils/formatter_util.dart';
import 'package:unidy_mobile/viewmodel/comment_viewmodel.dart';
import 'package:unidy_mobile/widgets/avatar/avatar_card.dart';
import 'package:unidy_mobile/widgets/comment/comment_tree.dart';
import 'package:unidy_mobile/widgets/image/image_slider.dart';
import 'package:unidy_mobile/widgets/input/input.dart';

import '../../screens/user/detail_profile/organization_profile/organization_profile_container.dart';

class PostCard extends StatelessWidget {
  final Post? post;
  final void Function()? onLikePost;

  const PostCard({
    super.key,
    this.post,
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
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => VolunteerProfileContainer(volunteerId: post?.userNodes?.userId ?? 0))),
                userName: post?.userNodes?.fullName,
                avatarUrl: post?.userNodes?.profileImageLink,
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
            AvatarCard(
              showTime: true,
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => VolunteerProfileContainer(volunteerId: post?.userNodes?.userId ?? 0))),
              userName: post?.userNodes?.fullName,
              avatarUrl: post?.userNodes?.profileImageLink,
              createdAt: post?.createDate,
              description: 'Đang cảm thấy ${post?.status.toLowerCase()}'
            ),
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
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => VolunteerProfileContainer(volunteerId: post?.userNodes?.userId ?? 0))),
                  userName: post?.userNodes?.fullName,
                  avatarUrl: post?.userNodes?.profileImageLink,
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
                  builder: (BuildContext context) => CommentTree(id: post?.postId ?? '', commentType: ECommentType.postComment)
              );
            },
            icon: const Icon(Icons.chat_bubble_outline_rounded)
        ),
        IconButton(onPressed: () {}, icon: const Icon(Icons.share_rounded))
      ],
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
    List<String> imgs = List<String>.from(jsonDecode(post?.linkImage ?? '[]'));
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
              fit: BoxFit.cover
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
  final CampaignPost campaignPost;

  const CampaignPostCard({
    super.key,
    required this.campaignPost
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
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => OrganizationProfileContainer(organizationId: campaignPost.organizationNode.userId))),
                  userName: campaignPost.organizationNode.fullName,
                  avatarUrl: campaignPost.organizationNode.profileImageLink,
                  createdAt: campaignPost.campaign.createDate,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: _buildPostContent(context),
            ),
            Visibility(
              visible: campaignPost.campaign.linkImage != null && campaignPost.campaign.linkImage != "[]",
              child: Column(
                children: [
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: _buildImageSlide(),
                  ),
                ],
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
              child: Row(
                children: [
                  Visibility(
                    visible: campaignPost.campaign.status == CampaignStatus.inProgress && campaignPost.campaign.numOfRegister != null,
                    child: Expanded(
                      child: FilledButton(
                        onPressed: campaignPost.isJoined != true ? () => Navigator.push(context, MaterialPageRoute(builder: (context) => ConfirmParticipantCampaignContainer(campaignPost: campaignPost))) : null,
                        child: Text(campaignPost.isJoined == true ? 'Đã tham gia' : 'Tham gia ngay', style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Visibility(
                    visible: campaignPost.campaign.status == CampaignStatus.inProgress && campaignPost.campaign.donationBudget != null,
                    child: Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => DonationScreenContainer(campaignPost: campaignPost))),
                        child: const Text('Ủng hộ', style: TextStyle(color: PrimaryColor.primary500)),
                      ),
                    ),
                  )
                ],
              ),
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
            AvatarCard(
              showTime: true,
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => OrganizationProfileContainer(organizationId: campaignPost.organizationNode.userId))),
              userName: campaignPost.organizationNode.fullName,
              avatarUrl: campaignPost.organizationNode.profileImageLink,
              createdAt: campaignPost.campaign.createDate,
            ),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(campaignPost.campaign.title ?? 'Không có tiêu đề', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 5),
        ReadMoreText(
          campaignPost.campaign.description,
          trimLines: 3,
          trimMode: TrimMode.Line,
          trimCollapsedText: 'Đọc thêm',
          trimExpandedText: '',
          moreStyle: Theme.of(context).textTheme.labelLarge?.copyWith(color: TextColor.textColor300),
        ),
        const SizedBox(height: 10),
        Text('Thông tin chi tiết:', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 5),
        Wrap(
          spacing: 5,
          children: [
            Text('Ngày mở chiến dịch: ', style: Theme.of(context).textTheme.bodyMedium),
            Text(campaignPost.campaign.startDate, style: Theme.of(context).textTheme.bodyMedium)
          ],
        ),
        const SizedBox(height: 5),
        Wrap(
          spacing: 5,
          children: [
            Text('Ngày kết thúc chiến dịch: ', style: Theme.of(context).textTheme.bodyMedium),
            Text(campaignPost.campaign.endDate ?? '', style: Theme.of(context).textTheme.bodyMedium)
          ],
        ),
        const SizedBox(height: 5),
        Wrap(
          spacing: 5,
          children: [
            Text('Địa điểm: ', style: Theme.of(context).textTheme.bodyMedium),
            Text(campaignPost.campaign.location, style: Theme.of(context).textTheme.bodyMedium)
          ],
        ),
        const SizedBox(height: 10),
        Text('Yêu cầu:', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 5),
        Visibility(
          visible: campaignPost.campaign.numOfRegister != null,
          child: Wrap(
            spacing: 5,
            children: [
              Text('Số lượng tình nguyện viên: ', style: Theme.of(context).textTheme.bodyMedium),
              Text('${campaignPost.campaign.numOfRegister.toString()} người', style: Theme.of(context).textTheme.titleSmall?.copyWith(color: ErrorColor.error500))
            ],
          ),
        ),
        const SizedBox(height: 5),
        Visibility(
          visible: campaignPost.campaign.donationBudget != null,
          child: Wrap(
            spacing: 5,
            children: [
              Text('Ngân sách yêu cầu: ', style: Theme.of(context).textTheme.bodyMedium),
              Text(Formatter.formatCurrency(campaignPost.campaign.donationBudget), style: Theme.of(context).textTheme.titleSmall?.copyWith(color: ErrorColor.error500))
            ],
          ),
        ),
        const SizedBox(height: 10),
        Visibility(
          visible: campaignPost.campaign.hashTag != null,
          child: Text(campaignPost.campaign.hashTag ?? '', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: PrimaryColor.primary500)),
        )
      ],
    );
  }

  Widget _buildPostInteraction(BuildContext context) {
    int totalLike = 0;
    if (campaignPost.isLiked == true) {
      totalLike = (campaignPost.likeCount ?? 0) + 1;
    }
    else if (campaignPost.isLiked == false) {
      totalLike = campaignPost.likeCount ?? 0;
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
                onPressed: () => {},
                icon: const Icon(Icons.favorite_border_rounded)
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
                  builder: (BuildContext context) => CommentTree(id: campaignPost.campaign.campaignId, commentType: ECommentType.campaignComment)
              );
            },
            icon: const Icon(Icons.chat_bubble_outline_rounded)
        ),
        IconButton(onPressed: () {}, icon: const Icon(Icons.share_rounded))
      ],
    );
  }

  Widget _buildImageSlide() {
    List<dynamic> imageUrls = [];
    if (campaignPost.campaign.linkImage != "") {
      imageUrls = List<String>.from(jsonDecode(campaignPost.campaign.linkImage ?? '[]'));
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
    List<String> imgs = List<String>.from(jsonDecode(campaignPost.campaign.linkImage ?? '[]'));
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
                fit: BoxFit.cover
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
