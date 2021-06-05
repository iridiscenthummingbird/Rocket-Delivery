import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String _name;
  String _email;

  String get name => _name;
  String get email => _email;

  UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data();
    _name = data['name'];
    _email = data['email'];
  }
}
