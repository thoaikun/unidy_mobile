import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unidy_mobile/config/themes/color_config.dart';
import 'package:unidy_mobile/models/campaign_post_model.dart';
import 'package:unidy_mobile/utils/formatter_util.dart';
import 'package:unidy_mobile/viewmodel/user/donation_viewmodel.dart';

class DonationScreen extends StatefulWidget {
  final CampaignPost campaignPost;
  const DonationScreen({super.key, required this.campaignPost});

  @override
  State<DonationScreen> createState() => _DonationScreenState();
}

class _DonationScreenState extends State<DonationScreen> {
  @override
  Widget build(BuildContext context) {
    DonationViewModel donationViewModel = Provider.of<DonationViewModel>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ủng hộ chiến dịch'),
      ),
      body: Container(
        margin: const EdgeInsets.fromLTRB(20, 20, 20, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.campaignPost.campaign.title ?? 'Chiến dịch chưa có tên', style: Theme.of(context).textTheme.bodyLarge),
                const SizedBox(height: 15),
                _buildDonationProgress(widget.campaignPost.campaign.donationBudgetReceived, widget.campaignPost.campaign.donationBudget),
                const SizedBox(height: 25),
                Text('Số tiền ủng hộ', style: Theme.of(context).textTheme.bodyLarge),
                _buildInput(),
                const SizedBox(height: 35),
              ],
            ),
            const Spacer(),
            Column(
              children: [
                _buildSuggestionDonationChip(),
                const SizedBox(height: 15),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () => {
                      donationViewModel.onDonate(int.parse(widget.campaignPost.campaign.campaignId), widget.campaignPost.organizationNode.userId)
                    },
                    child: const Text('Ủng hộ'),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildInput() {
    DonationViewModel donationViewModel = Provider.of<DonationViewModel>(context, listen: true);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            border: Border.all(color: const Color.fromRGBO(165, 0, 100, 1), width: 2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Image.asset(
            'assets/imgs/icon/momo.png',
            width: 30,
            height: 30,
            fit: BoxFit.contain,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: TextFormField(
            controller: donationViewModel.amountOfMoneyController,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 32),
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            autofocus: true,
            inputFormatters: [donationViewModel.currencyFormatter]
          ),
        ),
      ]
    );
  }

  Widget _buildSuggestionDonationChip() {
    DonationViewModel donationViewModel = Provider.of<DonationViewModel>(context, listen: true);
    List<String> suggestionDonations = donationViewModel.suggestionDonations;

    return Container(
      height: 50,
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width - 40,
      ),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: suggestionDonations.length,
        itemBuilder: (BuildContext context, int index) {
          return ChoiceChip(
            label: Text(suggestionDonations[index], style: Theme.of(context).textTheme.bodyLarge),
            selected: donationViewModel.selectedSuggestion == suggestionDonations[index],
            onSelected: (bool selected) {
              if (selected) {
                donationViewModel.onSelectedSuggestion(suggestionDonations[index]);
              }
            },
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(width: 10);
        },
      ),
    );
  }

  Widget _buildDonationProgress(int? current, int? target) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Tiến độ ủng hộ'),
          const SizedBox(height: 10),
          LinearProgressIndicator(
            value: current != null && target != null ? current / target : 0.0,
            backgroundColor: TextColor.textColor100,
            valueColor: const AlwaysStoppedAnimation<Color>(PrimaryColor.primary500),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(Formatter.formatCurrency(current), style: Theme.of(context).textTheme.titleMedium?.copyWith(color: PrimaryColor.primary500)),
              Text('Mục tiêu: ${Formatter.formatCurrency(target)}', style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
        ],
      ),
    );
  }
}