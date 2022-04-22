import 'package:bayya/models/product.dart';
import 'package:bayya/views/cart/shopping_cart_viewmodel.dart';
import 'package:bayya/views/product/product_view.dart';
import 'package:bayya/views/product/product_viewmodel.dart';
import 'package:bayya/views/watchlist/watchlist_viewmodel.dart';
import 'package:bayya/views/widgets/stateful_widgets/list_item_image.dart';
import 'package:bayya/views/widgets/stateless_widgets/sign_in_to_perfom_action.dart';
import 'package:bayya/views/widgets/styles/tween_animation_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CatalogGridItem extends StatefulWidget {
  final Product product;
  final String productId;

  const CatalogGridItem({Key key, this.product, this.productId})
      : super(key: key);
  @override
  _CatalogGridItemState createState() => _CatalogGridItemState();
}

class _CatalogGridItemState extends State<CatalogGridItem> {
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
                  imageURL: widget.product.imageURL,
                )),
            _buttons()
          ],
        ),
        _CatalogGridItemTitle(title: widget.product.name),
        _CatalogGridItemPrice(price: widget.product.price)
      ],
    );
  }

  Widget _buttons() {
    return Column(
      children: [
        _CatalogGridItemAddToCartButton(
          productId: widget.productId,
        ),
        _CatalogGridItemWatchlistButton(
          productId: widget.productId,
        )
      ],
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

  void _onItemTap() {
    Navigator.push(
        context,
        TweenAnimationRoute()
            .playAnimation(ProductView(productId: widget.productId)));
  }
}

class _CatalogGridItemTitle extends StatelessWidget {
  final String title;

  const _CatalogGridItemTitle({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: TextAlign.start,
      style: TextStyle(fontWeight: FontWeight.bold),
    );
  }
}

class _CatalogGridItemPrice extends StatelessWidget {
  final double price;

  const _CatalogGridItemPrice({Key key, this.price}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text('${price.toString()} EGP');
  }
}

class _CatalogGridItemAddToCartButton extends StatefulWidget {
  final String productId;

  const _CatalogGridItemAddToCartButton({Key key, this.productId})
      : super(key: key);

  @override
  _CatalogGridItemAddToCartButtonState createState() =>
      _CatalogGridItemAddToCartButtonState();
}

class _CatalogGridItemAddToCartButtonState
    extends State<_CatalogGridItemAddToCartButton> {
  @override
  Widget build(BuildContext context) {
    final productViewModel = ProductViewModel();
    final cartViewModel = Provider.of<ShoppingCartViewModel>(context);
    final isInCart = cartViewModel.isInShoppingCart(widget.productId);
    return OutlinedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
            shape: MaterialStateProperty.all<CircleBorder>(
                CircleBorder(side: BorderSide(width: 5)))),
        onPressed: () =>
            _onAddToCartPressed(context, productViewModel, cartViewModel),
        child: isInCart
            ? Icon(Icons.remove_shopping_cart, color: Colors.white)
            : Icon(
                Icons.add_shopping_cart,
                color: Colors.white,
              ));
  }

  void _onAddToCartPressed(
      BuildContext context,
      ProductViewModel productViewModel,
      ShoppingCartViewModel shoppingCartViewModel) {
    productViewModel.onAddToCartTap(
        isInCart: shoppingCartViewModel.isInShoppingCart(widget.productId),
        notSignedIn: () => showDialog(
            context: context, builder: (context) => SignInToPerfomAction()),
        addToCartFunction: () =>
            shoppingCartViewModel.addToShoppingCart(widget.productId),
        removeFromCartFunction: () =>
            shoppingCartViewModel.removeFromShoppingCart(widget.productId));
  }
}

class _CatalogGridItemWatchlistButton extends StatefulWidget {
  final String productId;

  const _CatalogGridItemWatchlistButton({Key key, this.productId})
      : super(key: key);

  @override
  _CatalogGridItemWatchlistButtonState createState() =>
      _CatalogGridItemWatchlistButtonState();
}

class _CatalogGridItemWatchlistButtonState
    extends State<_CatalogGridItemWatchlistButton> {
  @override
  Widget build(BuildContext context) {
    final productViewModel = ProductViewModel();
    final watchlistViewModel = Provider.of<WatchlistViewModel>(context);
    final isWatchlisted = watchlistViewModel.isInWatchlist(widget.productId);
    return OutlinedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
            shape: MaterialStateProperty.all<CircleBorder>(
                CircleBorder(side: BorderSide(width: 5)))),
        onPressed: () =>
            _onWatchlistPressed(context, productViewModel, watchlistViewModel),
        child: isWatchlisted
            ? Icon(Icons.favorite, color: Colors.red)
            : Icon(
                Icons.favorite_border,
                color: Colors.red,
              ));
  }

  void _onWatchlistPressed(
      BuildContext context,
      ProductViewModel productViewModel,
      WatchlistViewModel watchlistViewModel) {
    productViewModel.onAddToCartTap(
        isInCart: watchlistViewModel.isInWatchlist(widget.productId),
        notSignedIn: () => showDialog(
            context: context, builder: (context) => SignInToPerfomAction()),
        addToCartFunction: () =>
            watchlistViewModel.addToWatchlist(widget.productId),
        removeFromCartFunction: () =>
            watchlistViewModel.removeFromWatchlist(widget.productId));
  }
}
