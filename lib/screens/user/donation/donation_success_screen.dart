import 'package:flutter/material.dart';
import 'package:unidy_mobile/config/themes/color_config.dart';
import 'package:unidy_mobile/screens/user/home/home_screen_container.dart';

class DonationSuccessScreen extends StatelessWidget {
  const DonationSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Wrap(
              spacing: 10,
              alignment: WrapAlignment.center,
              runAlignment: WrapAlignment.center,
              children: [
                Icon(Icons.check_circle, color: Colors.green, size: 30),
                Text('Ủng hộ thành công', style: Theme.of(context).textTheme.titleMedium?.copyWith(color: SuccessColor.success500)),
              ],
            ),
            const SizedBox(height: 10),
            Text('Cảm ơn bạn đã đóng góp', style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(height: 20),
            TextButton.icon(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreenContainer())),
              label: const Text('Quay về trang chủ'),
              icon: const Icon(Icons.home_rounded),
            )
          ],
        ),
      ),
    );
  }
}
