import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../cart/shopping_cart_list.dart';
import '../../cart/shopping_cart_viewmodel.dart';
import '../styles/tween_animation_route.dart';

class ShoppingCartUpperIcon extends StatelessWidget {
  const ShoppingCartUpperIcon({Key key}) : super(key: key);

  Widget _button(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.shopping_cart),
      onPressed: () {
        Navigator.of(context).push(
            TweenAnimationRoute().playAnimation(const ShoppingCartList()));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [_button(context), _CartProductsNumber()],
    );
  }
}

class _CartProductsNumber extends StatefulWidget {
  @override
  _CartProductsNumberState createState() => _CartProductsNumberState();
}

class _CartProductsNumberState extends State<_CartProductsNumber> {
  ShoppingCartViewModel shoppingCartViewModel;
  @override
  void initState() {
    shoppingCartViewModel = ShoppingCartViewModel();

    shoppingCartViewModel.fetchShoppingCart();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
        value: shoppingCartViewModel,
        builder: (buildContext, childWidget) {
          if (shoppingCartViewModel.shoppingCartMap.keys.isNotEmpty) {
            return CircleAvatar(
                backgroundColor: Colors.red,
                radius: 10,
                child: Text(
                    shoppingCartViewModel.shoppingCartMap.keys.length
                        .toString(),
                    style: const TextStyle(color: Colors.white)));
          } else {
            return Container();
          }
        });
  }
}
