import 'package:bayya/cart/shopping_cart.dart';
import 'package:bayya/catalog/Catalog.dart';
import 'package:bayya/product/product_view.dart';
import 'package:bayya/user/vendors_list.dart';
import 'package:bayya/widget_utilities/short_description_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
  String _imgURL = "";
  String _vendor = 'Vendor not provided';

  Future<void> _getImageURL() async {
    var result = await FirebaseStorage.instance
        .ref()
        .child(Provider.of<Catalog>(context)
            .productsCatalog[widget.productId]
            .imageURL)
        .getDownloadURL();

    if (_imgURL == null || _imgURL.isEmpty) {
      setState(() {
        _imgURL = result;
      });
    }
  }

  Widget _imageSection() {
    _getImageURL();
    return Container(
        width: 100,
        height: 100,
        child: CachedNetworkImage(
          placeholder: (context, url) => CircularProgressIndicator(),
          imageUrl: _imgURL,
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
          Provider.of<Catalog>(context).productsCatalog[widget.productId].name,
          style: TextStyle(fontWeight: FontWeight.bold),
          textAlign: TextAlign.left,
          softWrap: true,
        ));
  }

  Widget _priceText() {
    return Container(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text(
          Provider.of<Catalog>(context)
                  .productsCatalog[widget.productId]
                  .price
                  .toString() +
              ' EGP',
          textAlign: TextAlign.left),
    );
  }

  Widget _vendorText() {
    _getVendorName();
    return Container(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text(
        _vendor,
        textAlign: TextAlign.left,
        softWrap: true,
      ),
    );
  }

  Future<void> _getVendorName() async {
    var _result = await Provider.of<VendorsList>(context).getVendorNameByUid(
        Provider.of<Catalog>(context).productsCatalog[widget.productId].vendor);
    _vendor = _result;
  }

  Widget _minusButton() {
    return IconButton(
        icon: Icon(Icons.remove_circle_outline),
        onPressed: () {
          context.read<ShoppingCart>().decrement(widget.productId);
        });
  }

  Widget _quantityText() {
    return Container(
      child: Text(Provider.of<ShoppingCart>(context)
          .getQuantity(widget.productId)
          .toString()),
    );
  }

  Widget _plusButton() {
    return IconButton(
        icon: Icon(Icons.add_circle_outline),
        onPressed: () {
          setState(() {
            context.read<ShoppingCart>().increment(widget.productId);
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
                    shortDescription: Provider.of<Catalog>(context)
                        .productsCatalog[widget.productId]
                        .shortDescription,
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
                          ProductView(productId: widget.productId)))
              .then((value) => setState(() {}));
        },
        child: Container(
          margin: const EdgeInsets.all(2),
          decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.white),
              color: Colors.white),
          child: Row(
            children: [_leftColumn(), _rightColumn(),],
          ),
        ));
  }
}
