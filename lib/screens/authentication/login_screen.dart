import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unidy_mobile/config/themes/color_config.dart';
import 'package:unidy_mobile/viewmodel/login_viewmodel.dart';
import 'package:unidy_mobile/widgets/input/input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final String logoImage = 'assets/imgs/logo/logo_1.png';
  final String backgroundImage =
      'assets/imgs/illustration/login_background.png';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoginViewModel(context: context),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Consumer<LoginViewModel>(
            builder: (BuildContext context, LoginViewModel loginViewModel, Widget? child) {
              return Stack(
                children: [
                  Positioned(
                    child: Visibility(
                      visible: loginViewModel.loadingLogin,
                      child: const LinearProgressIndicator()
                    )
                  ),
                  Container(
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(
                          logoImage,
                          width: 70,
                          height: 70,
                        ),
                        const SizedBox(height: 45),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Đăng nhập',
                                  style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 20),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  'Nhập email và mật khẩu của bạn',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(color: TextColor.textColor300),
                                )
                              ],
                            ),
                            const SizedBox(height: 20),
                            Input(
                              controller: loginViewModel.emailController,
                              label: 'Email',
                              error: loginViewModel.emailError,
                              prefixIcon: const Icon(Icons.email_rounded)
                            ),
                            const SizedBox(height: 20),
                            Input(
                              controller: loginViewModel.passwordController,
                              label: 'Mật khẩu',
                              error: loginViewModel.passwordError,
                              prefixIcon: const Icon(Icons.key_rounded),
                              suffixIcon: IconButton(
                                onPressed: loginViewModel.togglePasswordVisible,
                                icon: loginViewModel.passwordVisible ? const Icon(Icons.visibility_off_rounded) : const Icon(Icons.visibility_rounded),
                              ),
                              obscureText: !loginViewModel.passwordVisible,
                            ),
                            const SizedBox(height: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text('Chưa có tài khoản?', style: Theme.of(context).textTheme.bodySmall),
                                const SizedBox(width: 8),
                                TextButton(
                                  onPressed: ()  => Navigator.pushNamed(context, '/authentication/signup'),
                                  style: const ButtonStyle(
                                      fixedSize: MaterialStatePropertyAll<Size>(Size.fromHeight(20)),
                                      padding: MaterialStatePropertyAll<EdgeInsets>(EdgeInsets.zero)
                                  ),
                                  child: Text(
                                    'Đăng ký ngay',
                                    style: Theme.of(context).textTheme.labelMedium?.copyWith(color: PrimaryColor.primary500)
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(height: 30),
                            SizedBox(
                              width: double.infinity,
                              height: 50,
                              child:
                                FilledButton(
                                  onPressed: loginViewModel.onClickLogin,
                                  child: const Text('Đi thôi')
                              ),
                            ),
                            Center(
                                child: TextButton(
                                  onPressed: () => Navigator.pushNamed(context, '/authentication/forgot_password'),
                                  child: const Text('Quên mật khẩu')
                                )
                              )
                          ],
                        ),
                      ],
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
}
