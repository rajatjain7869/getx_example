import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_example/controllers/cart_controller.dart';
import 'package:getx_example/controllers/product_controller.dart';
import 'package:getx_example/models/product.dart';
import 'package:getx_example/screens/product_details_screen.dart';

class ProductsGrid extends StatelessWidget {
  final bool showFavourites;

  ProductsGrid(
    this.showFavourites, {Key? key}
  ) : super(key: key);
  final controller = Get.put(ProductController());

  final cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {


    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: showFavourites
          ? controller.favouriteItems.length
          : controller.items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10),
      itemBuilder: (context, index) {
        Product product = showFavourites
            ? controller.favouriteItems.elementAt(index)
            : controller.items.elementAt(index);
        return GetBuilder(
          init: ProductController(),
          builder: (value) => ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: GridTile(
              child: GestureDetector(
                onTap: () {
                  Get.to(
                    ProductDetailsScreen(
                      product.title,
                      product.price,
                          product.imageUrl,
                          product.description,
                        ),
                      );
                    },
                    child: Image.network(
                      product.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                  footer: GridTileBar(
                    backgroundColor: Colors.black87,
                    leading: IconButton(
                      icon: Icon(
                        product.isFavourite == true
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      onPressed: () {
                        controller.toggleFavouriteStatus(index);
                      },
                    ),
                    title: Text(
                      product.title,
                      textAlign: TextAlign.center,
                    ),
                    trailing: GetBuilder<CartController>(
                        init: CartController(),
                        builder: (cont) {
                          return IconButton(
                            icon: const Icon(Icons.shopping_cart),
                            onPressed: () {
                              cartController.addItem(
                                  product.id,
                                  product.price,
                                  product.title,
                                  1);
                            },
                            color: Theme.of(context).colorScheme.secondary,
                          );
                        }),
                  ),
                ),
              ),
        );
      },
    );
  }
}
