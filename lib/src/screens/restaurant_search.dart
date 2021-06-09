import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rocket_delivery/src/providers/product.dart';
import 'package:rocket_delivery/src/providers/restaurant.dart';
import 'package:rocket_delivery/src/screens/restaurant.dart';
import 'package:rocket_delivery/src/services/screen_navigation.dart';
import 'package:rocket_delivery/src/widgets/restaurant.dart';

class RestaurantsSearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final restaurantProvider = Provider.of<RestaurantProvider>(context);
    final productProvider = Provider.of<ProductProvider>(context);

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text(
          "Restaurants",
          style: TextStyle(fontSize: 20),
        ),
        elevation: 0.0,
        centerTitle: true,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.shopping_cart), onPressed: () {})
        ],
      ),
      body: restaurantProvider.searchedRestaurants.length < 1
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.search,
                      color: Colors.grey,
                      size: 30,
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "No restaurants were found",
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w300,
                          fontSize: 22),
                    )
                  ],
                )
              ],
            )
          : ListView.builder(
              itemCount: restaurantProvider.searchedRestaurants.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                    onTap: () async {
                      await productProvider.loadProductsByRestaurant(
                          restaurantId:
                              restaurantProvider.searchedRestaurants[index].id);
                      changeScreen(
                          context,
                          RestaurantScreen(
                            restaurantModel:
                                restaurantProvider.searchedRestaurants[index],
                          ));
                    },
                    child: RestaurantWidget(
                        restaurant:
                            restaurantProvider.searchedRestaurants[index]));
              }),
    );
  }
}
