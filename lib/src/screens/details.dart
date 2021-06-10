import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rocket_delivery/src/models/product.dart';
import 'package:rocket_delivery/src/providers/user.dart';
import 'package:rocket_delivery/src/screens/cart.dart';
import 'package:rocket_delivery/src/services/screen_navigation.dart';
import 'package:rocket_delivery/src/widgets/row_starts.dart';

class Details extends StatefulWidget {
  final ProductModel product;
  const Details({@required this.product});
  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  int quantity = 1;
  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);

    return Scaffold(
      key: _key,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              changeScreen(context, CartScreen());
            },
          ),
        ],
        leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              radius: 120,
              backgroundImage: NetworkImage(widget.product.image),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              widget.product.name,
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            Text(
              "\$" + widget.product.price.toString(),
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Description",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.product.description,
                textAlign: TextAlign.center,
                style:
                    TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                      icon: Icon(
                        Icons.remove,
                        size: 36,
                        color: quantity > 1 ? Colors.red : Colors.grey,
                      ),
                      onPressed: () {
                        if (quantity != 1) {
                          setState(() {
                            quantity -= 1;
                          });
                        }
                      }),
                ),
                GestureDetector(
                  onTap: () async {
                    bool value = await user.addToCard(
                        product: widget.product, quantity: quantity);
                    if (value) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Added to the Cart!")));
                      user.reloadUserModel();
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(28, 12, 28, 12),
                      child: Text(
                        "Add $quantity To Cart",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w300),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                      icon: Icon(
                        Icons.add,
                        size: 36,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        setState(() {
                          quantity += 1;
                        });
                      }),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "Rate it",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
            RowOfStars(product: widget.product)
          ],
        ),
      ),
    );
  }
}
