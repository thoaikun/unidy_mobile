import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:unidy_mobile/config/config_color_scheme.dart';
import 'package:unidy_mobile/widgets/input/input.dart';

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
      theme: ThemeData(
        colorScheme: unidyColorScheme,
        useMaterial3: true,
      ),
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
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        elevation: 0.2,
        backgroundColor: Colors.white,
        shadowColor: Theme.of(context).colorScheme.shadow,
        title: SvgPicture.asset(
          'assets/imgs/logo/logo_2.svg',
          width: 100,
          height: 30,
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(vertical: 30, horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Input(
              label: 'Email',
              placeholder: 'Nhập email của bạn',
              icon: Icon(Icons.email_rounded, size: 22,),
            ),
            SizedBox(height: 15),
            Input(
              label: 'Password',
              type: InputType.password,
              placeholder: 'Nhập mật khẩu của bạn',
              icon: Icon(Icons.lock, size: 22,),
            )
          ],
        ),
      )
    );
  }
}
