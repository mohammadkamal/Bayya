import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/product.dart';
import '../../models/vendor_account.dart';
import '../cart/shopping_cart_viewmodel.dart';
import '../catalog/catalog_viewmodel.dart';
import '../review/product_review_card.dart';
import '../watchlist/watchlist_viewmodel.dart';
import '../widgets/mixed_widgets/shopping_cart_upper_icon.dart';
import '../widgets/stateless_widgets/sign_in_to_perfom_action.dart';
import '../widgets/styles/box_decorations.dart';
import 'product_view_image.dart';
import 'product_viewmodel.dart';

class ProductView extends StatelessWidget {
  final String productId;

  const ProductView({Key key, this.productId}) : super(key: key);

  Widget _topInfoCard(
      String productTitle, String shortDesc, double productPrice) {
    return Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(bottom: 2, top: 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ProductViewTitle(
              title: productTitle,
            ),
            Container(padding: const EdgeInsets.all(4), child: Text(shortDesc)),
            _ProductViewPrice(
              price: productPrice,
            ),
          ],
        ),
        decoration: proudctCardDecoration);
  }

  Widget _buttonsBottomSheet() {
    return Container(
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _AddToCartButton(
              productId: productId,
            ),
            _AddToWatchlistButton(
              productId: productId,
            )
          ],
        ));
  }

  Widget _mainProduct(Product product) {
    return Container(
        margin: const EdgeInsets.only(bottom: 40),
        child: ListView(
          children: [
            ProductViewImage(
              imageURL: product.imageURL,
            ),
            _topInfoCard(product.name, product.shortDescription, product.price),
            _ProductVendorText(
              vendorAccount: product.vendor,
            ),
            _ProductViewLongDescription(
              longDescription: product.longDescription,
            ),
            ProductReviewCard(productId: productId)
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<CatalogViewModel>(context, listen: false)
        .getProduct(productId);
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
        actions: const <Widget>[ShoppingCartUpperIcon()],
      ),
      body: Stack(
        children: [_mainProduct(product), _buttonsBottomSheet()],
      ),
    );
  }
}

class _ProductViewTitle extends StatelessWidget {
  final String title;

  const _ProductViewTitle({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      child: Text(title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          softWrap: true),
    );
  }
}

class _ProductViewPrice extends StatelessWidget {
  final double price;

  const _ProductViewPrice({Key key, this.price}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      child: Text(price.toString() + ' EGP',
          style: const TextStyle(fontWeight: FontWeight.bold), softWrap: true),
    );
  }
}

class _ProductViewLongDescription extends StatelessWidget {
  final String longDescription;

  const _ProductViewLongDescription({Key key, this.longDescription})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 2, top: 2),
      decoration: proudctCardDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Details:',
            style: TextStyle(
                fontSize: 15, fontWeight: FontWeight.bold, color: Colors.grey),
          ),
          Text(
            longDescription,
            softWrap: true,
          )
        ],
      ),
    );
  }
}

class _ProductVendorText extends StatelessWidget {
  final VendorAccount vendorAccount;

  const _ProductVendorText({Key key, this.vendorAccount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (vendorAccount == null) {
      return const Text("Vendor isn't provided",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red));
    } else {
      return Text(vendorAccount.displayName ?? vendorAccount.email,
          style: const TextStyle(fontWeight: FontWeight.bold));
    }
  }
}

class _AddToCartButton extends StatefulWidget {
  final String productId;

  const _AddToCartButton({Key key, this.productId}) : super(key: key);

  @override
  _AddToCartButtonState createState() => _AddToCartButtonState();
}

class _AddToCartButtonState extends State<_AddToCartButton> {
  @override
  Widget build(BuildContext context) {
    final productViewModel = ProductViewModel();
    final cartViewModel = Provider.of<ShoppingCartViewModel>(context);
    final isInCart = cartViewModel.isInShoppingCart(widget.productId);
    return OutlinedButton(
        onPressed: () =>
            _onAddToCartTap(context, productViewModel, cartViewModel),
        style: ButtonStyle(
            backgroundColor: isInCart
                ? MaterialStateProperty.all<Color>(Colors.red)
                : MaterialStateProperty.all<Color>(Colors.green)),
        child: Row(
          children: [
            Icon(
              isInCart ? Icons.remove_shopping_cart : Icons.add_shopping_cart,
              color: Colors.white,
            ),
            Text(
                isInCart ? 'Remove from Shopping Cart' : 'Add to Shopping Cart',
                style: const TextStyle(color: Colors.white)),
          ],
        ));
  }

  void _onAddToCartTap(BuildContext context, ProductViewModel productViewModel,
      ShoppingCartViewModel shoppingCartViewModel) {
    productViewModel.onAddToCartTap(
        isInCart: shoppingCartViewModel.isInShoppingCart(widget.productId),
        notSignedIn: () => showDialog(
            context: context, builder: (context) => const SignInToPerfomAction()),
        addToCartFunction: () =>
            shoppingCartViewModel.addToShoppingCart(widget.productId),
        removeFromCartFunction: () =>
            shoppingCartViewModel.removeFromShoppingCart(widget.productId));
  }
}

class _AddToWatchlistButton extends StatefulWidget {
  final String productId;

  const _AddToWatchlistButton({Key key, this.productId}) : super(key: key);

  @override
  _AddToWatchlistButtonState createState() => _AddToWatchlistButtonState();
}

class _AddToWatchlistButtonState extends State<_AddToWatchlistButton> {
  @override
  Widget build(BuildContext context) {
    final productViewModel = ProductViewModel();
    final watchlistViewModel = Provider.of<WatchlistViewModel>(context);
    final isWatchlisted = watchlistViewModel.isInWatchlist(widget.productId);
    return OutlinedButton(
      onPressed: () =>
          _onAddToWatchlistTap(context, productViewModel, watchlistViewModel),
      style: ButtonStyle(
          shape: MaterialStateProperty.all<CircleBorder>(
              const CircleBorder(side: BorderSide(width: 5)))),
      child: Icon(
        isWatchlisted ? Icons.favorite : Icons.favorite_border,
        color: Colors.red,
      ),
    );
  }

  void _onAddToWatchlistTap(
      BuildContext context,
      ProductViewModel productViewModel,
      WatchlistViewModel watchlistViewModel) {
    productViewModel.onWatchlistTap(
        isWatchlisted: watchlistViewModel.isInWatchlist(widget.productId),
        notSignedIn: () => showDialog(
            context: context, builder: (context) => const SignInToPerfomAction()),
        watchFunction: () =>
            watchlistViewModel.addToWatchlist(widget.productId),
        unwatchFunction: () =>
            watchlistViewModel.removeFromWatchlist(widget.productId));
  }
}
