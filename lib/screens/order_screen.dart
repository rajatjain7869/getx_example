import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_example/controllers/order_controller.dart';
import 'package:getx_example/widgets/app_drawer.dart';
import 'package:getx_example/widgets/order_item.dart';

class OrderScreen extends StatelessWidget {
  var orderController = Get.put(OrderController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Yours Orders"),
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
          itemCount: orderController.orders.length,
          itemBuilder: (context, index) =>
              OrderItem(orderController.orders[index])),
    );
  }
}
