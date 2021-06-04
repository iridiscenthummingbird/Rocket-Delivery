import 'package:flutter/material.dart';
import 'package:rocket_delivery/src/screens/login.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login App',
      theme: ThemeData(
        accentColor: Colors.red,
      ),
      home: LoginScreen(),
    );
  }
}
