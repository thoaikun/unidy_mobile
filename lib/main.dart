import 'package:flutter/material.dart';
import 'package:unidy_mobile/config/config_theme.dart';
import 'package:unidy_mobile/widgets/input/input.dart';
import 'package:unidy_mobile/widgets/navigation/main_top_app_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: unidyThemeData,
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.

    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances f widgets.
    return Scaffold(
      appBar: MainTopAppBar().render(context),
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
