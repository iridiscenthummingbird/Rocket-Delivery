import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rocket_delivery/src/models/product.dart';

class ProductServices {
  String collection = "products";
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<ProductModel>> getProducts() async =>
      _firestore.collection(collection).get().then((result) {
        List<ProductModel> products = [];
        result.docs.forEach((doc) {
          products.add(ProductModel.fromSnapshot(doc));
        });
        return products;
      });

  // Future<List<ProductModel>> getProductsByRestaurant({String id}) async =>
  //     _firestore
  //         .collection(collection)
  //         .where("restaurantId", isEqualTo: id)
  //         .getDocuments()
  //         .then((result) {
  //       List<ProductModel> products = [];
  //       for (DocumentSnapshot product in result.documents) {
  //         products.add(ProductModel.fromSnapshot(product));
  //       }
  //       return products;
  //     });

  // Future<List<ProductModel>> getProductsOfCategory({String category}) async =>
  //     _firestore
  //         .collection(collection)
  //         .where("category", isEqualTo: category)
  //         .getDocuments()
  //         .then((result) {
  //       List<ProductModel> products = [];
  //       for (DocumentSnapshot product in result.documents) {
  //         products.add(ProductModel.fromSnapshot(product));
  //       }
  //       return products;
  //     });

  // Future<List<ProductModel>> searchProducts({String productName}) {
  //   // code to convert the first character to uppercase
  //   String searchKey = productName[0].toUpperCase() + productName.substring(1);
  //   return _firestore
  //       .collection(collection)
  //       .orderBy("name")
  //       .startAt([searchKey])
  //       .endAt([searchKey + '\uf8ff'])
  //       .getDocuments()
  //       .then((result) {
  //         List<ProductModel> products = [];
  //         for (DocumentSnapshot product in result.documents) {
  //           products.add(ProductModel.fromSnapshot(product));
  //         }
  //         return products;
  //       });
  // }
}