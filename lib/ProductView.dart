import 'ShoppingCart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Product.dart';
import 'ShoppingCartList.dart';
import 'Watchlist.dart';

class ProductView extends StatefulWidget {
  ProductView({this.product});
  final Product product;

  _ProductViewState createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  Widget _imageCard() {
    return Container(color: Colors.white, child: widget.product.image);
  }

  Widget _titleText() {
    return Container(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(widget.product.name,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          softWrap: true),
    );
  }

  Widget _shortDescriptionText() {
    return Container(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        widget.product.shortDescription,
        softWrap: true,
      ),
    );
  }

  Widget _priceText() {
    return Container(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(widget.product.price.toString() + ' EGP',
          style: TextStyle(fontWeight: FontWeight.bold), softWrap: true),
    );
  }

  Widget _topInfoCard() {
    return Container(
      padding: const EdgeInsets.all(4),
      margin: const EdgeInsets.only(bottom: 2),
      color: Colors.white,
      child: Column(
        children: [
          Row(
            children: [_titleText()],
          ),
          Row(children: [
            _shortDescriptionText(),
          ]),
          Row(
            children: [_priceText()],
          )
        ],
      ),
    );
  }

  Widget _descriptionCard() {
    return Container(
      padding: const EdgeInsets.all(4),
      margin: const EdgeInsets.only(bottom: 2),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Text(
              'Description',
              style: TextStyle(fontSize: 15),
            )
          ]),
          Row(
            children: [
              Text(
                widget.product.longDescription,
                softWrap: true,
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _wideAddToCart() {
    bool isInCart = ShoppingCart.instance.isInShoppingCart(widget.product);
    return GestureDetector(
      onTap: () {
        setState(() {
          isInCart
              ? ShoppingCart.instance.removeFromShoppingCart(widget.product)
              : ShoppingCart.instance.addToShoppingCart(widget.product);
        });
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: isInCart ? Colors.red[400] : Colors.lightGreen[500],
            borderRadius: BorderRadius.circular(8)),
        width: 350,
        height: 50,
        child: Center(
            child: Text(
          isInCart ? 'Remove from cart' : 'Add to cart',
          style: TextStyle(color: Colors.white, fontSize: 20),
          softWrap: true,
        )),
      ),
    );
  }

  Widget _vendorCard() {
    return Container(
      padding: const EdgeInsets.all(4),
      margin: const EdgeInsets.only(bottom: 2),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [Text('Vendor:')],
          ),
          Row(
            children: [Text(widget.product.vendor)],
          )
        ],
      ),
    );
  }

  Widget _upperIconWatchlist() {
    return IconButton(
        icon: Watchlist.instance.getWatchlisted(widget.product)
            ? Icon(Icons.favorite, color: Colors.red)
            : Icon(Icons.favorite_border),
        onPressed: () {
          setState(() {
            Watchlist.instance.getWatchlisted(widget.product)
                ? Watchlist.instance.unWatchlist(widget.product)
                : Watchlist.instance.setWatchlisted(widget.product);
          });
        });
  }

  Widget _upperToShoppingCart() {
    return IconButton(
        icon: Icon(Icons.shopping_cart, color: Colors.white),
        onPressed: () {
          Navigator.of(context)
              .push(_createRouteToShoppingCart())
              .then((value) {
            setState(() {});
          });
        });
  }

  Route _createRouteToShoppingCart() {
    return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            ShoppingCartList(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = Offset(0.0, 1.0);
          var end = Offset.zero;
          var curve = Curves.ease;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        });
  }

  Widget _floatingAddToCart() {
    return FloatingActionButton(
        tooltip: 'Add to cart',
        child: ShoppingCart.instance.isInShoppingCart(widget.product)
            ? Icon(Icons.remove_shopping_cart)
            : Icon(Icons.add_shopping_cart),
        onPressed: () {
          setState(() {
            ShoppingCart.instance.isInShoppingCart(widget.product)
                ? ShoppingCart.instance.removeFromShoppingCart(widget.product)
                : ShoppingCart.instance.addToShoppingCart(widget.product);
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.product.name),
          actions: <Widget>[_upperIconWatchlist(), _upperToShoppingCart()],
        ),
        body: Container(
            color: Colors.grey[300],
            child: ListView(
              children: [
                _imageCard(),
                _topInfoCard(),
                _wideAddToCart(),
                _vendorCard(),
                _descriptionCard()
              ],
            )),
        floatingActionButton: _floatingAddToCart());
  }
}
