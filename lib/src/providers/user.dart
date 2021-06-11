import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rocket_delivery/src/models/cart_item.dart';
import 'package:rocket_delivery/src/models/order.dart';
import 'package:rocket_delivery/src/models/product.dart';
import 'package:rocket_delivery/src/models/user.dart';
import 'package:rocket_delivery/src/services/order.dart';
import 'package:rocket_delivery/src/services/user.dart';
import 'package:uuid/uuid.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class UserProvider with ChangeNotifier {
  FirebaseAuth _auth;
  Status _status = Status.Uninitialized;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User _user;
  UserServices _userService = UserServices();
  UserModel _userModel;
  OrderServices _orderServices = OrderServices();

  List<OrderModel> orders = [];

  final formkey = GlobalKey<FormState>();

  UserModel get userModel => _userModel;
  Status get status => _status;
  User get user => _user;

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController();

  UserProvider.initialize() : _auth = FirebaseAuth.instance {
    _auth.authStateChanges().listen(_onStateChanged);
  }

  Future<void> _onStateChanged(User firebaseUser) async {
    if (firebaseUser == null) {
      _status = Status.Unauthenticated;
    } else {
      _user = firebaseUser;
      _status = Status.Authenticated;
      _userModel = await _userService.getUserById(_user.uid);
    }
    notifyListeners();
  }

  Future<bool> signIn(BuildContext context) async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      await _auth.signInWithEmailAndPassword(
          email: email.text.trim(), password: password.text.trim());
      return true;
    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      //TODO: cut the message
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
      return false;
    }
  }

  Future<bool> signUp(BuildContext context) async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      await _auth
          .createUserWithEmailAndPassword(
              email: email.text.trim(), password: password.text.trim())
          .then((result) {
        _firestore.collection('users').doc(result.user.uid).set({
          'name': name.text,
          'email': email.text,
          'uid': result.user.uid,
          'cart': []
        });
      });
      return true;
    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
      return false;
    }
  }

  Future signOut() async {
    _auth.signOut();
    _status = Status.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  void clearController() {
    name.text = "";
    password.text = "";
    email.text = "";
  }

  Future<bool> addToCard({ProductModel product, int quantity}) async {
    try {
      var uuid = Uuid();
      String cartItemId = uuid.v4();

      Map cartItem = {
        "id": cartItemId,
        "name": product.name,
        "image": product.image,
        "restaurantID": product.restaurantId,
        "productID": product.id,
        "price": product.price,
        "quantity": quantity
      };

      CartItemModel item = CartItemModel.fromMap(cartItem);
      _userService.addToCart(userId: _user.uid, cartItem: item);

      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> removeFromCart({CartItemModel cartItem}) async {
    try {
      _userService.removeFromCart(userId: _user.uid, cartItem: cartItem);
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<void> reloadUserModel() async {
    _userModel = await _userService.getUserById(_user.uid);
    notifyListeners();
  }

  getOrders() async {
    orders = await _orderServices.getUserOrders(userId: _user.uid);
    notifyListeners();
  }

  Future<bool> updateProductRate(int rate, String id) async {
    try {
      List<Map> list = [];
      bool check = false;
      _userModel.rates.forEach((element) {
        if (element.id == id) {
          check = true;
        } else {
          list.add(element.toMap());
        }
      });
      list.add({"id": id, "rate": rate});

      _firestore.collection("users").doc(user.uid).update({"rates": list});

      notifyListeners();
      if (check) {
        print('false');
        return false;
      }
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
}
