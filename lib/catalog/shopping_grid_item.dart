import 'package:bayya/cart/shopping_cart.dart';
import 'package:bayya/catalog/catalog.dart';
import 'package:bayya/product/product_view.dart';
import 'package:bayya/watchlist/watchlist.dart';
import 'package:bayya/widget_utilities/list_item_image.dart';
import 'package:bayya/widget_utilities/sign_in_to_perfom_action.dart';
import 'package:bayya/widget_utilities/tween_animation_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShoppingGridItem extends StatefulWidget {
  final String productId;

  const ShoppingGridItem({Key key, this.productId}) : super(key: key);
  @override
  _ShoppingGridItemState createState() => _ShoppingGridItemState();
}

class _ShoppingGridItemState extends State<ShoppingGridItem> {
  Widget _titleWidget() {
    return Text(
      Provider.of<Catalog>(context).productsCatalog[widget.productId].name,
      textAlign: TextAlign.start,
      style: TextStyle(fontWeight: FontWeight.bold),
    );
  }

  Widget _priceWidget() {
    return Text(Provider.of<Catalog>(context)
            .productsCatalog[widget.productId]
            .price
            .toString() +
        ' EGP');
  }

  Widget _mainProductWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: Alignment.centerRight,
          children: [
            Align(
                alignment: Alignment.center,
                child: ListItemImage(
                  productId: widget.productId,
                )),
            _buttons()
          ],
        ),
        _titleWidget(),
        _priceWidget()
      ],
    );
  }

  Widget _floatingAddToCart() {
    return OutlinedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
            shape: MaterialStateProperty.all<CircleBorder>(
                CircleBorder(side: BorderSide(width: 5)))),
        onPressed: _onAddToCartTap,
        child: Provider.of<ShoppingCart>(context)
                .isInShoppingCart(widget.productId)
            ? Icon(Icons.remove_shopping_cart, color: Colors.white)
            : Icon(
                Icons.add_shopping_cart,
                color: Colors.white,
              ));
  }

  Widget _floatingWatchlist() {
    return OutlinedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.grey[300]),
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

  Widget _buttons() {
    return Column(
      children: [_floatingAddToCart(), _floatingWatchlist()],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: _onItemTap,
        child: Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(color: Colors.grey[300], spreadRadius: 1.25)
                ]),
            child: _mainProductWidget()));
  }

  ///Methods

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

  void _onItemTap() {
    Navigator.push(
        context,
        TweenAnimationRoute()
            .playAnimation(ProductView(productId: widget.productId)));
  }
}
