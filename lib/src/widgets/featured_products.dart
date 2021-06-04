import 'package:flutter/material.dart';
import 'package:rocket_delivery/src/widgets/loading.dart';
import 'package:transparent_image/transparent_image.dart';

class Featured extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 5, //productProvider.products.length,
          itemBuilder: (_, index) {
            return Padding(
                padding: EdgeInsets.fromLTRB(12, 14, 16, 12),
                child: GestureDetector(
                  onTap: () {
                    // changeScreen(
                    //     _,
                    //     Details(
                    //       product: productProvider.products[index],
                    //     ));
                  },
                  child: Container(
                    height: 220,
                    width: 200,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey[300],
                              offset: Offset(-2, -1),
                              blurRadius: 5),
                        ]),
                    child: Column(
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20)),
                          child: Stack(
                            children: <Widget>[
                              Positioned.fill(
                                  child: Align(
                                alignment: Alignment.center,
                                child: Loading(),
                              )),
                              Center(
                                child: FadeInImage.memoryNetwork(
                                  placeholder: kTransparentImage,
                                  image:
                                      "https://www.mycuisine.com/wp-content/uploads/2018/12/burger-rossini.jpg", //productProvider.products[index].image,
                                  height: 126,
                                ),
                              )
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Burger"),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    "4.5",
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 14.0),
                                  ),
                                ),
                                SizedBox(
                                  width: 2,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.red,
                                  size: 16,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.red,
                                  size: 16,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.red,
                                  size: 16,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.red,
                                  size: 16,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.grey,
                                  size: 16,
                                ),
                              ],
                            ),
                            Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Text(
                                  "\$12.5",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                ));
          }),
    );
  }
}