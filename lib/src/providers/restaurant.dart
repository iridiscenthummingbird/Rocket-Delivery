import 'package:flutter/material.dart';
import 'package:rocket_delivery/src/services/restaurant.dart';
import '../models/restaurant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RestaurantProvider with ChangeNotifier {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  RestaurantServices _restaurantServices = RestaurantServices();
  List<RestaurantModel> restaurants = [];
  List<RestaurantModel> searchedRestaurants = [];

  RestaurantModel restaurant;

  RestaurantProvider.initialize() {
    loadRestaurants();
  }

  loadRestaurants() async {
    restaurants = await _restaurantServices.getRestaurants();
    notifyListeners();
  }

  loadSingleRestaurant({String retaurantId}) async {
    restaurant = await _restaurantServices.getRestaurantById(id: retaurantId);
    notifyListeners();
  }

  Future search({String name}) async {
    searchedRestaurants =
        await _restaurantServices.searchRestaurant(restaurantName: name);
    notifyListeners();
  }

  Future<bool> updateProductRate(int rate, String id, {int last}) async {
    try {
      RestaurantModel restaurant;

      restaurants.forEach((element) {
        if (element.id == id) {
          restaurant = element;
        }
      });

      double rating = 0;
      List<int> rates = [];
      bool delete = last != 0 ? true : false;

      restaurant.rates.forEach((element) {
        if (delete && element == last) {
          delete = false;
        } else {
          rates.add(element);
        }
      });

      rates.add(rate);

      rates.forEach((element) {
        rating += element;
      });

      rating = rating / rates.length;

      _firestore
          .collection("restaurants")
          .doc(restaurant.id)
          .update({"rating": rating.toStringAsFixed(1), "rates": rates});

      notifyListeners();
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
}
