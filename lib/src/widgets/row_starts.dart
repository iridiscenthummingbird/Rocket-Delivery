import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rocket_delivery/src/models/product.dart';
import 'package:rocket_delivery/src/providers/user.dart';

class RowOfStars extends StatelessWidget {
  final ProductModel product;
  const RowOfStars({Key key, @required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);

    int search(String id) {
      int val = 0;
      user.userModel.rates.forEach((element) {
        if (element.id == id) {
          val = element.rate;
        }
      });
      return val;
    }

    return SizedBox(
      height: 24,
      child: Padding(
        padding: const EdgeInsets.only(left: 70, right: 70),
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            itemBuilder: (_, index) {
              return IconButton(
                  icon: Icon(
                    index <= search(product.id) - 1
                        ? Icons.star
                        : Icons.star_border,
                    color: Colors.yellow[900],
                    size: 24,
                  ),
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onPressed: () {
                    print(search(product.id));
                  });
            }),
      ),
    );
  }
}
