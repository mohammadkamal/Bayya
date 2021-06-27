import 'package:bayya/cart/shopping_cart.dart';
import 'package:bayya/catalog/catalog.dart';
import 'package:bayya/widget_utilities/sign_in_to_perfom_action.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddToCartButtonList extends StatefulWidget
{
  final String productId;

  const AddToCartButtonList({Key key, @required this.productId}) : super(key: key);
  
  @override
  _AddToCartButtonListState createState()=>_AddToCartButtonListState();
}

class _AddToCartButtonListState extends State<AddToCartButtonList>
{
  SnackBar _snackBarCart() {
    return SnackBar(
      content: Text(
          context.read<Catalog>().productsCatalog[widget.productId].name +
              (context.read<ShoppingCart>().isInShoppingCart(widget.productId)
                  ? ' was added to shopping cart'
                  : ' was removed from shopping cart')),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {
          context.read<ShoppingCart>().isInShoppingCart(widget.productId)
              ? context
                  .read<ShoppingCart>()
                  .removeFromShoppingCart(widget.productId)
              : context
                  .read<ShoppingCart>()
                  .addToShoppingCart(widget.productId);
        },
      ),
    );
  }

  void onButtonTap()
  {
    if (FirebaseAuth.instance.currentUser != null) {
            context.read<ShoppingCart>().isInShoppingCart(widget.productId)
                ? context
                    .read<ShoppingCart>()
                    .removeFromShoppingCart(widget.productId)
                : context
                    .read<ShoppingCart>()
                    .addToShoppingCart(widget.productId);
            ScaffoldMessenger.of(context).showSnackBar(_snackBarCart());
          } else {
            showDialog(
                context: context, builder: (context) => SignInToPerfomAction());
          }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onButtonTap,
        child: Container(
          width: 120,
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(1),
              color: Colors.lightGreen[500]),
          child: Row(
            children: [
              Icon(
                  Provider.of<ShoppingCart>(context)
                          .isInShoppingCart(widget.productId)
                      ? Icons.shopping_cart
                      : Icons.add_shopping_cart,
                  color: Colors.white),
              Text(
                Provider.of<ShoppingCart>(context)
                        .isInShoppingCart(widget.productId)
                    ? 'In cart'
                    : 'Add to cart',
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
        ));
  }
  
}