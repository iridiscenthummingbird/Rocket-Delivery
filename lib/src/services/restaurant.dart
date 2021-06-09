import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/restaurant.dart';

class RestaurantServices {
  String collection = "restaurants";
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<RestaurantModel>> getRestaurants() async =>
      _firestore.collection('restaurants').get().then((result) {
        List<RestaurantModel> restaurants = [];
        result.docs.forEach((doc) {
          restaurants.add(RestaurantModel.fromSnapshot(doc));
        });
        return restaurants;
      });

  Future<RestaurantModel> getRestaurantById({String id}) =>
      _firestore.collection(collection).doc(id.toString()).get().then((doc) {
        return RestaurantModel.fromSnapshot(doc);
      });

  Future<List<RestaurantModel>> searchRestaurant({String restaurantName}) {
    String searchKey =
        restaurantName[0].toUpperCase() + restaurantName.substring(1);
    return _firestore
        .collection(collection)
        .orderBy("name")
        .startAt([searchKey])
        .endAt([searchKey + '\uf8ff'])
        .get()
        .then((result) {
          List<RestaurantModel> restaurants = [];
          result.docs.forEach((element) {
            restaurants.add(RestaurantModel.fromSnapshot(element));
          });
          return restaurants;
        });
  }
}
