import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rocket_delivery/src/services/product.dart';
import '../models/product.dart';

class ProductProvider with ChangeNotifier {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  ProductServices _productServices = ProductServices();
  List<ProductModel> products = [];
  List<ProductModel> productsByCategory = [];
  List<ProductModel> productsByRestaurant = [];
  List<ProductModel> productsSearched = [];

  ProductProvider.initialize() {
    loadProducts();
  }

  loadProducts() async {
    products = await _productServices.getProducts();
    notifyListeners();
  }

  Future loadProductsByCategory({String categoryName}) async {
    productsByCategory =
        await _productServices.getProductsOfCategory(category: categoryName);
    notifyListeners();
  }

  Future loadProductsByRestaurant({String restaurantId}) async {
    productsByRestaurant =
        await _productServices.getProductsByRestaurant(id: restaurantId);
    notifyListeners();
  }

  Future search({String productName}) async {
    productsSearched =
        await _productServices.searchProducts(productName: productName);
    notifyListeners();
  }

  Future<bool> updateProductRate(int rate, String id, {int last}) async {
    try {
      ProductModel product;

      products.forEach((element) {
        if (element.id == id) {
          product = element;
        }
      });

      double rating = 0;
      List<int> rates = [];
      bool delete = last != 0 ? true : false;

      product.rates.forEach((element) {
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
          .collection("products")
          .doc(product.id)
          .update({"rating": rating.toStringAsFixed(2), "rates": rates});

      notifyListeners();
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
}
