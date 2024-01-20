import 'dart:math';
import 'package:flutter/material.dart';

class VolunteerAccepted extends StatefulWidget {
  const VolunteerAccepted({super.key});

  @override
  State<VolunteerAccepted> createState() => _VolunteerAcceptedState();
}

class _VolunteerAcceptedState extends State<VolunteerAccepted> {
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
              ),
              IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert_rounded))
            ],
          ),
        ),
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        itemCount: 8,
      ),
    );
  }
}
