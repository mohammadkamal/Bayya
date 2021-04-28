import 'dart:ui';
import 'package:bayya/cart/shopping_cart.dart';
import 'package:bayya/catalog/catalog.dart';
import 'package:bayya/product/product_view.dart';
import 'package:bayya/user/vendors_list.dart';
import 'package:bayya/watchlist/watchlist.dart';
import 'package:bayya/widget_utilities/short_description_text.dart';
import 'package:bayya/widget_utilities/sign_in_to_perfom_action.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShoppingListItem extends StatefulWidget {
  final String productId;
  ShoppingListItem({this.productId});

  @override
  _ShoppingListItemState createState() => _ShoppingListItemState();
}

class _ShoppingListItemState extends State<ShoppingListItem> {
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

  Widget _priceText() {
    return Container(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text(
          Provider.of<Catalog>(context)
                  .productsCatalog[widget.productId]
                  .price
                  .toString() +
              ' EGP',
          textAlign: TextAlign.left),
    );
  }

  Widget _vendorText() {
    _getVendorName();
    return Container(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text(
        _vendor,
        textAlign: TextAlign.left,
        softWrap: true,
      ),
    );
  }

  Future<void> _getVendorName() async {
    var _result = await Provider.of<VendorsList>(context).getVendorNameByUid(
        Provider.of<Catalog>(context).productsCatalog[widget.productId].vendor);
    if (_vendor != _result) {
      setState(() {
        _vendor = _result;
      });
    }
  }

  Widget _buttonToCart() {
    return GestureDetector(
        onTap: () {
          if (FirebaseAuth.instance.currentUser != null) {
            context.read<ShoppingCart>().isInShoppingCart(widget.productId)
                ? context
                    .read<ShoppingCart>()
                    .removeFromShoppingCart(widget.productId)
                : context
                    .read<ShoppingCart>()
                    .addToShoppingCart(widget.productId);
            ScaffoldMessenger.of(context).showSnackBar(_snackBarCart());
          } else {
            showDialog(
                context: context, builder: (context) => SignInToPerfomAction());
          }
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

  Widget _buttonToWatchlist() {
    Icon iconWatchlist =
        Provider.of<Watchlist>(context).getWatchlisted(widget.productId)
            ? Icon(Icons.favorite, color: Colors.red)
            : Icon(Icons.favorite_border_outlined);
    return GestureDetector(
        onTap: () {
          if (FirebaseAuth.instance.currentUser != null) {
            context.read<Watchlist>().getWatchlisted(widget.productId)
                ? context.read<Watchlist>().unWatchlist(widget.productId)
                : context.read<Watchlist>().setWatchlisted(widget.productId);
          } else {
            showDialog(
                context: context, builder: (context) => SignInToPerfomAction());
          }
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
            _titleText(),
            ShortDescriptionText(
                bottomPadding: 4,
                shortDescription: Provider.of<Catalog>(context)
                    .productsCatalog[widget.productId]
                    .shortDescription),
            _priceText(),
            _vendorText(),
            _buttonSection(),
          ],
        ));
  }

  Widget _popupMenuButton() {
    return PopupMenuButton(
        itemBuilder: (context) => [
              PopupMenuItem(child: Text('Edit')),
              PopupMenuItem(child: Text('Report'))
            ]);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    ProductView(productId: widget.productId)));
      },
      child: Container(
          margin: const EdgeInsets.all(2),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(width: 1, color: Colors.white)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [_leftColumn(), _rightColumn(), _popupMenuButton()],
          )),
    );
  }

  SnackBar _snackBarCart() {
    return SnackBar(
      content: Text(
          Provider.of<Catalog>(context).productsCatalog[widget.productId].name +
              (context.read<ShoppingCart>().isInShoppingCart(widget.productId)
                  ? ' was added to shopping cart'
                  : ' was removed from shopping cart')),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {
          context.read<ShoppingCart>().isInShoppingCart(widget.productId)
              ? context
                  .read<ShoppingCart>()
                  .removeFromShoppingCart(widget.productId)
              : context
                  .read<ShoppingCart>()
                  .addToShoppingCart(widget.productId);
        },
      ),
    );
  }
}
