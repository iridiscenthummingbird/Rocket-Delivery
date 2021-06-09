import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  String _id;
  String _restaurantId;
  String _description;
  String _userId;
  String _status;
  int _createdAt;
  double _total;

  String get id => _id;
  String get restaurantId => _restaurantId;
  String get description => _description;
  String get userId => _userId;
  String get status => _status;
  double get total => _total;
  int get createdAt => _createdAt;

  List cart;

  OrderModel.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data();
    _id = data["id"];
    _description = data["description"];
    _total = data["total"];
    _status = data["status"];
    _userId = data['userID'];
    _createdAt = data["createdAt"];
    _restaurantId = data["restaurantID"];
    cart = data["cart"];
  }
}
