import 'package:flutter/material.dart';

import 'Product.dart';
import 'ProductView.dart';
import 'ShoppingCart.dart';

class WatchlistItem extends StatefulWidget {
  WatchlistItem({this.product});
  final Product product;

  @override
  _WatchlistItemState createState() => _WatchlistItemState();
}

class _WatchlistItemState extends State<WatchlistItem> {
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

  Widget _descText() {
    return Container(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text(
        widget.product.shortDescription,
        textAlign: TextAlign.left,
        softWrap: true,
      ),
    );
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

  Widget _addToCart()
  {
    bool inCart = ShoppingCart.instance.isInShoppingCart(widget.product);
    Icon iconShoppingCart = inCart
        ? Icon(Icons.shopping_cart, color: Colors.white)
        : Icon(Icons.add_shopping_cart, color: Colors.white);
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
        child: Container(
          width: 120,
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(1),
              color: Colors.lightGreen[500]),
          child: Row(
            children: [
              iconShoppingCart,
              Text(
                inCart ? 'In cart' : 'Add to cart',
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
        ));
  }

  Widget _buttonSection() {
    return Container(
      padding: const EdgeInsets.all(4),
      child: Row(
        children: [
          Column(children: [_addToCart()]),
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
              children: [_descText()],
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
                      builder: (context) =>
                          ProductView(product: widget.product)))
              .then((value) => setState(() {}));
        },
        child: Container(
          margin: const EdgeInsets.all(2),
          decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.white),
              color: Colors.white),
          child: Row(
            children: [_leftColumn(), _rightColumn()],
          ),
        ));
  }
}
