import 'package:bayya/views/cart/shopping_cart_item.dart';
import 'package:bayya/views/cart/shopping_cart_viewmodel.dart';
import 'package:bayya/views/catalog/catalog_view.dart';
import 'package:bayya/views/widgets/styles/tween_animation_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShoppingCartList extends StatelessWidget {
  const ShoppingCartList({Key key}) : super(key: key);

  Widget _proceedButton() {
    return ElevatedButton(
      onPressed: null,
      child: const Text('Proceed to checkout',
          style: TextStyle(fontSize: 20, color: Colors.white)),
      style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all<Color>(Colors.lightGreen[500])),
    );
  }

  @override
  Widget build(BuildContext context) {
    final viewModel =
        Provider.of<ShoppingCartViewModel>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping Cart'),
      ),
      body: viewModel.shoppingCartMap.isNotEmpty
          ? _BuildCartProducts()
          : _EmptyCartContent(),
      bottomSheet:
          viewModel.shoppingCartMap.isNotEmpty ? _proceedButton() : null,
    );
  }
}

class _EmptyCartContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.shopping_cart_outlined,
              size: 55,
              color: Colors.blue[300],
            ),
            const Text('Start shopping now'),
            OutlinedButton(
                onPressed: () => Navigator.pushReplacement(context,
                    TweenAnimationRoute().playAnimation(const CatalogView())),
                child: const Text('Discover products'))
          ],
        ));
  }
}

class _BuildCartProducts extends StatefulWidget {
  @override
  _BuildCartProductsState createState() => _BuildCartProductsState();
}

class _BuildCartProductsState extends State<_BuildCartProducts> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ShoppingCartViewModel>(
        builder: (buildContext, viewModel, childWidget) {
      return ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          itemCount: viewModel.shoppingCartMap.keys.length,
          itemBuilder: (context, index) {
            return ShoppingCartItem(
                productId: viewModel.shoppingCartMap.keys.elementAt(index));
          });
    });
  }
}
