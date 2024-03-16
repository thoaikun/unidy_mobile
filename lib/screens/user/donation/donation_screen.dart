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
                Row(
                  children: [
                    Text('Mục tiêu: ', style: Theme.of(context).textTheme.bodyLarge),
                    Text(Formatter.formatCurrency(widget.campaignPost.campaign.donationBudget), style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: PrimaryColor.primary500)),
                  ]
                ),
                const SizedBox(height: 15),
                Text('Chọn phương thức thanh toán', style: Theme.of(context).textTheme.bodyLarge),
                const SizedBox(height: 15),
                _buildPaymentMethod(),
                const SizedBox(height: 25),
                Text('Số tiền ủng hộ', style: Theme.of(context).textTheme.bodyLarge),
                _buildInput(),
                const SizedBox(height: 35),
              ],
            ),
            Spacer(),
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

  Widget _buildPaymentMethod() {
    return Container(
      height: 55,
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
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
          )
        ],
      ),
    );
  }

  Widget _buildInput() {
    DonationViewModel donationViewModel = Provider.of<DonationViewModel>(context, listen: true);

    return Center(
      child: Container(
        constraints: const BoxConstraints(
          minWidth: 50,
          maxWidth: 200,
        ),
        child: TextFormField(
          controller: donationViewModel.amountOfMoneyController,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 32),
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          autofocus: true,
          inputFormatters: [donationViewModel.currencyFormatter],
        )
      ),
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
}