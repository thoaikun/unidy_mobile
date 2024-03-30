import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unidy_mobile/screens/user/detail_profile/volunteer_profile/volunteer_profile.dart';
import 'package:unidy_mobile/viewmodel/user/other_profile_viewmodel.dart';

class VolunteerProfileContainer extends StatefulWidget {
  final int volunteerId;
  const VolunteerProfileContainer({super.key, required this.volunteerId});

  @override
  State<VolunteerProfileContainer> createState() => _VolunteerProfileContainerState();
}

class _VolunteerProfileContainerState extends State<VolunteerProfileContainer> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => VolunteerProfileViewModel(volunteerId: widget.volunteerId),
      child: const VolunteerProfileScreen(),
    );
  }
}
