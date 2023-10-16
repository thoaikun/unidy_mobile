import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:unidy_mobile/config/config_color.dart';
import 'package:unidy_mobile/widgets/input/input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final String logoImage = 'assets/imgs/logo/logo_1.svg';
  final String backgroundImage =
      'assets/imgs/illustration/login_background.svg';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.09),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    logoImage,
                    width: 70,
                  ),
                  const SizedBox(height: 35),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Đăng nhập',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'Nhập email và mật khẩu của bạn',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(color: TextColor.textColor300),
                          )
                        ],
                      ),
                      const SizedBox(height: 35),
                      const Input(
                        label: 'Email',
                        placeholder: 'Nhập email của bạn',
                        icon: Icon(Icons.email_rounded),
                        autoFocus: true,
                      ),
                      const SizedBox(height: 20),
                      const Input(
                        label: 'Mật khẩu',
                        placeholder: 'Nhập mật khẩu của bạn',
                        icon: Icon(Icons.key_rounded),
                      ),
                      const SizedBox(height: 25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Text('Chưa có tài khoản?'),
                          const SizedBox(width: 8),
                          TextButton(
                              onPressed: ()  {},
                              style: const ButtonStyle(
                                  fixedSize: MaterialStatePropertyAll<Size>(Size.fromHeight(20)),
                                  padding: MaterialStatePropertyAll<EdgeInsets>(EdgeInsets.zero)
                              ),
                              child: Text(
                                'Đăng ký ngay',
                                style: Theme.of(context).textTheme.titleSmall?.copyWith(color: PrimaryColor.primary500)
                              ),
                          )
                        ],
                      ),
                      const SizedBox(height: 35),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child:
                            FilledButton(onPressed: () {}, child: Text('Đi thôi')),
                      )
                    ],
                  )
                ],
              ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: SvgPicture.asset(backgroundImage)
          )
        ]
      )),
    );
  }
}
