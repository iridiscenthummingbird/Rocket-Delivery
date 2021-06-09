import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rocket_delivery/src/models/cart_item.dart';

class UserModel {
  String _name;
  String _email;

  String get name => _name;
  String get email => _email;

  List<CartItemModel> cart;
  double totalCartPrice;

  UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data();
    _name = data['name'];
    _email = data['email'];
    cart = _convertCartItems(data["cart"]) ?? [];
    totalCartPrice =
        data["cart"] == null ? 0 : getTotalPrice(cart: data["cart"]);
  }

  double getTotalPrice({List cart}) {
    double priceSum = 0;
    if (cart == null) {
      return 0;
    }
    for (Map cartItem in cart) {
      priceSum += cartItem["price"] * cartItem["quantity"];
    }
    return priceSum;
  }

  List<CartItemModel> _convertCartItems(List cart) {
    List<CartItemModel> convertedCart = [];
    for (Map cartItem in cart) {
      convertedCart.add(CartItemModel.fromMap(cartItem));
    }
    return convertedCart;
  }
}
