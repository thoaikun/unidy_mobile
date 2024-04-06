import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unidy_mobile/config/themes/color_config.dart';
import 'package:unidy_mobile/models/donation_history_model.dart';
import 'package:unidy_mobile/utils/formatter_util.dart';
import 'package:unidy_mobile/viewmodel/organization/organization_campaign_detail_viewmodel.dart';
import 'package:unidy_mobile/widgets/empty.dart';
import 'package:unidy_mobile/widgets/list_item.dart';

class SponsorDonation extends StatefulWidget {
  const SponsorDonation({super.key});

  @override
  State<SponsorDonation> createState() => _SponsorDonationState();
}

class _SponsorDonationState extends State<SponsorDonation> {

  @override
  Widget build(BuildContext context) {
    OrganizationCampaignDetailViewModel viewModel = Provider.of<OrganizationCampaignDetailViewModel>(context);
    List<DonationHistory> listDonationHistories = viewModel.listDonationHistories;

    if (viewModel.isDonationHistoriesFirstLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    else if (listDonationHistories.isEmpty) {
      return const Center(child: Empty(description: 'Chưa có người ủng hộ nào'));
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListItem<DonationHistory>(
        items: listDonationHistories,
        length: listDonationHistories.length,
        itemBuilder: (BuildContext context, int index) => _buildDonatorCard(listDonationHistories[index]),
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        onLoadMore: viewModel.loadMoreDonationHistories,
        onRetry: viewModel.loadMoreDonationHistories,
        isLoading: viewModel.isDonationHistoriesLoading,
        isFirstLoading: viewModel.isDonationHistoriesFirstLoading,
        error: viewModel.donationHistoriesError,
      )
    );
  }

  Widget _buildDonatorCard(DonationHistory history) {
    return Row(
      children: [
        CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(
                history.user.linkImage ?? 'https://api.dicebear.com/7.x/initials/png?seed=${history.user.fullName}'
            )
        ),
        const SizedBox(width: 15),
        Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    history.user.fullName,
                    style: Theme.of(context).textTheme.titleMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis
                ),
                const SizedBox(height: 3),
                Row(
                  children: [
                    const Text('Số tiền ủng hộ: '),
                    Expanded(
                      child: Text(
                        Formatter.formatCurrency(history.transactionAmount),
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: PrimaryColor.primary500),
                      ),
                    )
                  ],
                )
              ],
            )
        )
      ],
    );
  }
}
