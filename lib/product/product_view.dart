import 'package:bayya/cart/shopping_cart.dart';
import 'package:bayya/cart/shopping_cart_upper_icon.dart';
import 'package:bayya/catalog/catalog.dart';
import 'package:bayya/product/product_card_decoration.dart';
import 'package:bayya/product/product_review_card.dart';
import 'package:bayya/product/product_view_image.dart';
import 'package:bayya/product/product_view_vendor.dart';
import 'package:bayya/watchlist/watchlist.dart';
import 'package:bayya/widget_utilities/sign_in_to_perfom_action.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  Widget _titleText() {
    return Container(
      padding: const EdgeInsets.all(4),
      child: Text(
          Provider.of<Catalog>(context).productsCatalog[widget.productId].name,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          softWrap: true),
    );
  }

  Widget _priceText() {
    return Container(
      padding: const EdgeInsets.all(4),
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
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(bottom: 2, top: 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _titleText(),
            Container(
                padding: const EdgeInsets.all(4),
                child: Text(Provider.of<Catalog>(context)
                    .productsCatalog[widget.productId]
                    .shortDescription)),
            _priceText(),
          ],
        ),
        decoration: proudctCardDecoration());
  }

  Widget _descriptionCard() {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 2, top: 2),
      decoration: proudctCardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Details:',
            style: TextStyle(
                fontSize: 15, fontWeight: FontWeight.bold, color: Colors.grey),
          ),
          Text(
            Provider.of<Catalog>(context)
                .productsCatalog[widget.productId]
                .longDescription,
            softWrap: true,
          )
        ],
      ),
    );
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

  void _onWatchlistTap() {
    if (FirebaseAuth.instance.currentUser != null) {
      context.read<Watchlist>().getWatchlisted(widget.productId)
          ? context.read<Watchlist>().unWatchlist(widget.productId)
          : context.read<Watchlist>().setWatchlisted(widget.productId);
    } else {
      showDialog(
          context: context, builder: (context) => SignInToPerfomAction());
    }
  }

  Widget _addToCartSheetButton() {
    return OutlinedButton(
        onPressed: _onAddToCartTap,
        style: ButtonStyle(
            backgroundColor: Provider.of<ShoppingCart>(context)
                    .isInShoppingCart(widget.productId)
                ? MaterialStateProperty.all<Color>(Colors.red)
                : MaterialStateProperty.all<Color>(Colors.green)),
        child: Row(
          children: [
            Icon(
              Provider.of<ShoppingCart>(context)
                      .isInShoppingCart(widget.productId)
                  ? Icons.remove_shopping_cart
                  : Icons.add_shopping_cart,
              color: Colors.white,
            ),
            Text(
                Provider.of<ShoppingCart>(context)
                        .isInShoppingCart(widget.productId)
                    ? 'Remove from Shopping Cart'
                    : 'Add to Shopping Cart',
                style: TextStyle(color: Colors.white)),
          ],
        ));
  }

  Widget _watchlistSheetButton() {
    return OutlinedButton(
        style: ButtonStyle(
            shape: MaterialStateProperty.all<CircleBorder>(
                CircleBorder(side: BorderSide(width: 5)))),
        onPressed: _onWatchlistTap,
        child: Provider.of<Watchlist>(context).getWatchlisted(widget.productId)
            ? Icon(Icons.favorite, color: Colors.red)
            : Icon(
                Icons.favorite_border,
                color: Colors.red,
              ));
  }

  Widget _buttonsBottomSheet() {
    return Container(
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [_addToCartSheetButton(), _watchlistSheetButton()],
        ));
  }

  Widget _mainProduct() {
    return Container(
        margin: EdgeInsets.only(bottom: 40),
        child: ListView(
          children: [
            ProductViewImage(
              productId: widget.productId,
            ),
            _topInfoCard(),
            ProductViewVendor(
              productId: widget.productId,
            ),
            _descriptionCard(),
            ProductReviewCard(productId: widget.productId)
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Provider.of<Catalog>(context)
            .productsCatalog[widget.productId]
            .name),
        actions: <Widget>[ShoppingCartUpperIcon()],
      ),
      body: Stack(
        children: [_mainProduct(), _buttonsBottomSheet()],
      ),
    );
  }
}
