import 'package:flutter/material.dart';
import 'package:unidy_mobile/config/color_config.dart';

class AvatarCard extends StatelessWidget {
  final bool showTime;
  final String? description;

  const AvatarCard({super.key, this.showTime = false, this.description});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Image.network(
            'https://media.istockphoto.com/id/1335941248/photo/shot-of-a-handsome-young-man-standing-against-a-grey-background.jpg?s=612x612&w=0&k=20&c=JSBpwVFm8vz23PZ44Rjn728NwmMtBa_DYL7qxrEWr38=',
            width: 35,
            height: 35,
            colorBlendMode: BlendMode.clear,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 15),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Tên người dùng',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(width: 10),
                Visibility(
                  visible: showTime,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 4,
                        height: 4,
                        decoration: BoxDecoration(
                          color: TextColor.textColor300,
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        '10m',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w300),
                      )
                    ],
                  ),
                )
              ],
            ),
            Visibility(
              visible: description != null,
              child: Text(
                'Đã chia sẽ một kỷ niệm mới',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: TextColor.textColor300)
              ),
            )
          ],
        ),
      ],
    );
  }
}