import 'package:Bayya/Cart/ShoppingCart.dart';
import 'package:Bayya/ItemWidgets/ShortDescriptionText.dart';
import 'package:Bayya/Product/Product.dart';
import 'package:Bayya/Product/ProductView.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class ShoppingCartItem extends StatefulWidget {
  ShoppingCartItem({this.product});
  final Product product;

  @override
  _ShoppingCartItemState createState() => _ShoppingCartItemState();
}

class _ShoppingCartItemState extends State<ShoppingCartItem> {
  Widget _imageSection() {
    return Container(
        child: Image(
      image: widget.product.image.image,
      width: 100,
      height: 100,
      fit: BoxFit.fill,
    ));
  }

  Widget _leftColumn() {
    return Container(
        padding: EdgeInsets.all(4),
        child: Column(
          children: [_imageSection()],
        ));
  }

  Widget _titleText() {
    return Container(
        padding: const EdgeInsets.only(bottom: 4),
        child: Text(
          widget.product.name,
          style: TextStyle(fontWeight: FontWeight.bold),
          textAlign: TextAlign.left,
          softWrap: true,
        ));
  }

  Widget _priceText() {
    return Container(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text(widget.product.price.toString() + ' EGP',
          textAlign: TextAlign.left),
    );
  }

  Widget _vendorText() {
    return Container(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text(
        widget.product.vendor,
        textAlign: TextAlign.left,
        softWrap: true,
      ),
    );
  }

  Widget _minusButton() {
    return IconButton(
        icon: Icon(Icons.remove_circle_outline),
        onPressed: () {
          context.read<ShoppingCart>().decrement(widget.product);
        });
  }

  Widget _quantityText() {
    return Container(
      child: Text(Provider.of<ShoppingCart>(context)
          .getQuantity(widget.product)
          .toString()),
    );
  }

  Widget _plusButton() {
    return IconButton(
        icon: Icon(Icons.add_circle_outline),
        onPressed: () {
          setState(() {
            context.read<ShoppingCart>().increment(widget.product);
          });
        });
  }

  Widget _buttonSection() {
    return Container(
      padding: const EdgeInsets.all(4),
      child: Row(
        children: [
          Column(children: [_minusButton()]),
          Column(
            children: [_quantityText()],
          ),
          Column(
            children: [_plusButton()],
          )
        ],
      ),
    );
  }

  Widget _rightColumn() {
    return Container(
        padding: EdgeInsets.all(4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [_titleText()],
            ),
            Row(
              children: [
                ShortDescriptionText(
                    shortDescription: widget.product.shortDescription,
                    bottomPadding: 4)
              ],
            ),
            Row(children: [_priceText()]),
            Row(
              children: [_vendorText()],
            ),
            _buttonSection(),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ProductView(product: widget.product)))
              .then((value) => setState(() {}));
        },
        child: Container(
          margin: const EdgeInsets.all(2),
          decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.white),
              color: Colors.white),
          child: Row(
            children: [_leftColumn(), _rightColumn()],
          ),
        ));
  }
}
