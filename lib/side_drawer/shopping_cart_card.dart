import 'package:bayya/views/cart/shopping_cart_list.dart';
import 'package:bayya/views/cart/shopping_cart_viewmodel.dart';
import 'package:bayya/views/widgets/styles/tween_animation_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShoppingCartCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int cartCount = Provider.of<ShoppingCartViewModel>(context, listen: false)
        .shoppingCartMap
        .keys
        .length;
    if (cartCount == null) cartCount = 0;
    return GestureDetector(
        onTap: () => Navigator.of(context)
            .push(TweenAnimationRoute().playAnimation(ShoppingCartList())),
        child: Row(
          children: [
            Icon(Icons.shopping_cart, color: Colors.lightGreen),
            Text('Shopping Cart'),
            if (cartCount > 0)
              CircleAvatar(
                  backgroundColor: Colors.red,
                  radius: 12,
                  child: Text(
                    cartCount > 9 ? '9+' : cartCount.toString(),
                    style: TextStyle(color: Colors.white),
                  ))
          ],
        ));
    return ListTile(
        title: Text('Shopping Cart'),
        leading: Icon(Icons.shopping_cart, color: Colors.lightGreen),
        onTap: () => Navigator.of(context)
            .push(TweenAnimationRoute().playAnimation(ShoppingCartList())),
        trailing: cartCount > 0
            ? CircleAvatar(
                backgroundColor: Colors.red,
                radius: 12,
                child: Text(
                  cartCount > 9 ? '9+' : cartCount.toString(),
                  style: TextStyle(color: Colors.white),
                ))
            : Container());
  }
}
