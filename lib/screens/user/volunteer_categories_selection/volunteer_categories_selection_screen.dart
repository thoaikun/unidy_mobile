import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unidy_mobile/config/themes/color_config.dart';
import 'package:unidy_mobile/models/volunteer_category_model.dart';
import 'package:unidy_mobile/screens/user/home/home_screen_container.dart';
import 'package:unidy_mobile/viewmodel/user/volunteer_categories_selection_viewmodel.dart';

class VolunteerCategoriesSelectionScreen extends StatefulWidget {
  const VolunteerCategoriesSelectionScreen({super.key});

  @override
  State<VolunteerCategoriesSelectionScreen> createState() => _VolunteerCategoriesSelectionScreenState();
}

class _VolunteerCategoriesSelectionScreenState extends State<VolunteerCategoriesSelectionScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => VolunteerCategoriesSelectionViewModel(
        handleNavigateToHomeScreen: _handleNavigateToHomeScreen,
        showAlertDialog: showAlertDialog
      ),
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              Positioned(
                child: Consumer<VolunteerCategoriesSelectionViewModel>(
                  builder: (BuildContext context, VolunteerCategoriesSelectionViewModel volunteerCategoriesSelectionViewModel, Widget? child) {
                    return Visibility(
                      visible: volunteerCategoriesSelectionViewModel.isLoading,
                      child: const LinearProgressIndicator()
                    );
                  }
                )
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 50, 20, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildCategoryList(),
                    _buildButton(),
                  ]
                ),
              )
            ],
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
              'Lựa chọn hoạt động yêu thích của bạn',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 15),
            Text(
              'Lựa chọn này sẽ giúp chúng tôi đưa ra những gợi ý tốt hơn cho bạn',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: TextColor.textColor300),
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
        return Container(
          width: double.infinity,
          margin: const EdgeInsets.only(bottom: 20),
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

  void showAlertDialog(String title, String content) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title, style: Theme.of(context).textTheme.titleMedium),
          content: Text(content, style: Theme.of(context).textTheme.bodyMedium),
          actions: <Widget>[
            TextButton(
              child: const Text('Đồng ý'),
              onPressed: () => Navigator.of(context).pop()
            ),
          ],
        );
      },
    );
  }
}
