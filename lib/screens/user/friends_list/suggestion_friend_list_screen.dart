import 'package:flutter/material.dart';
import 'package:unidy_mobile/widgets/card/friend_card.dart';

class SuggestionFriendListScreen extends StatefulWidget {
  const SuggestionFriendListScreen({super.key});

  @override
  State<SuggestionFriendListScreen> createState() => _SuggestionFriendListScreenState();
}

class _SuggestionFriendListScreenState extends State<SuggestionFriendListScreen> {

  SliverFillRemaining _buildList() {
    return SliverFillRemaining(
      child: ListView.separated(
          itemBuilder: (BuildContext context, int index) => const AddFriendCard(),
          separatorBuilder: (BuildContext context, int index) => const Divider(height: 0.5,),
          itemCount: 10
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Có thể bạn quan tâm'),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: CustomScrollView(
          slivers: [
            _buildList()
          ],
        ),
      ),
    );
  }
}
