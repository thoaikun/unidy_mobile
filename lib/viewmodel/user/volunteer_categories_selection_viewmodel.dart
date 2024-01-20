import 'package:flutter/material.dart';
import 'package:unidy_mobile/models/volunteer_category_model.dart';

class VolunteerCategoriesSelectionViewModel extends ChangeNotifier {
  void Function() handleNavigateToHomeScreen;

  List<VolunteerCategory> categories = [
    VolunteerCategory.education,
    VolunteerCategory.strengtheningCommunities,
    VolunteerCategory.environment,
    VolunteerCategory.emergencyPreparedness,
    VolunteerCategory.health,
    VolunteerCategory.helpingNeighbours
  ];
  List<VolunteerCategory> selectedCategories = [];

  VolunteerCategoriesSelectionViewModel({required this.handleNavigateToHomeScreen});

  void toggleCategory(bool selected, VolunteerCategory category) {
    if (!selected) {
      selectedCategories.remove(category);
    } else {
      selectedCategories.add(category);
    }
    notifyListeners();
  }

  void handleConfirm() {
    print(selectedCategories);
    handleNavigateToHomeScreen();
  }
}