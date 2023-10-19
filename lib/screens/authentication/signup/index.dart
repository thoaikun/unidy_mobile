import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unidy_mobile/config/config_color.dart';
import 'package:unidy_mobile/screens/authentication/signup/complete_signup.dart';
import 'package:unidy_mobile/screens/authentication/signup/create_account.dart';
import 'package:unidy_mobile/screens/authentication/signup/information.dart';
import 'package:unidy_mobile/screens/authentication/signup/select_role.dart';
import 'package:unidy_mobile/view_model/signup_view_model.dart';
import 'package:unidy_mobile/widgets/role_card/role_card.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> with TickerProviderStateMixin {
  final List<Widget> signUpStep = [
    const SelectRoleStep(),
    const CreateAccountStep(),
    const InformationStep(),
    const CompleteSignUpStep()
  ];

  final String logoImage = 'assets/imgs/logo/logo_1.png';
  final String backgroundImage =
      'assets/imgs/illustration/login_background.png';
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider<SignUpViewModel>(
        create: (_) => SignUpViewModel(),
        child: SafeArea(
          child: Consumer<SignUpViewModel>(
            builder: (BuildContext context, SignUpViewModel signUpViewModel, Widget? child)  {
              return Stack(
                children: [
                  Positioned(
                      child: TweenAnimationBuilder(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                        tween: Tween<double>(
                          begin: (signUpViewModel.step) / SignUpViewModel.MAX_STEP,
                          end: (signUpViewModel.step + 1) / SignUpViewModel.MAX_STEP
                        ),
                        builder: (context, value, _) => LinearProgressIndicator(
                          value: value,
                        ),
                      )
                  ),
                  Container(
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.09),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ListView(
                      children: [
                        Image.asset(
                          logoImage,
                          width: 70,
                          height: 70,
                        ),
                        const SizedBox(height: 35),
                        signUpStep[signUpViewModel.step],
                        const SizedBox(height: 10),
                        Visibility(
                          visible: signUpViewModel.step < SignUpViewModel.MAX_STEP,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text('Đã có tài khoản?', style: Theme.of(context).textTheme.bodySmall),
                              const SizedBox(width: 8),
                              TextButton(
                                onPressed: ()  => Navigator.pushNamed(context, '/authentication/login'),
                                style: const ButtonStyle(
                                    fixedSize: MaterialStatePropertyAll<Size>(Size.fromHeight(20)),
                                    padding: MaterialStatePropertyAll<EdgeInsets>(EdgeInsets.zero)
                                ),
                                child: Text(
                                    'Đăng nhập ngay',
                                    style: Theme.of(context).textTheme.labelMedium?.copyWith(color: PrimaryColor.primary500)
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 35),
                        SizedBox(
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Visibility(
                                visible: signUpViewModel.showPreviousButton(),
                                child: SizedBox(
                                  height: 50,
                                  child: OutlinedButton(
                                    onPressed: signUpViewModel.previousStep,
                                    child: const Text('Quay lại')),
                                ),
                              ),
                            Visibility(
                                visible: signUpViewModel.showPreviousButton(),
                                child: const SizedBox(width: 10)
                              ),
                              Expanded(
                                flex: 1,
                                child: SizedBox(
                                  height: 50,
                                  child:
                                  FilledButton(
                                    onPressed: signUpViewModel.nextStep,
                                    child: const Text('Tiếp tục')
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 50,)
                      ],
                    ),
                  ),
                ]
              );
            }
          )
        ),
      ),
    );
  }
}

