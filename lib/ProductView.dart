import 'ShoppingCart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Product.dart';
import 'Watchlist.dart';

class ProductView extends StatefulWidget {
  ProductView({this.product});
  final Product product;

  _ProductViewState createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
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

  Widget descriptionSection() {
    return Container(
      padding: const EdgeInsets.all(32),
      child: Text(
        widget.product.longDescription,
        softWrap: true,
      ),
    );
  }

  Widget buttonSection(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [_buttonWatchlist(), _buttonAddToCart()],
      ),
    );
  }

  GestureDetector _buttonWatchlist() {
    bool isWatchlisted = Watchlist.instance.getWatchlisted(widget.product);
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

  GestureDetector _buttonAddToCart() {
    bool inCart = ShoppingCart.instance.isInShoppingCart(widget.product);
    String textShoppingCart =
        inCart ? 'Remove from shopping cart' : 'Add to shopping cart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.product.name),
        ),
        body: Column(
          children: [
            titleSection(),
            descriptionSection(),
            buttonSection(context)
          ],
        ));
  }
}
