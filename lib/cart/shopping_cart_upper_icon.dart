import 'package:bayya/cart/shopping_cart.dart';
import 'package:bayya/cart/shopping_cart_list.dart';
import 'package:bayya/widget_utilities/tween_animation_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShoppingCartUpperIcon extends StatefulWidget {
  @override
  _ShoppingCartUpperIconState createState() => _ShoppingCartUpperIconState();
}

class _ShoppingCartUpperIconState extends State<ShoppingCartUpperIcon> {
  Widget _productsNumber() {
    if (Provider.of<ShoppingCart>(context).shoppingItemQuantites.keys.length >
        0) {
      return CircleAvatar(
          backgroundColor: Colors.red,
          radius: 10,
          child: Text(
              Provider.of<ShoppingCart>(context)
                  .shoppingItemQuantites
                  .keys
                  .length
                  .toString(),
              style: TextStyle(color: Colors.white)));
    } else {
      return Container();
    }
  }

  Widget _button() {
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
      children: [_button(), _productsNumber()],
    );
  }
}
