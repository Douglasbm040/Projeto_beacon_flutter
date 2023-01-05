import 'package:flutter/material.dart';
import 'package:interface_beacon/src/pages/home_page.dart';
import 'package:interface_beacon/src/pages/auth_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
