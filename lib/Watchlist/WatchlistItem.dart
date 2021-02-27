import 'package:Bayya/Cart/ShoppingCart.dart';
import 'package:Bayya/Catalog/Catalog.dart';
import 'package:Bayya/Product/ProductView.dart';
import 'package:Bayya/Watchlist/Watchlist.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WatchlistItem extends StatefulWidget {
  WatchlistItem({this.productId});
  final String productId;

  @override
  _WatchlistItemState createState() => _WatchlistItemState();
}

class _WatchlistItemState extends State<WatchlistItem> {
  String _imgURL = "";
  Future<void> _getImageURL() async {
    var result = await FirebaseStorage.instance
        .ref()
        .child(Provider.of<Catalog>(context)
            .productsCatalog[widget.productId]
            .imageURL)
        .getDownloadURL();

    if (_imgURL == null || _imgURL.isEmpty) {
      setState(() {
        _imgURL = result;
      });
    }
  }

  Widget _imageSection() {
    _getImageURL();
    return Container(
      width: 100,
      height: 100,
      child: CachedNetworkImage(
        placeholder: (context, url) => CircularProgressIndicator(),
        imageUrl: _imgURL,
      ),
    );
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
          Provider.of<Catalog>(context).productsCatalog[widget.productId].name,
          style: TextStyle(fontWeight: FontWeight.bold),
          textAlign: TextAlign.left,
          softWrap: true,
        ));
  }

  Widget _descText() {
    return Container(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text(
        Provider.of<Catalog>(context)
            .productsCatalog[widget.productId]
            .shortDescription,
        textAlign: TextAlign.left,
        softWrap: true,
      ),
    );
  }

  Widget _priceText() {
    return Container(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text(
          Provider.of<Catalog>(context)
                  .productsCatalog[widget.productId]
                  .toString() +
              ' EGP',
          textAlign: TextAlign.left),
    );
  }

  Widget _vendorText() {
    return Container(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text(
        Provider.of<Catalog>(context).productsCatalog[widget.productId].vendor,
        textAlign: TextAlign.left,
        softWrap: true,
      ),
    );
  }

  Widget _addToCart() {
    return GestureDetector(
        onTap: () {
          context.read<ShoppingCart>().isInShoppingCart(widget.productId)
              ? context
                  .read<ShoppingCart>()
                  .removeFromShoppingCart(widget.productId)
              : context
                  .read<ShoppingCart>()
                  .addToShoppingCart(widget.productId);
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
                          .isInShoppingCart(widget.productId)
                      ? Icons.shopping_cart
                      : Icons.add_shopping_cart,
                  color: Colors.white),
              Text(
                Provider.of<ShoppingCart>(context)
                        .isInShoppingCart(widget.productId)
                    ? 'In cart'
                    : 'Add to cart',
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

  Widget _unWatchlistSnackBar() {
    return SnackBar(
      content: Text(
          Provider.of<Catalog>(context).productsCatalog[widget.productId].name +
              ' was removed from watclist'),
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
                          ProductView(productId: widget.productId)))
              .then((value) => setState(() {}));
        },
        child: Dismissible(
          key: Key(Provider.of<Catalog>(context).productsCatalog[widget.productId].name),
          onDismissed: (direction) {
            context.read<Watchlist>().unWatchlist(widget.productId);
            Scaffold.of(context).showSnackBar(_unWatchlistSnackBar());
          },
          child: Container(
            margin: const EdgeInsets.all(2),
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.white),
                color: Colors.white),
            child: Row(
              children: [_leftColumn(), _rightColumn()],
            ),
          ),
        ));
  }
}
