import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unidy_mobile/screens/authentication/forgot_password/step/confirm_email.dart';
import 'package:unidy_mobile/screens/authentication/forgot_password/step/confirm_otp.dart';
import 'package:unidy_mobile/screens/authentication/forgot_password/step/enter_new_password.dart';
import 'package:unidy_mobile/screens/authentication/login_screen.dart';
import 'package:unidy_mobile/viewmodel/forgot_password_viewmodel.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final String logoImage = 'assets/imgs/logo/logo_1.png';
  final String backgroundImage =
      'assets/imgs/illustration/login_background.png';
  final List<Widget> forgotPasswordSteps = [
    const ConfirmEmail(),
    const ConfirmOtp(),
    const EnterNewPassword()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ChangeNotifierProvider(
        create: (_) => ForgotPasswordViewModel(
          showForgotPasswordDialog: _showForgotPasswordDialog,
        ),
        child: SafeArea(
          child: Consumer<ForgotPasswordViewModel>(
            builder: (BuildContext context, ForgotPasswordViewModel forgotPasswordViewModel, Widget? child) {
              return Stack(
                children: [
                  (forgotPasswordViewModel.loading) ? const LinearProgressIndicator() : Positioned(
                    child: TweenAnimationBuilder(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                      tween: Tween<double>(
                        begin: (forgotPasswordViewModel.currentStep) / ForgotPasswordViewModel.MAX_STEP,
                        end: (forgotPasswordViewModel.currentStep + 1) / ForgotPasswordViewModel.MAX_STEP
                      ),
                      builder: (context, value, _) => LinearProgressIndicator(
                       value: value,
                      ),
                    )
                  ),
                  Container(
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 700),
                      switchInCurve: Curves.easeIn,
                      switchOutCurve: Curves.easeOut,
                      child: forgotPasswordSteps[forgotPasswordViewModel.currentStep],
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Image.asset(backgroundImage, scale: 2,)
                  )
                ]
              );
            }
          )
        ),
      ),
    );
  }

  void _showForgotPasswordDialog(String title, String content) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              child: const Text('Đồng ý'),
              onPressed: () {
                if (title == 'Thất bại') {
                  Navigator.of(context).pop();
                }
                else {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginScreen()));
                }
              },
            ),
          ],
        );
      },
    );
  }
}
