import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rocket_delivery/src/models/order.dart';
import 'package:rocket_delivery/src/providers/user.dart';

class OrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text("Orders"),
        leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      backgroundColor: Colors.white,
      body: ListView.builder(
          itemCount: user.orders.length,
          itemBuilder: (_, index) {
            OrderModel _order = user.orders[index];
            return ListTile(
              leading: Text(
                "\$${_order.total}",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              title: Text(_order.description),
              subtitle: Text(DateFormat('HH:mm dd/MM/yyyy').format(
                  DateTime.fromMillisecondsSinceEpoch(_order.createdAt))),
              trailing:
                  Text(_order.status, style: TextStyle(color: Colors.green)),
            );
          }),
    );
  }
}
