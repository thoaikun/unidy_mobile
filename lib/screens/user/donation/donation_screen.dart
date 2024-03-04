import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:unidy_mobile/config/themes/color_config.dart';
import 'package:unidy_mobile/utils/formatter_util.dart';
import 'package:unidy_mobile/widgets/input/input.dart';

class DonationScreen extends StatefulWidget {
  const DonationScreen({super.key});

  @override
  State<DonationScreen> createState() => _DonationScreenState();
}

class _DonationScreenState extends State<DonationScreen> {
  final CurrencyTextInputFormatter _currencyFormatter = CurrencyTextInputFormatter(locale: 'vi', symbol: 'đ', turnOffGrouping: false, decimalDigits: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ủng hộ chiến dịch'),
      ),
      body: Container(
        margin: const EdgeInsets.fromLTRB(20, 20, 20, 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Chọn phương thức thanh toán', style: Theme.of(context).textTheme.bodyLarge),
                const SizedBox(height: 15),
                _buildPaymentMethod(),
                const SizedBox(height: 25),
                Text('Số tiền ủng hộ', style: Theme.of(context).textTheme.bodyLarge),
                _buildInput(),
                const SizedBox(height: 35),
                _buildSuggestionDonationChip(),
              ],
            ),
            Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () {},
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
    return Center(
      child: Container(
        constraints: const BoxConstraints(
          minWidth: 50,
          maxWidth: 200,
        ),
        child: TextFormField(
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 32),
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          autofocus: true,
          inputFormatters: [_currencyFormatter],
          initialValue: _currencyFormatter.format('0'),
        )
      ),
    );
  }

  Widget _buildSuggestionDonationChip() {
    return Wrap(
      spacing: 10,
      children: [
        ChoiceChip(
          label: Text('50,000đ', style: Theme.of(context).textTheme.bodyLarge),
          selected: true,
          showCheckmark: false,
          onSelected: (bool selected) {},
        ),
        ChoiceChip(
          label: Text('100,000đ', style: Theme.of(context).textTheme.bodyLarge),
          selected: false,
          showCheckmark: false,
          onSelected: (bool selected) {},
        ),
      ],
    );
  }
}