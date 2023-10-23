import 'package:flutter/material.dart';
import 'package:unidy_mobile/config/color_config.dart';

class CommentCard extends StatelessWidget {
  const CommentCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      child: Row(
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
          const SizedBox(width: 10),
          SizedBox(
            width: MediaQuery.of(context).size.width - 85,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Trương Huy Thái',
                  style: Theme.of(context).textTheme.titleMedium
                ),
                const SizedBox(height: 4),
                Text(
                  'Mình nên làm gì để thể hiện cái comment này đây ta olololo',
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium
                ),
              ]
            ),
          )
        ],
      ),
    );
  }
}
