import 'dart:ui';
import 'package:bayya/catalog/catalog.dart';
import 'package:bayya/product/product_view.dart';
import 'package:bayya/widget_utilities/add_to_cart_button_list.dart';
import 'package:bayya/widget_utilities/list_item_image.dart';
import 'package:bayya/widget_utilities/list_item_vendor_text.dart';
import 'package:bayya/widget_utilities/short_description_text.dart';
import 'package:bayya/widget_utilities/tween_animation_route.dart';
import 'package:bayya/widget_utilities/watchlist_button_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShoppingListItem extends StatefulWidget {
  final String productId;
  ShoppingListItem({this.productId});

  @override
  _ShoppingListItemState createState() => _ShoppingListItemState();
}

class _ShoppingListItemState extends State<ShoppingListItem> {
  Widget _leftColumn() {
    return Container(
        padding: EdgeInsets.all(4),
        child: ListItemImage(
          productId: widget.productId,
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

  Widget _buttonSection() {
    return Container(
      padding: const EdgeInsets.all(4),
      child: Row(
        children: [
          AddToCartButtonList(
            productId: widget.productId,
          ),
          WatchlistButtonList(
            productId: widget.productId,
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
            _titleText(),
            ShortDescriptionText(
                bottomPadding: 4,
                shortDescription: Provider.of<Catalog>(context)
                    .productsCatalog[widget.productId]
                    .shortDescription),
            _priceText(),
            ListItemVendorText(productId: widget.productId),
            _buttonSection(),
          ],
        ));
  }

  void _onItemTap() {
    Navigator.push(
        context,
        TweenAnimationRoute()
            .playAnimation(ProductView(productId: widget.productId)));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Catalog>(builder: (context, catalog, child) {
      return GestureDetector(
        onTap: _onItemTap,
        child: Container(
            margin: const EdgeInsets.all(2),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(width: 1, color: Colors.white),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey[300],
                    spreadRadius: 1.25
                  )
                ]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [_leftColumn(), _rightColumn()],
            )),
      );
    });
  }
}
