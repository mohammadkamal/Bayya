import 'package:bayya/views/cart/shopping_cart_viewmodel.dart';
import 'package:bayya/views/catalog/catalog_viewmodel.dart';
import 'package:bayya/views/product/product_view.dart';
import 'package:bayya/views/widgets/stateful_widgets/list_item_image.dart';
import 'package:bayya/views/widgets/styles/box_decorations.dart';
import 'package:bayya/views/widgets/styles/tween_animation_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShoppingCartItem extends StatelessWidget {
  ShoppingCartItem({this.productId});
  final String productId;

  Widget _centerColumn(String productName, double productPrice) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _ShoppingCartItemTitle(title: productName),
        _ShoppingCartItemTotalPrice(
            productPrice: productPrice, productId: productId)
      ],
    );
  }

  Widget _buttonSection() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.grey[300],
      ),
      child: Row(
        children: [
          _DecreaseProductsQuantityButton(
            productId: productId,
          ),
          _ShoppingCartItemQuantity(
            productId: productId,
          ),
          _IncreaseProductsQuantityButton(
            productId: productId,
          )
        ],
      ),
    );
  }

  Widget _rightColumn() {
    return Container(
        margin: EdgeInsets.only(left: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            _RemoveFromCartButton(
              productId: productId,
            ),
            _buttonSection()
          ],
        ));
  }

  void _showProductPage(BuildContext context) {
    Navigator.push(
        context,
        TweenAnimationRoute().playAnimation(ProductView(
          productId: productId,
        )));
  }

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<CatalogViewModel>(context, listen: false)
        .getProduct(productId);
    return GestureDetector(
        onTap: () => _showProductPage(context),
        child: Container(
          padding: EdgeInsets.all(5),
          margin: const EdgeInsets.all(2),
          decoration: shoppingCartItemDecoration,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _ShoppingCartItemImage(
                imageURL: product.imageURL,
              ),
              _centerColumn(product.name, product.price),
              _rightColumn(),
            ],
          ),
        ));
  }
}

class _ShoppingCartItemImage extends StatelessWidget {
  final String imageURL;

  const _ShoppingCartItemImage({Key key, @required this.imageURL})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(left: 10, right: 10),
        child: ListItemImage(
          imageURL: imageURL,
        ));
  }
}

class _ShoppingCartItemTitle extends StatelessWidget {
  final String title;

  const _ShoppingCartItemTitle({Key key, @required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 20),
        child: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          textAlign: TextAlign.left,
          softWrap: true,
        ));
  }
}

class _ShoppingCartItemTotalPrice extends StatefulWidget {
  final double productPrice;
  final String productId;

  const _ShoppingCartItemTotalPrice(
      {Key key, @required this.productPrice, @required this.productId})
      : super(key: key);
  @override
  _ShoppingCartItemTotalPriceState createState() =>
      _ShoppingCartItemTotalPriceState();
}

class _ShoppingCartItemTotalPriceState
    extends State<_ShoppingCartItemTotalPrice> {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ShoppingCartViewModel>(context);
    return Container(
        margin: EdgeInsets.only(top: 20),
        child: Text(
          '${(widget.productPrice * viewModel.getQuantity(widget.productId)).toString()} EGP',
          textAlign: TextAlign.left,
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
        ));
  }
}

class _ShoppingCartItemQuantity extends StatefulWidget {
  final String productId;

  const _ShoppingCartItemQuantity({Key key, @required this.productId})
      : super(key: key);

  @override
  _ShoppingCartItemQuantityState createState() =>
      _ShoppingCartItemQuantityState();
}

class _ShoppingCartItemQuantityState extends State<_ShoppingCartItemQuantity> {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ShoppingCartViewModel>(context);
    return Container(
      padding: EdgeInsets.only(left: 5, right: 5),
      child: Text(
        viewModel.getQuantity(widget.productId).toString(),
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}

class _RemoveFromCartButton extends StatelessWidget {
  final String productId;

  const _RemoveFromCartButton({Key key, @required this.productId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ShoppingCartViewModel>(context);
    return Container(
        margin: EdgeInsets.only(bottom: 15),
        child: IconButton(
          icon: Icon(
            Icons.delete,
            color: Colors.grey[500],
          ),
          onPressed: () => viewModel.removeFromShoppingCart(productId),
        ));
  }
}

class _DecreaseProductsQuantityButton extends StatelessWidget {
  final String productId;

  const _DecreaseProductsQuantityButton({Key key, @required this.productId})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ShoppingCartViewModel>(context);
    return Container(
        margin: EdgeInsets.all(3),
        height: 30,
        width: 30,
        decoration: BoxDecoration(
            boxShadow: [BoxShadow(color: Colors.grey, spreadRadius: 0.5)],
            borderRadius: BorderRadius.circular(5),
            color: Colors.white),
        child: IconButton(
            iconSize: 15,
            icon: Icon(Icons.remove),
            onPressed: () => viewModel.decrement(productId)));
  }
}

class _IncreaseProductsQuantityButton extends StatelessWidget {
  final String productId;

  const _IncreaseProductsQuantityButton({Key key, @required this.productId})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ShoppingCartViewModel>(context);
    return Container(
        margin: EdgeInsets.all(3),
        height: 30,
        width: 30,
        decoration: BoxDecoration(
            boxShadow: [BoxShadow(color: Colors.grey, spreadRadius: 0.5)],
            borderRadius: BorderRadius.circular(5),
            color: Colors.white),
        child: IconButton(
            iconSize: 15,
            icon: Icon(Icons.add),
            onPressed: () => viewModel.increment(productId)));
  }
}
