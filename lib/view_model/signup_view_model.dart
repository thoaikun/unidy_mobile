import 'package:flutter/material.dart';

enum EUserRole {
  volunteer,
  sponsor,
  organization
}

class SignUpViewModel extends ChangeNotifier {
  static const int MAX_STEP = 4;
  int _currentStep = 0;
  EUserRole? _selectedRole;

  int get step => _currentStep;
  EUserRole? get selectedRole => _selectedRole;

  SignUpViewModel() {
    _selectedRole = EUserRole.volunteer;
  }

  void setUserRole(EUserRole role) {
    _selectedRole = role;
    notifyListeners();
  }

  void nextStep() {
    if (_currentStep == MAX_STEP - 1) {
      return;
    }
    _currentStep += 1;
    notifyListeners();
  }
  void previousStep() {
    if (_currentStep == 0) {
      return;
    }
    _currentStep -= 1;
    notifyListeners();
  }
  bool showPreviousButton() {
    return _currentStep > 0 && _currentStep < MAX_STEP - 1;
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != DateTime.now()) {
      print(picked);
    }
  }
}