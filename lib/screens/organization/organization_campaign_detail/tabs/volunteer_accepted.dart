import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unidy_mobile/models/volunteer_join_campaign_model.dart';
import 'package:unidy_mobile/viewmodel/organization/organization_campaign_detail_viewmodel.dart';
import 'package:unidy_mobile/widgets/empty.dart';
import 'package:unidy_mobile/widgets/list_item.dart';

class VolunteerAccepted extends StatefulWidget {
  const VolunteerAccepted({super.key});

  @override
  State<VolunteerAccepted> createState() => _VolunteerAcceptedState();
}

class _VolunteerAcceptedState extends State<VolunteerAccepted> {
  @override
  Widget build(BuildContext context) {
    OrganizationCampaignDetailViewModel viewModel = Provider.of<OrganizationCampaignDetailViewModel>(context);
    List<VolunteerJoinCampaign> listApprovedVolunteers = viewModel.listApprovedVolunteers;

    if (viewModel.isApprovedVolunteersFirstLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (listApprovedVolunteers.isEmpty) {
      return const Center(
        child: Empty(description: 'Chưa có tình nguyện viên nào được chấp nhận'
      ));
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListItem<VolunteerJoinCampaign>(
        items: listApprovedVolunteers,
        length: listApprovedVolunteers.length,
        itemBuilder: (BuildContext context, int index) => _buildVolunteerCard(listApprovedVolunteers[index]),
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        onLoadMore: viewModel.loadMoreApprovedVolunteers,
        isLoading: viewModel.isApprovedVolunteersLoading,
        isFirstLoading: viewModel.isApprovedVolunteersFirstLoading,
        error: viewModel.approvedVolunteersError,
        onRetry: viewModel.loadMoreApprovedVolunteers
      )
    );
  }

  Widget _buildVolunteerCard(VolunteerJoinCampaign volunteer) {
    return Card(
      shadowColor: null,
      elevation: 0,
      child: Row(
        children: [
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
          ),
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert_rounded))
        ],
      ),
    );
  }
}
