import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rocket_delivery/src/providers/category.dart';
import 'package:rocket_delivery/src/providers/product.dart';
import 'package:rocket_delivery/src/providers/restaurant.dart';
import 'package:rocket_delivery/src/providers/search.dart';
import 'package:rocket_delivery/src/providers/user.dart';
import 'package:rocket_delivery/src/screens/cart.dart';
import 'package:rocket_delivery/src/screens/category.dart';
import 'package:rocket_delivery/src/screens/orders.dart';
import 'package:rocket_delivery/src/screens/product_search.dart';
import 'package:rocket_delivery/src/screens/restaurant.dart';
import 'package:rocket_delivery/src/screens/restaurant_search.dart';
import 'package:rocket_delivery/src/services/screen_navigation.dart';
import 'package:rocket_delivery/src/widgets/category.dart';
import 'package:rocket_delivery/src/widgets/featured_products.dart';
import 'package:rocket_delivery/src/widgets/restaurant.dart';
import 'login.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    final searcher = Provider.of<SearchProvider>(context);
    final restaurantProvider = Provider.of<RestaurantProvider>(context);
    final categoryProvider = Provider.of<CategoryProvider>(context);
    final productProvider = Provider.of<ProductProvider>(context);
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          body: SafeArea(
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
                            if (searcher.search == SearchBy.Products) {
                              await productProvider.search(
                                  productName: pattern);
                              changeScreen(context, ProductSearchScreen());
                            } else {
                              await restaurantProvider.search(name: pattern);
                              changeScreen(context, RestaurantsSearchScreen());
                            }
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
                        value: searcher.filterBy,
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.w300),
                        icon: Icon(
                          Icons.filter_list,
                          color: Colors.red,
                        ),
                        elevation: 0,
                        onChanged: (value) {
                          if (value == "Products") {
                            searcher.changeSearchBy(
                                newSearchBy: SearchBy.Products);
                          } else {
                            searcher.changeSearchBy(
                                newSearchBy: SearchBy.Restaurants);
                          }
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
                      itemCount: categoryProvider.categories.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () async {
                            changeScreen(
                                context,
                                CategoryScreen(
                                  categoryModel:
                                      categoryProvider.categories[index],
                                ));
                          },
                          child: CategoryWidget(
                            category: categoryProvider.categories[index],
                          ),
                        );
                      }),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Featured",
                          style: TextStyle(fontSize: 20, color: Colors.grey))
                    ],
                  ),
                ),
                Featured(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Restaurants",
                          style: TextStyle(fontSize: 20, color: Colors.grey))
                    ],
                  ),
                ),
                Column(
                  children: restaurantProvider.restaurants
                      .map((item) => GestureDetector(
                            onTap: () async {
                              changeScreen(
                                  context,
                                  RestaurantScreen(
                                    restaurantModel: item,
                                  ));
                            },
                            child: RestaurantWidget(
                              restaurant: item,
                            ),
                          ))
                      .toList(),
                )
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
                        changeScreen(context, CartScreen());
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
                  accountName: Text(
                    user.userModel?.name ?? "Username is loading...",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  accountEmail:
                      Text(user.userModel?.email ?? "email loading...",
                          style: TextStyle(
                            color: Colors.white,
                          ))),
              ListTile(
                onTap: () {
                  changeScreen(context, HomeScreen());
                },
                leading: Icon(Icons.home),
                title: Text('Home'),
              ),
              ListTile(
                onTap: () async {
                  await user.getOrders();
                  changeScreen(context, OrdersScreen());
                },
                leading: Icon(Icons.bookmark_border),
                title: Text("My orders"),
              ),
              ListTile(
                onTap: () {
                  changeScreen(context, CartScreen());
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
