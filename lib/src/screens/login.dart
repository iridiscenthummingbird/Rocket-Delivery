import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rocket_delivery/src/helpers/screen_navigation.dart';
import 'package:rocket_delivery/src/screens/register.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _email, _password;
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 300,
            ),
            //TODO: Image

            //EMAIL Field
            Padding(
              padding: const EdgeInsets.all(12),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Email",
                        icon: Icon(Icons.email)),
                  ),
                ),
              ),
            ),
            //PASSWORD Field
            Padding(
              padding: const EdgeInsets.all(12),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Password",
                        icon: Icon(Icons.lock)),
                  ),
                ),
              ),
            ),
            //SIGN-IN Button
            ElevatedButton(
                child: Text(
                  'Sign in',
                  style: TextStyle(fontSize: 18),
                ),
                onPressed: () {
                  auth
                      .signInWithEmailAndPassword(
                          email: _email, password: _password)
                      .then((value) => print('success'))
                      .onError((error, stackTrace) => print('error'));
                },
                style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        EdgeInsets.only(
                            left: 30, right: 30, top: 12, bottom: 12)),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.red),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0))))),
            //REGISTER Button
            TextButton(
                onPressed: () {
                  changeScreen(context, RegisterScreen());
                },
                child: Text(
                  'Register here',
                  style: TextStyle(color: Colors.grey),
                ),
                style: ButtonStyle(
                    overlayColor:
                        MaterialStateProperty.all<Color>(Colors.red[50]),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40.0)))))
          ],
        ),
      ),
    );
  }
}
