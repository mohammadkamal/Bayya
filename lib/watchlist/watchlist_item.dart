import 'package:bayya/catalog/catalog.dart';
import 'package:bayya/product/product_view.dart';
import 'package:bayya/watchlist/watchlist.dart';
import 'package:bayya/widget_utilities/add_to_cart_button_list.dart';
import 'package:bayya/widget_utilities/list_item_image.dart';
import 'package:bayya/widget_utilities/list_item_vendor_text.dart';
import 'package:bayya/widget_utilities/tween_animation_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WatchlistItem extends StatefulWidget {
  WatchlistItem({this.productId});
  final String productId;

  @override
  _WatchlistItemState createState() => _WatchlistItemState();
}

class _WatchlistItemState extends State<WatchlistItem> {
  Widget _leftColumn() {
    return Container(
        padding: EdgeInsets.all(4),
        child: Column(
          children: [
            ListItemImage(
              productId: widget.productId,
            )
          ],
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

  Widget _descText() {
    return Container(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text(
        Provider.of<Catalog>(context)
            .productsCatalog[widget.productId]
            .shortDescription,
        textAlign: TextAlign.left,
        softWrap: true,
      ),
    );
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
            _descText(),
            _priceText(),
            ListItemVendorText(productId: widget.productId),
            _buttonSection(),
          ],
        ));
  }

  SnackBar _unWatchlistSnackBar() {
    return SnackBar(
      content: Text(
          context.read<Catalog>().productsCatalog[widget.productId].name +
              ' was removed from watclist'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              TweenAnimationRoute()
                  .playAnimation(ProductView(productId: widget.productId)));
        },
        child: Dismissible(
          key: Key(Provider.of<Catalog>(context)
              .productsCatalog[widget.productId]
              .name),
          onDismissed: (direction) {
            context.read<Watchlist>().unWatchlist(widget.productId);
            ScaffoldMessenger.of(context).showSnackBar(_unWatchlistSnackBar());
          },
          child: Container(
            margin: const EdgeInsets.all(2),
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.white),
                color: Colors.white),
            child: Row(
              children: [_leftColumn(), _rightColumn()],
            ),
          ),
        ));
  }
}
