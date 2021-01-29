import 'package:Bayya/Cart/ShoppingCart.dart';
import 'package:Bayya/Cart/ShoppingCartUpperIcon.dart';
import 'package:Bayya/Product/Product.dart';
import 'package:Bayya/Watchlist/Watchlist.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    return GestureDetector(
      onTap: () {
        _onAddToCartTap();
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: Provider.of<ShoppingCart>(context)
                    .isInShoppingCart(widget.product)
                ? Colors.red[400]
                : Colors.lightGreen[500],
            borderRadius: BorderRadius.circular(8)),
        width: 350,
        height: 50,
        child: Center(
            child: Text(
          Provider.of<ShoppingCart>(context).isInShoppingCart(widget.product)
              ? 'Remove from cart'
              : 'Add to cart',
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
        icon: Provider.of<Watchlist>(context).getWatchlisted(widget.product)
            ? Icon(Icons.favorite, color: Colors.red)
            : Icon(Icons.favorite_border),
        onPressed: () {
          context.read<Watchlist>().getWatchlisted(widget.product)
              ? context.read<Watchlist>().unWatchlist(widget.product)
              : context.read<Watchlist>().setWatchlisted(widget.product);
        });
  }

  Widget _floatingAddToCart() {
    return FloatingActionButton(
        tooltip: 'Add to cart',
        child:
            Provider.of<ShoppingCart>(context).isInShoppingCart(widget.product)
                ? Icon(Icons.remove_shopping_cart)
                : Icon(Icons.add_shopping_cart),
        onPressed: () {
          _onAddToCartTap();
        });
  }

  void _onAddToCartTap() {
    context.read<ShoppingCart>().isInShoppingCart(widget.product)
        ? context.read<ShoppingCart>().removeFromShoppingCart(widget.product)
        : context.read<ShoppingCart>().addToShoppingCart(widget.product);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.product.name),
          actions: <Widget>[_upperIconWatchlist(), ShoppingCartUpperIcon()],
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
