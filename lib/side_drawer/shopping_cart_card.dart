import 'package:bayya/cart/shopping_cart.dart';
import 'package:bayya/cart/shopping_cart_list.dart';
import 'package:bayya/widget_utilities/tween_animation_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShoppingCartCard extends StatefulWidget {
  @override
  _ShoppingCartCardState createState() => _ShoppingCartCardState();
}

class _ShoppingCartCardState extends State<ShoppingCartCard> {
  @override
  Widget build(BuildContext context) {
    int cartCount =
        Provider.of<ShoppingCart>(context).shoppingItemQuantites.keys.length;
    return ListTile(
        title: Text('Shopping Cart'),
        leading: Icon(Icons.shopping_cart, color: Colors.lightGreen),
        onTap: () {
          Navigator.of(context)
              .push(TweenAnimationRoute().playAnimation(ShoppingCartList()));
        },
        trailing: cartCount > 0
            ? CircleAvatar(
                backgroundColor: Colors.red,
                radius: 12,
                child: Text(
                  cartCount > 9 ? '9+' : cartCount.toString(),
                  style: TextStyle(color: Colors.white),
                ))
            : null);
  }
}
