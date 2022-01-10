import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_example/controllers/cart_controller.dart';
import 'package:getx_example/controllers/product_controller.dart';
import 'package:getx_example/screens/cart_screen.dart';
import 'package:getx_example/widgets/app_drawer.dart';
import 'package:getx_example/widgets/badge.dart';
import 'package:getx_example/widgets/productgrid.dart';

enum FilterOptions {
  favourites,
  all,
}

class ProductOverviewPage extends StatelessWidget {
  const ProductOverviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _showOnlyFavourites = false;
    final cartController = Get.put(CartController());

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Shop"),
        actions: <Widget>[
          GetBuilder<ProductController>(
              init: ProductController(),
              builder: (context) {
                return PopupMenuButton(
                    icon: const Icon(Icons.more_vert),
                    onSelected: (FilterOptions selectedValue) {
                      if (selectedValue == FilterOptions.favourites) {
                        _showOnlyFavourites = true;
                        log(_showOnlyFavourites.toString());
                      } else {
                        _showOnlyFavourites = false;
                      }
                    },
                    itemBuilder: (BuildContext context) => [
                          const PopupMenuItem(
                            child: Text("Only Favourites"),
                            value: FilterOptions.favourites,
                          ),
                          const PopupMenuItem(
                            child: Text("Show All"),
                            value: FilterOptions.all,
                          )
                        ]);
              }),
          GetBuilder<CartController>(
              init: CartController(),
              builder: (ctx) {
                return Badge(
                  child: IconButton(
                      icon: const Icon(
                        Icons.shopping_cart,
                      ),
                      onPressed: () {
                        Get.to(()=>const CartScreen());
                      }),
                  value: cartController.itemCount.toString(),
                  color: Theme.of(context).colorScheme.secondary,
                );
              })
        ],
      ),
      drawer: const AppDrawer(),
      body: ProductsGrid(_showOnlyFavourites),
    );
  }
}
