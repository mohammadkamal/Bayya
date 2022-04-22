import 'dart:ui';

import 'package:bayya/models/product.dart';
import 'package:bayya/views/catalog/catalog_viewmodel.dart';
import 'package:bayya/views/product/product_view.dart';
import 'package:bayya/views/widgets/stateful_widgets/add_to_cart_button_list.dart';
import 'package:bayya/views/widgets/stateful_widgets/list_item_image.dart';
import 'package:bayya/views/widgets/stateful_widgets/list_item_vendor_text.dart';
import 'package:bayya/views/widgets/stateful_widgets/watchlist_button_list.dart';
import 'package:bayya/views/widgets/stateless_widgets/short_description_text.dart';
import 'package:bayya/views/widgets/styles/tween_animation_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class _CatalogListItemImage extends StatelessWidget {
  final String imageURL;

  const _CatalogListItemImage({Key key, this.imageURL}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(4),
        child: ListItemImage(
          imageURL: imageURL,
        ));
  }
}

class _CatalogListItemTitle extends StatelessWidget {
  final String title;

  const _CatalogListItemTitle({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(bottom: 4),
        child: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold),
          textAlign: TextAlign.left,
          softWrap: true,
        ));
  }
}

class _CatalogListItemPrice extends StatelessWidget {
  final double price;

  const _CatalogListItemPrice({Key key, this.price}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text('${price.toString()} EGP', textAlign: TextAlign.left),
    );
  }
}

class CatalogListItem extends StatelessWidget {
  final String productId;
  final Product product;
  CatalogListItem({this.productId, this.product});

  Widget _buttonSection() {
    return Container(
      padding: const EdgeInsets.all(4),
      child: Row(
        children: [
          AddToCartButtonList(
            productId: productId,
          ),
          WatchlistButtonList(
            productId: productId,
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
            _CatalogListItemTitle(title: product.name),
            ShortDescriptionText(
                bottomPadding: 4, shortDescription: product.shortDescription),
            _CatalogListItemPrice(
              price: product.price,
            ),
            ListItemVendorText(vendorAccount: product.vendor),
            _buttonSection(),
          ],
        ));
  }

  void _onItemTap(BuildContext context) {
    Navigator.push(context,
        TweenAnimationRoute().playAnimation(ProductView(productId: productId)));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CatalogViewModel>(builder: (buildContext, catalog, child) {
      return GestureDetector(
        onTap: () => _onItemTap,
        child: Container(
            margin: const EdgeInsets.all(2),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(width: 1, color: Colors.white),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(color: Colors.grey[300], spreadRadius: 1.25)
                ]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _CatalogListItemImage(
                  imageURL: product.imageURL,
                ),
                _rightColumn()
              ],
            )),
      );
    });
  }
}
