import 'package:flutter/material.dart';
import 'package:unidy_mobile/config/color_config.dart';

class CommentCard extends StatelessWidget {
  final String user;
  final String body;
  final double intend;

  const CommentCard({super.key, required this.user, required this.body, required this.intend});

  ButtonStyle _getReplyButtonStyle() {
    return const ButtonStyle(
      padding: MaterialStatePropertyAll<EdgeInsetsGeometry?>(EdgeInsets.symmetric(vertical: 5)),
      minimumSize: MaterialStatePropertyAll<Size?>(Size(45, 20)),
      tapTargetSize: MaterialTapTargetSize.shrinkWrap
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.network(
                'https://media.istockphoto.com/id/1335941248/photo/shot-of-a-handsome-young-man-standing-against-a-grey-background.jpg?s=612x612&w=0&k=20&c=JSBpwVFm8vz23PZ44Rjn728NwmMtBa_DYL7qxrEWr38=',
                width: 30,
                height: 30,
                colorBlendMode: BlendMode.clear,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 15),
          SizedBox(
            width: MediaQuery.of(context).size.width - 85 - (intend * 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user,
                  style: Theme.of(context).textTheme.titleSmall
                ),
                const SizedBox(height: 4),
                Text(
                  body,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodySmall
                ),
                const SizedBox(height: 4),
                TextButton(
                  onPressed: () {},
                  style: _getReplyButtonStyle(),
                  child: Text(
                    'Trả lời',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(color: TextColor.textColor300),
                  )
                )
              ]
            ),
          )
        ],
      ),
    );
  }
}
