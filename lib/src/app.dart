import 'package:flutter/material.dart';
import 'package:rocket_delivery/src/screens/login.dart';
import 'package:rocket_delivery/src/screens/register.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login App',
      theme: ThemeData(accentColor: Colors.orange, primaryColor: Colors.red),
      home: LoginScreen(),
    );
  }
}
