import 'dart:math';

import 'package:flutter/material.dart';
import 'package:unidy_mobile/config/themes/color_config.dart';

class SponsorDonation extends StatefulWidget {
  const SponsorDonation({super.key});

  @override
  State<SponsorDonation> createState() => _SponsorDonationState();
}

class _SponsorDonationState extends State<SponsorDonation> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView.separated(
        itemBuilder: (BuildContext context, int index) => Card(
          shadowColor: null,
          elevation: 0,
          child: Row(
            children: [
              CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(
                      'https://api.dicebear.com/7.x/initials/png?seed=${Random().nextInt(200)}'
                  )
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        'Thoai le ne',
                        style: Theme.of(context).textTheme.titleMedium,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis
                    ),
                    const SizedBox(height: 3),
                    const Text('Nhà tài trợ vàng'),
                    const SizedBox(height: 3),
                    Row(
                      children: [
                        const Text('Số tiền ủng hộ: '),
                        Expanded(
                          child: Text(
                            '10 triệu đồng',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: PrimaryColor.primary500),
                          ),
                        )
                      ],
                    )
                  ],
                )
              )
            ],
          ),
        ),
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        itemCount: 8,
      ),
    );
  }
}
