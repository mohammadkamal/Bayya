import 'dart:ui';
import 'package:Bayya/ProductView.dart';
import 'package:Bayya/Watchlist.dart';
import 'package:flutter/material.dart';
import 'Product.dart';
import 'Watchlist.dart';
import 'ShoppingCart.dart';

typedef void CartChangedCallback(Product product);

class ShoppingListItem extends StatefulWidget {
  final Product product;
  ShoppingListItem({this.product});

  _ShoppingListItemState createState() => _ShoppingListItemState();
}

class _ShoppingListItemState extends State<ShoppingListItem> {
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
                    widget.product.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(widget.product.shortDescription)
              ],
            ))
          ],
        ));
  }

  GestureDetector _addToCartMinimized() {
    bool inCart = ShoppingCart.instance.isInShoppingCart(widget.product);
    Icon iconShoppingCart = inCart
        ? Icon(Icons.shopping_cart, color: Colors.lightGreen[500])
        : Icon(Icons.add_shopping_cart);

    return GestureDetector(
        onTap: () {
          setState(() {
            if (!inCart) {
              ShoppingCart.instance.addToShoppingCart(widget.product);
            } else {
              ShoppingCart.instance.removeFromShoppingCart(widget.product);
            }
          });
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            iconShoppingCart,
          ],
        ));
  }

  GestureDetector _watchlistMinimized() {
    bool isWatchlisted = Watchlist.instance.getWatchlisted(widget.product);
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
      ),
      onTap: () {
        setState(() {
          if (!isWatchlisted) {
            Watchlist.instance.setWatchlisted(widget.product);
          } else {
            Watchlist.instance.unWatchlist(widget.product);
          }
        });
      },
    );
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
                      builder: (context) =>
                          ProductView(product: widget.product)))
              .then((value) => setState(() {}));
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
                children: [
                  Text('Price: ' + widget.product.price.toString() + ' EGP')
                ],
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
              ),
              buttonsMinimized()
            ],
          ),
        ));
  }
}
