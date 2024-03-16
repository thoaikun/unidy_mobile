import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:unidy_mobile/config/themes/color_config.dart';
import 'package:unidy_mobile/models/post_model.dart';
import 'package:unidy_mobile/models/user_model.dart';
import 'package:unidy_mobile/utils/formatter_util.dart';

class OrganizationProfileScreen extends StatefulWidget {
  const OrganizationProfileScreen({super.key});

  @override
  State<OrganizationProfileScreen> createState() => _OrganizationProfileScreenState();
}

class _OrganizationProfileScreenState extends State<OrganizationProfileScreen> {
  SliverToBoxAdapter _buildProfileHeader(User user) {
    return SliverToBoxAdapter(
        child: Column(
          children: [
            Column(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 180,
                      child: Image.network(
                          'https://ispe.org/sites/default/files/styles/hero_banner_large/public/banner-images/volunteer-page-hero-1900x600.png.webp?itok=JwOK6xl2',
                          fit: BoxFit.cover
                      ),
                    ),
                    Positioned(
                      left: 15,
                      bottom: -80,
                      child: Container(
                        width: 120,
                        height: 120,
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                            color: PrimaryColor.primary500,
                            borderRadius: BorderRadius.circular(100)
                        ),
                        child: CircleAvatar(
                          radius: 120,
                          backgroundImage: NetworkImage(
                            user.image ?? 'https://api.dicebear.com/7.x/initials/png?seed=${user.fullName}',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 30, 10, 10),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: SizedBox(
                      width: 240,
                      child: Text(
                        user.fullName ?? 'Không rõ',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleLarge,
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Divider(thickness: 5, color: PrimaryColor.primary50)
          ],
        )
    );
  }

  SliverToBoxAdapter _buildProfileInfo() {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Thông tin tổ chức',
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
                      Formatter.formatTime(DateTime.now(), 'dd/MM/yyyy - HH:mm').toString(),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w300),
                    )
                  ],
                ),
                const SizedBox(height: 5),
                // Row(
                //   children: [
                //     Text('Giới tính: ', style: Theme.of(context).textTheme.labelLarge,),
                //     Text(user.sex ?? 'Không rõ', style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w300),)
                //   ],
                // ),
                const SizedBox(height: 5),
                // Row(
                //   children: [
                //     Text('Công việc: ', style: Theme.of(context).textTheme.labelLarge,),
                //     Text(user.job ?? 'Không rõ', style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w300),)
                //   ],
                // ),
                const SizedBox(height: 5),
                // Row(
                //   children: [
                //     Text('Tại: ', style: Theme.of(context).textTheme.labelLarge,),
                //     Text(user.workLocation ?? 'Không rõ', style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w300),)
                //   ],
                // )
              ],
            ),
          ),
          const Divider(thickness: 5, color: PrimaryColor.primary50)
        ],
      ),
    );
  }

  SliverList _buildRecentPost(List<Post> postList, User user) {
    // return SliverList.separated(
    //   itemBuilder: (BuildContext context, int index) {
    //     if (index < postList.length) {
    //       return PostCard(post: postList[index], userName: user.fullName, avatarUrl: user.image);
    //     }
    //     else if (index == postList.length && context.watch<ProfileViewModel>().isLoadMoreLoading) {
    //       return Container(
    //         padding: const EdgeInsets.symmetric(vertical: 20),
    //         child: const Center(
    //           child: SizedBox(
    //             width: 30,
    //             height: 30,
    //             child: CircularProgressIndicator(),
    //           ),
    //         ),
    //       );
    //     }
    //   },
    //   separatorBuilder: (BuildContext context, int index) => const Divider(),
    //   itemCount: postList.length + 1,
    // );
    throw UnimplementedError();
  }

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: false,
      child: CustomScrollView(
        slivers: [
          // _buildProfileHeader(profileViewModel.user),
          _buildProfileInfo(),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
              child: Text('Chiến dịch gần đây', style: Theme.of(context).textTheme.titleMedium),
            ),
          ),
          // _buildRecentPost(profileViewModel.postList, profileViewModel.user)
        ],
      ),
    );
  }
}
