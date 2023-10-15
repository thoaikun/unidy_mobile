import 'package:flutter/material.dart';
import 'package:unidy_mobile/widgets/input/input.dart';
import 'package:unidy_mobile/widgets/navigation/bottom_navigation_bar.dart';
import 'package:unidy_mobile/widgets/navigation/main_appbar.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const PreferredSize(
            preferredSize: Size.fromHeight(55),
            child: UnidyMainAppBar()
        ),
        bottomNavigationBar: const UnidyBottomNavigationBar(),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Input(
                label: 'Email',
                placeholder: 'Nhập email của bạn',
                icon: Icon(Icons.email_rounded, size: 22,),
              ),
              const SizedBox(height: 15),
              const Input(
                label: 'Password',
                type: InputType.password,
                placeholder: 'Nhập mật khẩu của bạn',
                icon: Icon(Icons.lock, size: 22,),
                enableBorder: false,
              ),
              FilledButton.tonal(
                child: const Text('Login'),
                onPressed: () => print('hii'),
              ),
              TextButton(
                child: const Text('Login'),
                onPressed: () => print('hii'),
              ),
              FilledButton(
                child: const Text('Login'),
                onPressed: () => print('hii'),
              )
            ],
          ),
        )
    );
  }
}
