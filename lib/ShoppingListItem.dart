import 'dart:ffi';
import 'dart:ui';
import 'package:Bayya/ProductView.dart';
import 'package:Bayya/ShoppingCart.dart';
import 'package:flutter/material.dart';

class Product {
  //Constructor
  Product(
      {this.id,
      this.name,
      this.shortDescription,
      this.longDescription,
      this.vendor,
      this.price,
      this.category});

  //Fields & Variables
  final String name, shortDescription, longDescription, vendor;
  final double price;
  final int id;
  bool inShopCart;
  Float ratings;
  int quantity;
  ProductCategory category;
}

typedef void CartChangedCallback(Product product);

enum ProductCategory { clothes, elctronics, food }

class ShoppingListItem extends StatelessWidget {
  ShoppingListItem({this.product});

  final Product product;

  Widget titleSection() {
    return Container(
        padding: const EdgeInsets.all(32),
        child: Row(
          children: [
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    product.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(product.shortDescription)
              ],
            ))
          ],
        ));
  }

  GestureDetector _addToCartMinimized({bool inCart = true}) {
    Icon iconShoppingCart = inCart
        ? Icon(Icons.shopping_cart, color: Colors.lightGreen[500])
        : Icon(Icons.add_shopping_cart);
    
    return GestureDetector(
        onTap: () {
          shopCartSnack();
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            iconShoppingCart,
          ],
        ));
  }

  GestureDetector _watchlistMinimized({bool isWatchlisted = false}) {
    Icon iconWatchlist = isWatchlisted
        ? Icon(Icons.favorite, color: Colors.red)
        : Icon(Icons.favorite_border);
    return GestureDetector(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        iconWatchlist,
      ],
    ));
  }

  Widget buttonsMinimized() {
    return Container(
      alignment: Alignment.bottomRight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.min,
        children: [_watchlistMinimized(), _addToCartMinimized()],
      ),
    );
  }

  SnackBar shopCartSnack() {
    return SnackBar(
      content: Text('Added to Shopping Cart'),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {},
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ProductView(product: product)));
        },
        child: Container(
          margin: const EdgeInsets.all(4),
          decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.white),
              color: Colors.white),
          child: Column(
            children: [
              titleSection(),
              Row(
                children: [Text('Price: ' + product.price.toString() + ' EGP')],
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
              ),
              buttonsMinimized()
            ],
          ),
        ));
  }
}
