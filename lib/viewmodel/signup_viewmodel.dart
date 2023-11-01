import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';

enum EUserRole {
  volunteer,
  sponsor,
  organization
}

class SignUpViewModel extends ChangeNotifier {
  static const int MAX_STEP = 4;
  int _currentStep = 0;
  EUserRole? _selectedRole;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();

  final BehaviorSubject<String> _emailSubject = BehaviorSubject<String>();
  final BehaviorSubject<String> _passwordSubject = BehaviorSubject<String>();

  String? emailError;
  String? passwordError;

  int get step => _currentStep;
  EUserRole? get selectedRole => _selectedRole;
  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;
  TextEditingController get dobController => _dobController;

  SignUpViewModel() {
    _selectedRole = EUserRole.volunteer;
    // _emailController.addListener(() => _setEmailError(null));
    // _passwordController.addListener(() => _setPasswordError(null));

    // Stream<String> emailStream = _emailSubject.stream;
    // Stream<String> passwordStream = _passwordSubject.stream;

    // validate new account
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
      String date = DateFormat('dd/MM/yyyy').format(picked).toString();
      _dobController.text = date;
    }
  }

  void _setEmailError(String? error) {
    emailError = error;
    notifyListeners();
  }
  void _setPasswordError(String? error) {
    passwordError = error;
    notifyListeners();
  }
  void handleClickCreateAccount() {
    Sink<String> emailSink = _emailSubject.sink;
    Sink<String> passwordSink = _passwordSubject.sink;

    emailSink.add(_emailController.text);
    passwordSink.add(_passwordController.text);
  }
}