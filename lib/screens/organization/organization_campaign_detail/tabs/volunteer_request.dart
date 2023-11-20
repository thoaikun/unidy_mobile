import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_sticky_widgets/flutter_sticky_widgets.dart';
import 'package:unidy_mobile/config/themes/color_config.dart';

class VolunteerRequest extends StatefulWidget {
  const VolunteerRequest({super.key});

  @override
  State<VolunteerRequest> createState() => _VolunteerRequestState();
}

class _VolunteerRequestState extends State<VolunteerRequest> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: CustomScrollView(
        slivers: [
          _buildButtons(context),
          _buildVolunteerRequests()
        ],
      ),
    );
  }

  Widget _buildButtons(BuildContext context) {
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
                onPressed: () {},
                child: const Text('Xóa')
            ),
            const SizedBox(width: 10),
            OutlinedButton(
                onPressed: () {},
                child: const Text('Phê duyệt')
            )
          ],
        ),
      ),
    );
  }

  Widget _buildVolunteerRequests() {
    return SliverList.separated(
      itemBuilder: (BuildContext context, int index) => Card(
        shadowColor: null,
        elevation: 0,
        child: Row(
          children: [
            Checkbox(value: false, onChanged: (bool? value) {}),
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
                  const Text('Tuổi: 25'),
                  const Text(
                    'Nghề nghiệp: Sinh viên',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis
                  ),
                  const Text(
                    'Nơi công tác: Đại học bách khoa',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis
                  )
                ],
              )
            )
          ],
        ),
      ),
      separatorBuilder: (BuildContext context, int index) => const Divider(),
      itemCount: 8,
    );
  }
}
