import 'package:bayya/cart/shopping_cart.dart';
import 'package:bayya/cart/shopping_cart_item.dart';
import 'package:bayya/catalog/shopping_list.dart';
import 'package:bayya/widget_utilities/tween_animation_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShoppingCartList extends StatefulWidget {
  @override
  _ShoppingCartListState createState() => _ShoppingCartListState();
}

class _ShoppingCartListState extends State<ShoppingCartList> {
  Widget _listOfProducts() {
    return ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        itemCount: Provider.of<ShoppingCart>(context)
            .shoppingItemQuantites
            .keys
            .length,
        itemBuilder: (context, index) {
          return ShoppingCartItem(
              productId: Provider.of<ShoppingCart>(context)
                  .shoppingItemQuantites
                  .keys
                  .elementAt(index));
        });
  }

  Widget _emptyCartContent() {
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
            Text('Start shopping now'),
            OutlinedButton(
                onPressed: () => Navigator.pushReplacement(context,
                    TweenAnimationRoute().playAnimation(ShoppingList())),
                child: Text('Discover products'))
          ],
        ));
  }

  Widget _proceedButton() {
    if (Provider.of<ShoppingCart>(context).shoppingItemQuantites.isNotEmpty) {
      return ElevatedButton(
        onPressed: null,
        child: Text('Proceed to checkout',
            style: TextStyle(fontSize: 20, color: Colors.white)),
        style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(Colors.lightGreen[500])),
      );
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping Cart'),
      ),
      body: Provider.of<ShoppingCart>(context).shoppingItemQuantites.isNotEmpty
          ? _listOfProducts()
          : _emptyCartContent(),
      bottomSheet: _proceedButton(),
    );
  }
}
