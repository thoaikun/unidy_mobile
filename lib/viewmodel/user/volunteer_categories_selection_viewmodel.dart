import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:unidy_mobile/config/app_preferences.dart';
import 'package:unidy_mobile/models/local_data_model.dart';
import 'package:unidy_mobile/models/volunteer_category_model.dart';
import 'package:unidy_mobile/services/user_service.dart';

class VolunteerCategoriesSelectionViewModel extends ChangeNotifier {
  final UserService _userService = GetIt.instance<UserService>();
  final AppPreferences appPreferences = GetIt.instance<AppPreferences>();

  void Function() handleNavigateToHomeScreen;
  void Function(String title, String content) showAlertDialog;

  List<VolunteerCategory> selectedCategories = [];
  bool isLoading = false;

  VolunteerCategoriesSelectionViewModel({
    required this.handleNavigateToHomeScreen,
    required this.showAlertDialog
  });

  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  void toggleCategory(bool selected, VolunteerCategory category) {
    if (!selected) {
      selectedCategories.remove(category);
    } else {
      selectedCategories.add(category);
    }
    notifyListeners();
  }

  Future<void> handleConfirm() async {
    try {
      setLoading(true);
      Map<String, double> categoryWeights = initCategoryWeights();
      await _userService.initFavoriteCategoryList(categoryWeights);
      await updateLocalData();
      handleNavigateToHomeScreen();
    }
    catch (error) {
      print(error);
      showAlertDialog('Không thành công', 'Đã có lỗi xảy ra, vui lòng thử lại sau');
    }
    finally {
      setLoading(false);
    }
  }

  Map<String, double> initCategoryWeights() {
    Map<String, double> result = {};

    for (VolunteerCategory category in VolunteerCategory.categories) {
      double value;
      if (selectedCategories.contains(category)) {
        value = Random().nextDouble() * (1 - 0.1) + 0.1;
      }
      else {
        value = 0;
      }

      switch(category.key) {
        case VolunteerCategoryKey.education:
          result['education_type'] = value;
          break;
        case VolunteerCategoryKey.emergencyPreparedness:
          result['emergency_preparedness'] = value;
          break;
        case VolunteerCategoryKey.environment:
          result['environment'] = value;
          break;
        case VolunteerCategoryKey.health:
          result['healthy'] = value;
          break;
        case VolunteerCategoryKey.helpingNeighbours:
          result['help_other'] = value;
          break;
        case VolunteerCategoryKey.strengtheningCommunities:
          result['community_type'] = value;
          break;
        case VolunteerCategoryKey.researchWritingEditing:
          result['research_writing_editing'] = value;
          break;
      }
    }
    return result;
  }

  Future<void> updateLocalData() async {
    String? data = appPreferences.getString('localData');
    if (data != null) {
      LocalData localData = LocalData.fromJson(jsonDecode(data));
      localData.isChosenFavorite = true;
      await appPreferences.setString('localData', jsonEncode(localData.toJson()));
    }
  }
}