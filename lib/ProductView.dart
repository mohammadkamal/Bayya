import 'package:Bayya/ShoppingCart.dart';
import 'package:Bayya/ShoppingListItem.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductView extends StatelessWidget {
  ProductView({this.product});
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

  Widget descriptionSection() {
    return Container(
      padding: const EdgeInsets.all(32),
      child: Text(
        product.longDescription,
        softWrap: true,
      ),
    );
  }

  Widget buttonSection(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [_buttonWatchlist(), _buttonAddToCart(context)],
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

  GestureDetector _buttonAddToCart(BuildContext context, {bool inCart = true}) {
    String textShoppingCart =
        inCart ? 'Remove from shopping cart' : 'Add to shopping cart';
    Icon iconShoppingCart = inCart
        ? Icon(Icons.shopping_cart, color: Colors.lightGreen[500])
        : Icon(Icons.add_shopping_cart);

    return GestureDetector(
        onTap: () {
          product.inShopCart = true;
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ShoppingCartList(target: product)));
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
          title: Text(product.name),
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
