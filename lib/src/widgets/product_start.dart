import 'package:flutter/material.dart';

class ProductStarsWidget extends StatelessWidget {
  final int numberOfStars;
  const ProductStarsWidget({Key key, @required this.numberOfStars})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 16,
      width: 92,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 5,
          itemBuilder: (_, index) {
            return Icon(
              Icons.star,
              color: index <= numberOfStars - 1 ? Colors.red : Colors.grey,
              size: 16,
            );
          }),
    );
  }
}
