import 'package:bayya/cart/shopping_cart.dart';
import 'package:bayya/cart/shopping_cart_upper_icon.dart';
import 'package:bayya/catalog/catalog.dart';
import 'package:bayya/user/vendors_list.dart';
import 'package:bayya/watchlist/watchlist.dart';
import 'package:bayya/widget_utilities/short_description_text.dart';
import 'package:bayya/widget_utilities/sign_in_to_perfom_action.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductView extends StatefulWidget {
  ProductView({this.productId});
  final String productId;

  @override
  _ProductViewState createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  String _imgURL = "";
  String _vendor = 'Vendor not provided';

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

  Widget _imageCard() {
    _getImageURL();
    return Container(
        color: Colors.white,
        child: CachedNetworkImage(
          placeholder: (context, url) => LinearProgressIndicator(),
          imageUrl: _imgURL,
        ));
  }

  Widget _titleText() {
    return Container(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
          Provider.of<Catalog>(context).productsCatalog[widget.productId].name,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          softWrap: true),
    );
  }

  Widget _priceText() {
    return Container(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
          Provider.of<Catalog>(context)
                  .productsCatalog[widget.productId]
                  .price
                  .toString() +
              ' EGP',
          style: TextStyle(fontWeight: FontWeight.bold),
          softWrap: true),
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
            ShortDescriptionText(
                shortDescription: Provider.of<Catalog>(context)
                    .productsCatalog[widget.productId]
                    .shortDescription,
                bottomPadding: 8),
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
                Provider.of<Catalog>(context)
                    .productsCatalog[widget.productId]
                    .longDescription,
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
                    .isInShoppingCart(widget.productId)
                ? Colors.red[400]
                : Colors.lightGreen[500],
            borderRadius: BorderRadius.circular(8)),
        width: 350,
        height: 50,
        child: Center(
            child: Text(
          Provider.of<ShoppingCart>(context).isInShoppingCart(widget.productId)
              ? 'Remove from cart'
              : 'Add to cart',
          style: TextStyle(color: Colors.white, fontSize: 20),
          softWrap: true,
        )),
      ),
    );
  }

  Widget _vendorCard() {
    _getVendorName();
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
            children: [Text(_vendor)],
          )
        ],
      ),
    );
  }

  Future<void> _getVendorName() async {
    var _result = await Provider.of<VendorsList>(context).getVendorNameByUid(
        Provider.of<Catalog>(context).productsCatalog[widget.productId].vendor);
    _vendor = _result;
  }

  Widget _upperIconWatchlist() {
    return IconButton(
        icon: Provider.of<Watchlist>(context).getWatchlisted(widget.productId)
            ? Icon(Icons.favorite, color: Colors.red)
            : Icon(Icons.favorite_border),
        onPressed: () {
          if (FirebaseAuth.instance.currentUser != null) {
            context.read<Watchlist>().getWatchlisted(widget.productId)
                ? context.read<Watchlist>().unWatchlist(widget.productId)
                : context.read<Watchlist>().setWatchlisted(widget.productId);
          } else {
            showDialog(
                context: context, builder: (context) => SignInToPerfomAction());
          }
        });
  }

  Widget _floatingAddToCart() {
    return FloatingActionButton(
        tooltip: 'Add to cart',
        child: Provider.of<ShoppingCart>(context)
                .isInShoppingCart(widget.productId)
            ? Icon(Icons.remove_shopping_cart)
            : Icon(Icons.add_shopping_cart),
        onPressed: () {
          _onAddToCartTap();
        });
  }

  void _onAddToCartTap() {
    if (FirebaseAuth.instance.currentUser != null) {
      context.read<ShoppingCart>().isInShoppingCart(widget.productId)
          ? context
              .read<ShoppingCart>()
              .removeFromShoppingCart(widget.productId)
          : context.read<ShoppingCart>().addToShoppingCart(widget.productId);
    } else {
      showDialog(
          context: context, builder: (context) => SignInToPerfomAction());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(Provider.of<Catalog>(context)
              .productsCatalog[widget.productId]
              .name),
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
