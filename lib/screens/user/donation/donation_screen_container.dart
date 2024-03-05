import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unidy_mobile/screens/user/donation/donation_screen.dart';
import 'package:unidy_mobile/viewmodel/user/donation_viewmodel.dart';

class DonationScreenContainer extends StatefulWidget {
  const DonationScreenContainer({super.key});

  @override
  State<DonationScreenContainer> createState() => _DonationScreenContainerState();
}

class _DonationScreenContainerState extends State<DonationScreenContainer> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DonationViewModel(),
      child: const DonationScreen(),
    );
  }
}
