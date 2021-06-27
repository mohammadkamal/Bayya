import 'package:bayya/cart/shopping_cart.dart';
import 'package:bayya/catalog/catalog.dart';
import 'package:bayya/product/product_view.dart';
import 'package:bayya/widget_utilities/list_item_image.dart';
import 'package:bayya/widget_utilities/tween_animation_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class ShoppingCartItem extends StatefulWidget {
  ShoppingCartItem({this.productId});
  final String productId;

  @override
  _ShoppingCartItemState createState() => _ShoppingCartItemState();
}

class _ShoppingCartItemState extends State<ShoppingCartItem> {
  BoxDecoration _itemDecoration() {
    return BoxDecoration(
        boxShadow: [
          BoxShadow(color: Colors.grey, spreadRadius: 0.5, blurRadius: 2)
        ],
        borderRadius: BorderRadius.circular(15),
        border: Border.all(width: 1, color: Colors.white),
        color: Colors.white);
  }

  Widget _leftColumn() {
    return Container(
        margin: EdgeInsets.only(left: 10, right: 10),
        child: ListItemImage(
          productId: widget.productId,
        ));
  }

  Widget _titleText() {
    return Container(
        margin: EdgeInsets.only(bottom: 20),
        child: Text(
          Provider.of<Catalog>(context).productsCatalog[widget.productId].name,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          textAlign: TextAlign.left,
          softWrap: true,
        ));
  }

  Widget _centerColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [_titleText(), _priceText()],
    );
  }

  Widget _removeButton() {
    return Container(
        margin: EdgeInsets.only(bottom: 15),
        child: IconButton(
          icon: Icon(
            Icons.delete,
            color: Colors.grey[500],
          ),
          onPressed: () => context
              .read<ShoppingCart>()
              .removeFromShoppingCart(widget.productId),
        ));
  }

  Widget _priceText() {
    String _priceString = (Provider.of<Catalog>(context)
                .productsCatalog[widget.productId]
                .price *
            Provider.of<ShoppingCart>(context).getQuantity(widget.productId))
        .toString();

    return Container(
        margin: EdgeInsets.only(top: 20),
        child: Text(
          _priceString + ' EGP',
          textAlign: TextAlign.left,
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
        ));
  }

  Widget _minusButton() {
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
            onPressed: () =>
                context.read<ShoppingCart>().decrement(widget.productId)));
  }

  Widget _quantityText() {
    return Container(
      padding: EdgeInsets.only(left: 5, right: 5),
      child: Text(
        Provider.of<ShoppingCart>(context)
            .getQuantity(widget.productId)
            .toString(),
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _plusButton() {
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
            onPressed: () =>
                context.read<ShoppingCart>().increment(widget.productId)));
  }

  Widget _buttonSection() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.grey[300],
      ),
      child: Row(
        children: [_minusButton(), _quantityText(), _plusButton()],
      ),
    );
  }

  Widget _rightColumn() {
    return Container(
        margin: EdgeInsets.only(left: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [_removeButton(), _buttonSection()],
        ));
  }

  void _showProductPage() {
    Navigator.push(
        context,
        TweenAnimationRoute().playAnimation(ProductView(
          productId: widget.productId,
        )));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: _showProductPage,
        child: Container(
          padding: EdgeInsets.all(5),
          margin: const EdgeInsets.all(2),
          decoration: _itemDecoration(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _leftColumn(),
              _centerColumn(),
              _rightColumn(),
            ],
          ),
        ));
  }
}
