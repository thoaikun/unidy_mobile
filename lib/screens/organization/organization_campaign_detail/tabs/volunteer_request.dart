import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unidy_mobile/config/themes/color_config.dart';
import 'package:unidy_mobile/models/volunteer_join_campaign_model.dart';
import 'package:unidy_mobile/viewmodel/organization/organization_campaign_detail_viewmodel.dart';
import 'package:unidy_mobile/widgets/empty.dart';

import '../../../../widgets/list_item.dart';

class VolunteerRequest extends StatefulWidget {
  const VolunteerRequest({super.key});

  @override
  State<VolunteerRequest> createState() => _VolunteerRequestState();
}

class _VolunteerRequestState extends State<VolunteerRequest> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        Provider.of<OrganizationCampaignDetailViewModel>(context, listen: false).loadMoreUnapprovedVolunteers();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: CustomScrollView(
        controller: _scrollController,
        slivers: [
          _buildButtons(context),
          _buildVolunteerRequests()
        ],
      ),
    );
  }

  Widget _buildButtons(BuildContext context) {
    OrganizationCampaignDetailViewModel viewModel = Provider.of<OrganizationCampaignDetailViewModel>(context);

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            OutlinedButton(
                style: ButtonStyle(
                    foregroundColor: const MaterialStatePropertyAll<Color?>(TextColor.textColor900),
                    textStyle: MaterialStatePropertyAll<TextStyle?>(Theme.of(context).textTheme.labelLarge?.copyWith(color: TextColor.textColor800)),
                    side: const MaterialStatePropertyAll<BorderSide?>(BorderSide(color: TextColor.textColor200))
                ),
                onPressed: () {
                  viewModel.onRejectVolunteers()
                    .then((_) => ScaffoldMessenger.of(context).showSnackBar(_buildSnackBar('Xóa thành công')))
                    .catchError((error) => ScaffoldMessenger.of(context).showSnackBar(_buildSnackBar('Xóa thất bại')));
                },
                child: const Text('Xóa')
            ),
            const SizedBox(width: 10),
            OutlinedButton(
                onPressed: () {
                  viewModel.onApproveVolunteers()
                    .then((_) => ScaffoldMessenger.of(context).showSnackBar(_buildSnackBar('Phê duyệt thành công')))
                    .catchError((error) => ScaffoldMessenger.of(context).showSnackBar(_buildSnackBar('Phê duyệt thất bại')));
                },
                child: const Text('Phê duyệt')
            ),
            const SizedBox(width: 10),
            Checkbox(
              value: viewModel.selectedRequestVolunteers.length == viewModel.listUnapprovedVolunteers.length && viewModel.listUnapprovedVolunteers.isNotEmpty,
              onChanged: viewModel.listUnapprovedVolunteers.isEmpty ? null : viewModel.onSelectAll
            ),
            Text(
              'Chọn tất cả',
              style: TextStyle(
                  color: viewModel.listUnapprovedVolunteers.isEmpty ? TextColor.textColor200 : TextColor.textColor900
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildVolunteerRequests() {
    OrganizationCampaignDetailViewModel viewModel = Provider.of<OrganizationCampaignDetailViewModel>(context);
    List<int> selectedRequestVolunteers = viewModel.selectedRequestVolunteers;
    List<VolunteerJoinCampaign> listUnapprovedVolunteers = viewModel.listUnapprovedVolunteers;

    if (viewModel.isUnapprovedVolunteersFirstLoading) {
      return const SliverFillRemaining(
        child: Center(
          child: CircularProgressIndicator()
        )
      );
    }
    else if (listUnapprovedVolunteers.isEmpty) {
      return const SliverFillRemaining(
        child: Center(
          child: Empty(description: 'Chưa có yêu cầu tham gia nào')
        )
      );
    }

    return SliverListItem<VolunteerJoinCampaign>(
      items: listUnapprovedVolunteers,
      length: listUnapprovedVolunteers.length,
      itemBuilder: (BuildContext context, int index) {
        bool isSelected = selectedRequestVolunteers.contains(listUnapprovedVolunteers[index].userId);
        return _buildVolunteerCard(
            volunteer: listUnapprovedVolunteers[index],
            isSelected: isSelected,
            onChanged: (checked) {
              if (checked == true) {
                viewModel.addSelectedRequestVolunteer(listUnapprovedVolunteers[index].userId);
              } else {
                viewModel.removeSelectedRequestVolunteer(listUnapprovedVolunteers[index].userId);
              }
            }
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
      isFirstLoading: viewModel.isUnapprovedVolunteersFirstLoading,
      isLoading: viewModel.isUnapprovedVolunteersLoading,
      error: viewModel.unapprovedVolunteersError,
      onRetry: viewModel.loadMoreUnapprovedVolunteers,
      onLoadMore: viewModel.loadMoreUnapprovedVolunteers,
    );
  }

  Widget _buildVolunteerCard({
    required VolunteerJoinCampaign volunteer,
    required bool isSelected,
    required Function(bool? checked) onChanged
  }) {
    return Row(
      children: [
        Checkbox(
            value: isSelected,
            onChanged: onChanged
        ),
        CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(
                volunteer.linkImage ?? 'https://api.dicebear.com/7.x/initials/png?seed=${volunteer.fullName}'
            )
        ),
        const SizedBox(width: 15),
        Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    volunteer.fullName,
                    style: Theme.of(context).textTheme.titleMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis
                ),
                Text('Tuổi: ${volunteer.age}'),
                Text(
                    'Nghề nghiệp: ${volunteer.job}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis
                ),
                Text(
                    'Nơi công tác: ${volunteer.workLocation}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis
                )
              ],
            )
        )
      ],
    );
  }

  SnackBar _buildSnackBar(String message) {
    return SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 2),
    );
  }
}
