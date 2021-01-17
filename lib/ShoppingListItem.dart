import 'dart:ffi';
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
  Float ratings;
  int quantity;
  ProductCategory category;
}

enum ProductCategory { clothes, elctronics, food }

typedef void CartChangedCallback(Product product, bool inCart);

class ShoppingListItem extends StatelessWidget {
  ShoppingListItem({this.product, this.inCart, this.onCartChanged})
      : super(key: ObjectKey(product));

  final Product product;
  final bool inCart;
  final CartChangedCallback onCartChanged;

  Color _getColor(BuildContext context) {
    return inCart ? Colors.black54 : Theme.of(context).primaryColor;
  }

  void _viewProduct(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute<void>(builder: (BuildContext context) {
      return Scaffold(
          appBar: AppBar(
            title: Text(product.name),
          ),
          body: Column(
            children: [titleSection(), descriptionSection(), buttonSection()],
          ));
    }));
  }

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
                Text(
                  product.shortDescription,
                  style: TextStyle(color: Colors.grey[500]),
                )
              ],
            ))
          ],
        ));
  }

  Widget descriptionSection() {
    return Container(
      padding: const EdgeInsets.all(32),
      child: Text(
        product.longDescription,
        softWrap: true,
      ),
    );
  }

  GestureDetector _buttonWatchlist({bool isWatchlisted = false}) {
    String textWatchlist = isWatchlisted ? 'Watchlisted' : 'Watchlist';
    Icon iconWatchlist = isWatchlisted
        ? Icon(Icons.favorite, color: Colors.red)
        : Icon(Icons.favorite_border);
    return GestureDetector(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        iconWatchlist,
        Container(
            margin: const EdgeInsets.only(top: 8),
            child: Text(
              textWatchlist,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
            ))
      ],
    ));
  }

  GestureDetector _buttonAddToCart() {
    bool isInShoppingCart = ShoppingCart.isInCart(product.id);
    String textShoppingCart =
        isInShoppingCart ? 'Remove from shopping cart' : 'Add to shopping cart';
    Icon iconShoppingCart = isInShoppingCart
        ? Icon(Icons.shopping_cart, color: Colors.lightGreen[500])
        : Icon(Icons.add_shopping_cart);
    return GestureDetector(
        onTap: () {
          ShoppingCart.onCartChange(product.id);
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            iconShoppingCart,
            Container(
              margin: const EdgeInsets.only(top: 8),
              child: Text(
                textShoppingCart,
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
              ),
            )
          ],
        ));
  }

  Widget buttonSection() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [_buttonWatchlist(), _buttonAddToCart()],
      ),
    );
  }

  GestureDetector _addToCartMinimized() {
    bool isInShoppingCart = ShoppingCart.isInCart(product.id);
    Icon iconShoppingCart = isInShoppingCart
        ? Icon(Icons.shopping_cart, color: Colors.lightGreen[500])
        : Icon(Icons.add_shopping_cart);
    return GestureDetector(
        onTap: () {
          ShoppingCart.onCartChange(product.id);
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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          _viewProduct(context);
        },
        child: Container(
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
