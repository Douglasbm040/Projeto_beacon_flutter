import 'package:flutter/material.dart';
import 'package:interface_beacon/src/modules/home/page/home_page.dart';
import 'package:interface_beacon/src/modules/auth/page/auth_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Interface Beacon',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: "/",
      routes: {
        '/': (context) => const AuthPage(),
        '/home': (context) => const HomePage()
      },
    );
  }
}
