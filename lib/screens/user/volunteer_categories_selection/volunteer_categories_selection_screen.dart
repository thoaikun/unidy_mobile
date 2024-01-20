import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unidy_mobile/models/volunteer_category_model.dart';
import 'package:unidy_mobile/screens/user/home/home_screen_container.dart';
import 'package:unidy_mobile/viewmodel/user/volunteer_categories_selection_viewmodel.dart';

class VolunteerCategoriesSelection extends StatefulWidget {
  const VolunteerCategoriesSelection({super.key});

  @override
  State<VolunteerCategoriesSelection> createState() => _VolunteerCategoriesSelectionState();
}

class _VolunteerCategoriesSelectionState extends State<VolunteerCategoriesSelection> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => VolunteerCategoriesSelectionViewModel(
        handleNavigateToHomeScreen: _handleNavigateToHomeScreen
      ),
      child: Scaffold(
        body: SafeArea(
          minimum: const EdgeInsets.fromLTRB(15, 70, 15, 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCategoryList(),
              _buildButton(),
            ]
          ),
        )
      ),
    );
  }

  Widget _buildCategoryList() {
    return Consumer<VolunteerCategoriesSelectionViewModel>(
      builder: (BuildContext context, VolunteerCategoriesSelectionViewModel volunteerCategoriesSelectionViewModel, Widget? child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select categories you are interested in',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 18),
            ),
            const SizedBox(height: 15),
            Wrap(
              direction: Axis.horizontal,
              spacing: 8.0,
              runSpacing: 8.0,
              children: volunteerCategoriesSelectionViewModel.categories.map((category) {
                  return FilterChip(
                    label: Text(fromVolunteerCategoryToString(category)),
                    onSelected: (bool selected) {
                      volunteerCategoriesSelectionViewModel.toggleCategory(selected, category);
                    },
                    selected: volunteerCategoriesSelectionViewModel.selectedCategories.contains(category),
                  );
              }).toList()
            )
          ]
        );
      }
    );
  }

  Widget _buildButton() {
    return Consumer<VolunteerCategoriesSelectionViewModel>(
      builder: (BuildContext context, VolunteerCategoriesSelectionViewModel volunteerCategoriesSelectionViewModel, Widget? child) {
        return SizedBox(
          width: double.infinity,
          child: FilledButton(
            onPressed: volunteerCategoriesSelectionViewModel.handleConfirm,
            child: const Text('Tiếp tục'),
          ),
        );
      }
    );
  }

  void _handleNavigateToHomeScreen() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const PopScope(canPop: false, child: HomeScreenContainer())));
  }
}
