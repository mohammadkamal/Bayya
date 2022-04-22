import 'dart:developer';

import 'package:bayya/views/cart/shopping_cart_list.dart';
import 'package:bayya/views/cart/shopping_cart_viewmodel.dart';
import 'package:bayya/views/widgets/styles/tween_animation_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShoppingCartUpperIcon extends StatelessWidget {
  Widget _button(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.shopping_cart),
      onPressed: () {
        Navigator.of(context)
            .push(TweenAnimationRoute().playAnimation(ShoppingCartList()));
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
    shoppingCartViewModel.addListener(() {
      log('shopping cart listener');
    });
    shoppingCartViewModel.fetchShoppingCart();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
        value: shoppingCartViewModel,
        builder: (buildContext, childWidget) {
          if (shoppingCartViewModel.shoppingCartMap.keys.length > 0) {
            return CircleAvatar(
                backgroundColor: Colors.red,
                radius: 10,
                child: Text(
                    shoppingCartViewModel.shoppingCartMap.keys.length
                        .toString(),
                    style: TextStyle(color: Colors.white)));
          } else {
            return Container();
          }
        });
  }
}
