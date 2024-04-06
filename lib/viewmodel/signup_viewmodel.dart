import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';
import 'package:unidy_mobile/models/authenticate_model.dart';
import 'package:unidy_mobile/services/authentication_service.dart';
import 'package:unidy_mobile/utils/exception_util.dart';
import 'package:unidy_mobile/utils/stream_transformer.dart';

class SignUpViewModel extends ChangeNotifier {
  final AuthenticationService authenticationService = GetIt.instance<AuthenticationService>();
  final void Function(String title, String name)? showErrorDialog;

  static const int MAX_STEP = 4;
  final Duration debounceTime = const Duration(milliseconds: 500);

  int _currentStep = 0;
  ERole? _selectedRole;
  bool passwordVisible = false;
  bool loadingSignUp = false;
  String _email = '';
  String _password = '';

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _sexController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _jobController = TextEditingController();
  final TextEditingController _workplaceController = TextEditingController();

  final BehaviorSubject<String> _emailSubject = BehaviorSubject<String>();
  final BehaviorSubject<String> _passwordSubject = BehaviorSubject<String>();
  final BehaviorSubject<String> _dobSubject = BehaviorSubject<String>();
  final BehaviorSubject<String> _sexSubject = BehaviorSubject<String>();
  final BehaviorSubject<String> _phoneSubject = BehaviorSubject<String>();
  final BehaviorSubject<String> _nameSubject = BehaviorSubject<String>();
  final BehaviorSubject<String> _jobSubject = BehaviorSubject<String>();
  final BehaviorSubject<String> _workplaceSubject = BehaviorSubject<String>();

  String? emailError;
  String? passwordError;
  String? dobError;
  String? sexError;
  String? phoneError;
  String? nameError;
  String? jobError;
  String? workplaceError;

  int get step => _currentStep;
  ERole? get selectedRole => _selectedRole;
  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;
  TextEditingController get dobController => _dobController;
  TextEditingController get nameController => _nameController;
  TextEditingController get sexController => _sexController;
  TextEditingController get phoneController => _phoneController;
  TextEditingController get jobController => _jobController;
  TextEditingController get workPlaceController => _workplaceController;

  SignUpViewModel({ this.showErrorDialog }) {
    _selectedRole = ERole.volunteer;
    _emailController.addListener(() => _setEmailError(null));
    _passwordController.addListener(() => _setPasswordError(null));
    _dobController.addListener(() => _setDobError(null));
    _sexController.addListener(() => _setSexError(null));
    _phoneController.addListener(() => _setPhoneError(null));
    _nameController.addListener(() => _setNameError(null));
    _jobController.addListener(() => _setJobError(null));
    _workplaceController.addListener(() => _setWorkplaceError(null));

    _sexController.text = 'Nam';
    verifyNewAccount();
    verifyUserInfo();
    verifyOrganizationInfo();
  }

  void setUserRole(ERole role) {
    _selectedRole = role;
    notifyListeners();
  }

