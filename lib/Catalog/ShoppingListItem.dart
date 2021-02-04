import 'dart:ui';
import 'package:Bayya/Cart/ShoppingCart.dart';
import 'package:Bayya/ItemWidgets/ShortDescriptionText.dart';
import 'package:Bayya/Product/Product.dart';
import 'package:Bayya/Product/ProductView.dart';
import 'package:Bayya/Watchlist/Watchlist.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShoppingListItem extends StatefulWidget {
  final Product product;
  ShoppingListItem({this.product});

  @override
  _ShoppingListItemState createState() => _ShoppingListItemState();
}

class _ShoppingListItemState extends State<ShoppingListItem> {
  Widget _imageSection() {
    return Container(
        child: Image(
      image: widget.product.image.image,
      width: 100,
      height: 100,
      fit: BoxFit.fill,
    ));
  }

  Widget _leftColumn() {
    return Container(
        padding: EdgeInsets.all(4),
        child: Column(
          children: [_imageSection()],
        ));
  }

  Widget _titleText() {
    return Container(
        padding: const EdgeInsets.only(bottom: 4),
        child: Text(
          widget.product.name,
          style: TextStyle(fontWeight: FontWeight.bold),
          textAlign: TextAlign.left,
          softWrap: true,
        ));
  }

  Widget _priceText() {
    return Container(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text(widget.product.price.toString() + ' EGP',
          textAlign: TextAlign.left),
    );
  }

  Widget _vendorText() {
    return Container(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text(
        widget.product.vendor,
        textAlign: TextAlign.left,
        softWrap: true,
      ),
    );
  }

  Widget _buttonToCart() {
    return GestureDetector(
        onTap: () {
          context.read<ShoppingCart>().isInShoppingCart(widget.product)
              ? context
                  .read<ShoppingCart>()
                  .removeFromShoppingCart(widget.product)
              : context.read<ShoppingCart>().addToShoppingCart(widget.product);
          Scaffold.of(context).showSnackBar(_snackBarCart());
        },
        child: Container(
          width: 120,
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(1),
              color: Colors.lightGreen[500]),
          child: Row(
            children: [
              Icon(
                  Provider.of<ShoppingCart>(context)
                          .isInShoppingCart(widget.product)
                      ? Icons.shopping_cart
                      : Icons.add_shopping_cart,
                  color: Colors.white),
              Text(
                Provider.of<ShoppingCart>(context)
                        .isInShoppingCart(widget.product)
                    ? 'In cart'
                    : 'Add to cart',
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
        ));
  }

  Widget _buttonToWatchlist() {
    Icon iconWatchlist =
        Provider.of<Watchlist>(context).getWatchlisted(widget.product)
            ? Icon(Icons.favorite, color: Colors.red)
            : Icon(Icons.favorite_border_outlined);
    return GestureDetector(
        onTap: () {
          context.read<Watchlist>().getWatchlisted(widget.product)
              ? context.read<Watchlist>().unWatchlist(widget.product)
              : context.read<Watchlist>().setWatchlisted(widget.product);
        },
        child: Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(1), color: Colors.grey[400]),
          child: Column(
            children: [iconWatchlist],
          ),
        ));
  }

  Widget _buttonSection() {
    return Container(
      padding: const EdgeInsets.all(4),
      child: Row(
        children: [
          Column(children: [_buttonToCart()]),
          Column(
            children: [_buttonToWatchlist()],
          )
        ],
      ),
    );
  }

  Widget _rightColumn() {
    return Container(
        padding: EdgeInsets.all(4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [_titleText()],
            ),
            Row(
              children: [
                ShortDescriptionText(
                    bottomPadding: 4,
                    shortDescription: widget.product.shortDescription)
              ],
            ),
            Row(children: [_priceText()]),
            Row(
              children: [_vendorText()],
            ),
            _buttonSection(),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProductView(product: widget.product)));
      },
      child: Container(
          margin: const EdgeInsets.all(2),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(width: 1, color: Colors.white)),
          child: Row(
            children: [_leftColumn(), _rightColumn()],
          )),
    );
  }

  SnackBar _snackBarCart() {
    return SnackBar(
      content: Text(widget.product.name +
          (context.read<ShoppingCart>().isInShoppingCart(widget.product)
              ? ' was added to shopping cart'
              : ' was removed from shopping cart')),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {
          context.read<ShoppingCart>().isInShoppingCart(widget.product)
              ? context
                  .read<ShoppingCart>()
                  .removeFromShoppingCart(widget.product)
              : context.read<ShoppingCart>().addToShoppingCart(widget.product);
        },
      ),
    );
  }
}
