import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rocket_delivery/src/providers/user.dart';
import 'package:rocket_delivery/src/screens/home.dart';
import 'package:rocket_delivery/src/screens/login.dart';
import 'package:rocket_delivery/src/services/screen_navigation.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 250,
            ),

            //USERNAME Field
            Padding(
              padding: const EdgeInsets.all(12),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: TextFormField(
                    controller: authProvider.name,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Username",
                        icon: Icon(Icons.person)),
                  ),
                ),
              ),
            ),
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
                    controller: authProvider.email,
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
                    controller: authProvider.password,
                    obscureText: true,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Password",
                        icon: Icon(Icons.lock)),
                  ),
                ),
              ),
            ),
            //Register Button
            ElevatedButton(
                child: Text(
                  'Register',
                  style: TextStyle(fontSize: 18),
                ),
                onPressed: () async {
                  if (await authProvider.signUp(context)) {
                    authProvider.clearController();
                    changeScreen(context, HomeScreen());
                  }
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
            //LOG IN Button
            TextButton(
                onPressed: () {
                  changeScreen(context, LoginScreen());
                },
                child: Text(
                  'Log in here',
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
