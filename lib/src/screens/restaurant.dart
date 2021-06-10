import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rocket_delivery/src/models/restaurant.dart';
import 'package:rocket_delivery/src/providers/product.dart';
import 'package:rocket_delivery/src/services/screen_navigation.dart';
import 'package:rocket_delivery/src/widgets/loading.dart';
import 'package:rocket_delivery/src/widgets/product.dart';
import 'package:rocket_delivery/src/widgets/row_stars_rest.dart';
import 'package:transparent_image/transparent_image.dart';

import 'details.dart';

class RestaurantScreen extends StatelessWidget {
  final RestaurantModel restaurantModel;

  const RestaurantScreen({Key key, this.restaurantModel}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    productProvider.loadProductsByRestaurant(restaurantId: restaurantModel.id);

    return Scaffold(
      body: SafeArea(
          child: ListView(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Positioned.fill(
                  child: Align(
                alignment: Alignment.center,
                child: Loading(),
              )),

              // restaurant image
              ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                child: FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  image: restaurantModel.image,
                  height: 160,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),

              // fading black
              Container(
                height: 160,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black.withOpacity(0.6),
                        Colors.black.withOpacity(0.6),
                        Colors.black.withOpacity(0.6),
                        Colors.black.withOpacity(0.4),
                        Colors.black.withOpacity(0.1),
                        Colors.black.withOpacity(0.05),
                        Colors.black.withOpacity(0.025),
                      ],
                    )),
              ),

              //restaurant name
              Positioned.fill(
                  bottom: 60,
                  child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        restaurantModel.name,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 26,
                            fontWeight: FontWeight.w300),
                      ))),

              // average price
              Positioned.fill(
                  bottom: 40,
                  child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        "Average Price: \$" +
                            restaurantModel.avgPrice.toString(),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w300),
                      ))),

              // rating widget
              Positioned.fill(
                  bottom: 2,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Icon(
                                Icons.star,
                                color: Colors.yellow[900],
                                size: 20,
                              ),
                            ),
                            Text(restaurantModel.rating.toString()),
                          ],
                        ),
                      ),
                    ),
                  )),

              // close button
              Positioned.fill(
                  top: 5,
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.black.withOpacity(0.2)),
                            child: Icon(
                              Icons.close,
                              color: Colors.white,
                            )),
                      ),
                    ),
                  )),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            "Rate it",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18),
          ),
          RowOfStarsRest(restaurant: restaurantModel),
          SizedBox(
            height: 15,
          ),
          Column(
            children: productProvider.productsByRestaurant
                .map((item) => GestureDetector(
                      onTap: () {
                        changeScreen(
                            context,
                            Details(
                              product: item,
                            ));
                      },
                      child: ProductWidget(
                        product: item,
                      ),
                    ))
                .toList(),
          )
        ],
      )),
    );
  }
}
