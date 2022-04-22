import 'package:bayya/views/cart/shopping_cart_viewmodel.dart';
import 'package:bayya/views/catalog/catalog_viewmodel.dart';
import 'package:bayya/views/widgets/stateless_widgets/sign_in_to_perfom_action.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddToCartButtonList extends StatefulWidget {
  final String productId;

  const AddToCartButtonList({Key key, @required this.productId})
      : super(key: key);

  @override
  _AddToCartButtonListState createState() => _AddToCartButtonListState();
}

class _AddToCartButtonListState extends State<AddToCartButtonList> {
  ShoppingCartViewModel viewModel;

  @override
  void initState() {
    viewModel = ShoppingCartViewModel();
    super.initState();
  }

  SnackBar _snackBarCart(
      String productName, ShoppingCartViewModel shoppingCartViewModel) {
    return SnackBar(
      content: Text(productName +
          (shoppingCartViewModel.isInShoppingCart(widget.productId)
              ? ' was added to shopping cart'
              : ' was removed from shopping cart')),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {
          shoppingCartViewModel.isInShoppingCart(widget.productId)
              ? shoppingCartViewModel.removeFromShoppingCart(widget.productId)
              : shoppingCartViewModel.addToShoppingCart(widget.productId);
        },
      ),
    );
  }

  void onButtonTap(
      String productName, ShoppingCartViewModel shoppingCartViewModel) {
    if (FirebaseAuth.instance.currentUser != null) {
      shoppingCartViewModel.isInShoppingCart(widget.productId)
          ? shoppingCartViewModel.removeFromShoppingCart(widget.productId)
          : shoppingCartViewModel.addToShoppingCart(widget.productId);
      ScaffoldMessenger.of(context)
          .showSnackBar(_snackBarCart(productName, shoppingCartViewModel));
    } else {
      showDialog(
          context: context, builder: (context) => const SignInToPerfomAction());
    }
  }

  @override
  Widget build(BuildContext context) {
    ShoppingCartViewModel shoppingCartViewModel =
        Provider.of<ShoppingCartViewModel>(context);
    String productName = Provider.of<CatalogViewModel>(context)
        .getProduct(widget.productId)
        .name;

    return ChangeNotifierProvider.value(
      value: viewModel,
      builder: (buildContext, builderWidget) {
        return GestureDetector(
            onTap: () => onButtonTap(productName, shoppingCartViewModel),
            child: Container(
              width: 120,
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(1),
                  color: Colors.lightGreen[500]),
              child: Row(
                children: [
                  Icon(
                      shoppingCartViewModel.isInShoppingCart(widget.productId)
                          ? Icons.shopping_cart
                          : Icons.add_shopping_cart,
                      color: Colors.white),
                  Text(
                    shoppingCartViewModel.isInShoppingCart(widget.productId)
                        ? 'In cart'
                        : 'Add to cart',
                    style: const TextStyle(color: Colors.white),
                  )
                ],
              ),
            ));
      },
    );
  }
}
