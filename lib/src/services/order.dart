import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rocket_delivery/src/models/cart_item.dart';
import 'package:rocket_delivery/src/models/order.dart';

class OrderServices {
  String collection = "orders";
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void createOrder(
      {String userId,
      String id,
      String description,
      String status,
      List<CartItemModel> cart,
      double totalPrice}) {
    List<Map> convertedCart = [];
    List<String> restaurantIds = [];

    for (CartItemModel item in cart) {
      convertedCart.add(item.toMap());
      restaurantIds.add(item.restaurantId);
    }

    _firestore.collection(collection).doc(id).set({
      "userID": userId,
      "id": id,
      "restaurantIDs": restaurantIds,
      "cart": convertedCart,
      "total": totalPrice,
      "createdAt": DateTime.now().millisecondsSinceEpoch,
      "description": description,
      "status": status
    });
  }

  Future<List<OrderModel>> getUserOrders({String userId}) async => _firestore
          .collection(collection)
          .where("userID", isEqualTo: userId)
          .get()
          .then((result) {
        List<OrderModel> orders = [];
        result.docs.forEach((doc) {
          orders.add(OrderModel.fromSnapshot(doc));
        });
        return orders;
      });
}