  void setUseSex(String? value) {
    if (value != null) {
      _sexController.text = value;
    }
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

  void _setLoading(bool value) {
    loadingSignUp = value;
    notifyListeners();
  }

  void _setEmailError(String? error) {
    emailError = error;
    notifyListeners();
  }

  void _setPasswordError(String? error) {
    passwordError = error;
    notifyListeners();
  }

  void _setDobError(String? error) {
    dobError = error;
    notifyListeners();
  }

  void _setSexError(String? error) {
    sexError = error;
    notifyListeners();
  }

  void _setPhoneError(String? error) {
    phoneError = error;
    notifyListeners();
  }

  void _setNameError(String? error) {
    nameError = error;
    notifyListeners();
  }

  void _setJobError(String? error) {
    jobError = error;
    notifyListeners();
  }

  void _setWorkplaceError(String? error) {
    workplaceError = error;
    notifyListeners();
  }

  void verifyNewAccount() {
    Stream<String> emailStream = _emailSubject.stream;
    Stream<String> passwordStream = _passwordSubject.stream;

    CombineLatestStream.combine2(
      emailStream.transform(EmailValidationTransformer()),
      passwordStream.transform(PasswordValidationTransformer()),
      (email, password) => {
        'email': email,
        'password': password
      }
    )
      .debounceTime(debounceTime)
      .listen((payload) {
        _email = payload['email'] ?? '';
        _password = payload['password'] ?? '';
        nextStep();
      })
      .onError(handleSignUpError);
  }

  void verifyUserInfo() {
    Stream<String> dobStream = _dobSubject.stream;
    Stream<String> sexStream = _sexSubject.stream;
    Stream<String> phoneStream = _phoneSubject.stream;
    Stream<String> nameStream = _nameSubject.stream;
    Stream<String> jobStream = _jobSubject.stream;
    Stream<String> workplaceStream = _workplaceSubject.stream;

    CombineLatestStream.combine6(
      nameStream.transform(ValidationTransformer(validationType: 'name')),
      dobStream.transform(ValidationTransformer(validationType: 'dob')),
      phoneStream.transform(PhoneValidationTransformer()),
      sexStream.transform(ValidationTransformer()),
      jobStream.transform(ValidationTransformer(validationType: 'job')),
      workplaceStream.transform(ValidationTransformer(validationType: 'workplace')),
      (name, dob, phone, sex, job, workplace) {
        DateTime dateTime = DateFormat('dd/MM/yyyy').parse(dob);

        return <String, String>{
          "fullName" : name,
          "dayOfBirth" : DateFormat('yyyy-MM-dd').format(dateTime).toString(),
          "phone" : phone,
          "email": _email,
          "job": job,
          "workLocation": workplace,
          "password": _password,
          "role": _selectedRole == ERole.volunteer
            ? 'VOLUNTEER' :
            _selectedRole == ERole.sponsor
            ? 'SPONSOR' :
            'ORGANIZATION'
        };
      }
    )
      .debounceTime(debounceTime)
      .listen((payload) {
        if (_selectedRole != ERole.volunteer) {
          return;
        }

        _setLoading(true);
        authenticationService.signUp(payload)
          .then((_) {
            nextStep();
          })
          .catchError((error) {
          handleSignUpError(error);
          })
          .whenComplete(() => _setLoading(false));
      })
      .onError(handleSignUpError);
  }

  void verifyOrganizationInfo() {
    Stream<String> nameStream = _nameSubject.stream;
    Stream<String> dobStream = _dobSubject.stream;
    Stream<String> phoneStream = _phoneSubject.stream;
    Stream<String> workplaceStream = _workplaceSubject.stream;

    CombineLatestStream.combine4(
      nameStream.transform(ValidationTransformer(validationType: 'name')),
      dobStream.transform(ValidationTransformer(validationType: 'dob')),
      phoneStream.transform(PhoneValidationTransformer()),
      workplaceStream.transform(ValidationTransformer(validationType: 'workplace')),
      (name, dob, phone, workplace) {
        DateTime dateTime = DateFormat('dd/MM/yyyy').parse(dob);

        return <String, String>{
          "fullName" : name,
          "dayOfBirth" : DateFormat('yyyy-MM-dd').format(dateTime).toString(),
          "phone" : phone,
          "email": _email,
          "address": workplace,
          "password": _password,
          "role": 'ORGANIZATION'
        };
      }
    )
      .debounceTime(debounceTime)
      .listen((payload) {
        if (_selectedRole != ERole.organization) {
          return;
        }

        _setLoading(true);
        authenticationService.signUp(payload)
          .then((_) {
            nextStep();
          })
          .catchError((error) {
            handleSignUpError(error);
          })
          .whenComplete(() => _setLoading(false));
      })
      .onError(handleSignUpError);
  }

  void pickNextStepFunction() {
    switch (_currentStep) {
      case 0:
        nextStep();
        return;
      case 1:
        handleCreateAccount();
        return;
      case 2:
        handleUpdateInfo();
        return;
    }
  }

  void handleCreateAccount() {
    Sink<String> emailSink = _emailSubject.sink;
    Sink<String> passwordSink = _passwordSubject.sink;

    emailSink.add(_emailController.text);
    passwordSink.add(_passwordController.text);
  }

  void handleUpdateInfo() {
    Sink<String> dobSink = _dobSubject.sink;
    Sink<String> sexSink = _sexSubject.sink;
    Sink<String> phoneSink = _phoneSubject.sink;
    Sink<String> nameSink = _nameSubject.sink;
    Sink<String> jobSink = _jobSubject.sink;
    Sink<String> workplaceSink = _workplaceSubject.sink;

    switch (_selectedRole) {
      case ERole.volunteer:
      case ERole.sponsor:
        dobSink.add(_dobController.text); // Replace with your dob controller
        sexSink.add(_sexController.text); // Replace with your sex controller
        phoneSink.add(_phoneController.text); // Replace with your phone controller
        nameSink.add(_nameController.text); // Replace with your name controller
        jobSink.add(_jobController.text); // Replace with your job controller
        workplaceSink.add(_workplaceController.text); // Replace with your workplace controller
        return;
      case ERole.organization:
        dobSink.add(_dobController.text); // Replace with your dob controller
        phoneSink.add(_phoneController.text); // Replace with your phone controller
        nameSink.add(_nameController.text); // Replace with your name controller
        workplaceSink.add(_workplaceController.text); // Replace with your workplace controller
        return;
      default:
        return;
    }
  }

  void handleSignUpError(Object error) {
    if (error is ValidationException) {
      switch (error.errorCode) {
        case ExceptionErrorCode.invalidEmail:
          _setEmailError(error.message);
          break;
        case ExceptionErrorCode.invalidPassword:
          _setPasswordError(error.message);
          break;
        case ExceptionErrorCode.invalidPhone:
          _setPhoneError(error.message);
          break;
        case ExceptionErrorCode.invalidName:
          _setNameError(error.message);
          break;
        case ExceptionErrorCode.invalidJob:
          _setJobError(error.message);
          break;
        case ExceptionErrorCode.invalidWorkplace:
          _setWorkplaceError(error.message);
          break;
        case ExceptionErrorCode.invalidDob:
          _setDobError(error.message);
          break;
        default:
          break;
      }
    }
    else if (error is ResponseException) {
      if (error.message == 'Invalid Email') {
        showErrorDialog?.call('Email đã được sử dụng', 'Vui lòng kiểm tra lại email của bạn');
      }
    }
  }

  void togglePasswordVisible() {
    passwordVisible = !passwordVisible;
    notifyListeners();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _dobController.dispose();
    _nameController.dispose();
    _sexController.dispose();
    _phoneController.dispose();
    _jobController.dispose();
    _workplaceController.dispose();
    super.dispose();
  }
}