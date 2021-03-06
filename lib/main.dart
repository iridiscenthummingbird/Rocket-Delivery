import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:rocket_delivery/src/providers/category.dart';
import 'package:rocket_delivery/src/providers/product.dart';
import 'package:rocket_delivery/src/providers/restaurant.dart';
import 'package:rocket_delivery/src/providers/search.dart';
import 'package:rocket_delivery/src/providers/user.dart';
import 'package:rocket_delivery/src/screens/home.dart';
import 'package:rocket_delivery/src/screens/login.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider.value(value: UserProvider.initialize()),
      ChangeNotifierProvider.value(value: RestaurantProvider.initialize()),
      ChangeNotifierProvider.value(value: ProductProvider.initialize()),
      ChangeNotifierProvider.value(value: CategoryProvider.initialize()),
      ChangeNotifierProvider.value(value: SearchProvider()),
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Rocket Delivery",
      theme: ThemeData(primaryColor: Colors.red),
      home: ScreensController(),
    ),
  ));
}

class ScreensController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<UserProvider>(context);
    switch (auth.status) {
      case Status.Authenticated:
        return HomeScreen();
      default:
        return LoginScreen();
    }
  }
}
