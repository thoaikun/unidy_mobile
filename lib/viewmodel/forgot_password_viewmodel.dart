import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:unidy_mobile/services/authentication_service.dart';

class ForgotPasswordViewModel extends ChangeNotifier {
  static const int MAX_STEP = 3;
  final AuthenticationService authenticationService = GetIt.instance<AuthenticationService>();

  final BuildContext context;
  int _currentStep = 0;
  String otpValue = '';

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmNewPasswordController = TextEditingController();

  int get currentStep => _currentStep;
  TextEditingController get emailController => _emailController;
  TextEditingController get newPasswordController => _newPasswordController;
  TextEditingController get confirmNewPasswordController => _confirmNewPasswordController;

  ForgotPasswordViewModel({ required this.context });

  void setCurrentStep(int value) {
    _currentStep = value;
    notifyListeners();
  }

  void setOtpValue(String value) {
    otpValue = value;
    print(otpValue);
  }

  Future<void> showCompleteDialog(bool isSuccess) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: isSuccess ? const Text('Thành công') : const Text('Thất bại'),
          content: isSuccess ? const Text('Thay đổi mật khẩu thành công.') : const Text('Thay đổi mật khẩu thất bại, vui lòng thử lại sau.'),
          actions: <Widget>[
            TextButton(
              child: const Text('Đồng ý'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

}