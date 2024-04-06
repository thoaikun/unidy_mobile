import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unidy_mobile/bloc/organization_profile_cubit.dart';
import 'package:unidy_mobile/config/themes/color_config.dart';
import 'package:unidy_mobile/models/organization_model.dart';
import 'package:unidy_mobile/utils/formatter_util.dart';

class OrganizationProfile extends StatefulWidget {
  const OrganizationProfile({super.key});

  @override
  State<OrganizationProfile> createState() => _OrganizationProfileState();
}

class _OrganizationProfileState extends State<OrganizationProfile> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        _buildProfileHeader(),
        _buildProfileInfo(),
        _buildProfileActivity()
      ],
    );
  }

  SliverToBoxAdapter _buildProfileHeader() {
    Organization organization = context.watch<OrganizationProfileCubit>().state;

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
                        fit: BoxFit.cover,
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
                            organization.image ?? 'https://api.dicebear.com/7.x/initials/png?seed=${organization.organizationName}',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 20, 10, 10),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: SizedBox(
                      width: 240,
                      child: Text(
                        organization.organizationName,
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
    Organization organization = context.watch<OrganizationProfileCubit>().state;

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
                      'Thông tin chung',
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
                      'Email: ',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    Text(
                      organization.email,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w300),
                    )
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Text(
                      'Số điện thoại: ',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    Text(
                      organization.phone,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w300),
                    )
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Text('Trụ sở:  ', style: Theme.of(context).textTheme.labelLarge,),
                    Text(organization.address, style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w300),)
                  ],
                ),
                const SizedBox(height: 5),
                Wrap(
                  children: [
                    Text('Website: ', style: Theme.of(context).textTheme.labelLarge,),
                    Text('https://www.volunteerhq.org/', style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w300, color: PrimaryColor.primary500),)
                  ],
                ),
              ],
            ),
          ),
          const Divider(thickness: 5, color: PrimaryColor.primary50)
        ],
      ),
    );
  }

  SliverToBoxAdapter _buildProfileActivity() {
    Organization organization = context.watch<OrganizationProfileCubit>().state;

    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Tổng quan hoạt động',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            const SizedBox(height: 15),
            Wrap(
              spacing: 10,
              children: [
                Text(
                  'Số người theo dõi:',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                Text(
                  '20 triệu',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w300),
                )
              ],
            ),
            const SizedBox(height: 5),
            Wrap(
              spacing: 10,
              children: [
                Text('Số hoạt động đã tổ chức:', style: Theme.of(context).textTheme.labelLarge,),
                Text('${organization.overallFigure?.totalCampaign ?? 0}', style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w300),)
              ],
            ),
            const SizedBox(height: 5),
            Wrap(
              spacing: 10,
              children: [
                Text('Số tiền được ủng hộ:', style: Theme.of(context).textTheme.labelLarge,),
                Text(Formatter.formatCurrency(organization.overallFigure?.totalTransaction), style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w300),)
              ],
            ),
            const SizedBox(height: 5),
            Wrap(
              spacing: 10,
              children: [
                Text('Số tình nguyện viên đã tham gia:', style: Theme.of(context).textTheme.labelLarge,),
                Text('${organization.overallFigure?.totalVolunteer ?? 0}', style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w300),)
              ],
            ),
          ]
        )
      )
    );
  }
}
