import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rocket_delivery/src/helpers/screen_navigation.dart';
import 'package:rocket_delivery/src/providers/user.dart';
import 'package:rocket_delivery/src/widgets/category.dart';
import 'login.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          body: SafeArea(
            //TODO: Is loading
            child: ListView(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20))),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 8, left: 8, right: 8, bottom: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ListTile(
                        leading: Icon(
                          Icons.search,
                          color: Colors.red,
                        ),
                        title: TextField(
                          textInputAction: TextInputAction.search,
                          onSubmitted: (pattern) async {
                            // app.changeLoading();
                            // if (app.search == SearchBy.PRODUCTS) {
                            //   await productProvider.search(
                            //       productName: pattern);
                            //   changeScreen(context, ProductSearchScreen());
                            // } else {
                            //   await restaurantProvider.search(name: pattern);
                            //   changeScreen(context, RestaurantsSearchScreen());
                            // }
                            // app.changeLoading();
                          },
                          decoration: InputDecoration(
                            hintText: "Find food and restaurant",
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(
                      "Search by: ",
                      style: TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.w300),
                    ),
                    DropdownButton<String>(
                        value: "Products", //app.filterBy,
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.w300),
                        icon: Icon(
                          Icons.filter_list,
                          color: Colors.red,
                        ),
                        elevation: 0,
                        onChanged: (value) {
                          // if (value == "Products") {
                          //   app.changeSearchBy(newSearchBy: SearchBy.PRODUCTS);
                          // } else {
                          //   app.changeSearchBy(newSearchBy: SearchBy.RESTAURANTS);
                          // }
                        },
                        items: <String>["Products", "Restaurants"]
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList()),
                  ],
                ),
                Divider(),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 100,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () async {},
                          child: CategoryWidget(),
                        );
                      }),
                ),
              ],
            ),
          ),
          appBar: AppBar(
              actions: <Widget>[
                Stack(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.shopping_cart),
                      onPressed: () {
                        //changeScreen(context, CartScreen());
                      },
                    ),
                  ],
                ),
              ],
              elevation: 0.5,
              backgroundColor: Colors.red,
              title: Text("Rocket Delivery")),
          drawer: Drawer(
              child: ListView(
            children: <Widget>[
              UserAccountsDrawerHeader(
                  decoration: BoxDecoration(color: Colors.red),
                  accountName: Text('Name'),
                  // CustomText(
                  //   text: user.userModel?.name ?? "username lading...",
                  //   color: white,
                  //   weight: FontWeight.bold,
                  //   size: 18,
                  // ),
                  accountEmail: Text('Email')
                  // CustomText(
                  //   text: user.userModel?.email ?? "email loading...",
                  //   color: white,
                  // ),
                  ),
              ListTile(
                onTap: () {
                  changeScreen(context, HomeScreen());
                },
                leading: Icon(Icons.home),
                title: Text('Home'),
              ),
              ListTile(
                onTap: () async {
                  //await user.getOrders();
                  //changeScreen(context, OrdersScreen());
                },
                leading: Icon(Icons.bookmark_border),
                title: Text("My orders"),
              ),
              ListTile(
                onTap: () {
                  //changeScreen(context, CartScreen());
                },
                leading: Icon(Icons.shopping_cart),
                title: Text("Cart"),
              ),
              ListTile(
                onTap: () {
                  user.signOut();
                  changeScreen(context, LoginScreen());
                },
                leading: Icon(Icons.exit_to_app),
                title: Text("Log out"),
              ),
            ],
          )),
        ));
  }
}
