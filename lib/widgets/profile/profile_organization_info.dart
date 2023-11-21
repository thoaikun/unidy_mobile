import 'package:flutter/material.dart';
import 'package:unidy_mobile/config/themes/color_config.dart';
import 'package:unidy_mobile/utils/formatter_util.dart';

class ProfileOrganizationInfo extends StatelessWidget {
  const ProfileOrganizationInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
                'Thời gian thành lập: ',
                style: Theme.of(context).textTheme.labelLarge,
              ),
              Text(
                Formatter.formatTime(DateTime.now()).toString(),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w300),
              )
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              Text('Trụ sở:  ', style: Theme.of(context).textTheme.labelLarge,),
              Text('Hoa kì', style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w300),)
            ],
          ),
          const SizedBox(height: 5),
          Wrap(
            children: [
              Text('Mô tả: ', style: Theme.of(context).textTheme.labelLarge,),
              Text(
                'International Volunteer HQ Limited is a New Zealand-based volunteer travel company founded by '
                  'Daniel John Radcliffe in 2007. In September 2015, it has sent 50,000 volunteers overseas to 30 '
                  'countries on 200 different projects',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w300),
                maxLines: 10,
              )
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
    );
  }
}
