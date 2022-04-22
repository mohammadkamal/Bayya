import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/vendor_account.dart';
import '../catalog/catalog_viewmodel.dart';
import '../product/product_view.dart';
import '../widgets/stateful_widgets/add_to_cart_button_list.dart';
import '../widgets/stateful_widgets/list_item_image.dart';
import '../widgets/stateful_widgets/list_item_vendor_text.dart';
import '../widgets/styles/tween_animation_route.dart';
import 'watchlist_viewmodel.dart';

class WatchlistItem extends StatefulWidget {
  final String productId;

  const WatchlistItem({Key key, this.productId}) : super(key: key);

  @override
  _WatchlistItemState createState() => _WatchlistItemState();
}

class _WatchlistItemState extends State<WatchlistItem> {
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

  Widget _rightColumn(String productTitle, String productDescription,
      double productPrice, VendorAccount productVendor) {
    return Container(
        padding: const EdgeInsets.all(4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _WatchlistItemTitle(
              title: productTitle,
            ),
            _WatchlistItemDescription(
              description: productDescription,
            ),
            _WatchlistItemPrice(
              price: productPrice,
            ),
            ListItemVendorText(
              vendorAccount: productVendor,
            ),
            _buttonSection(),
          ],
        ));
  }

  SnackBar _unWatchlistSnackBar(String productName) {
    return SnackBar(
      content: Text('$productName was removed from watclist'),
    );
  }

  @override
  Widget build(BuildContext context) {
    final product =
        Provider.of<CatalogViewModel>(context).getProduct(widget.productId);
    return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              TweenAnimationRoute()
                  .playAnimation(ProductView(productId: widget.productId)));
        },
        child: Dismissible(
          key: Key(product.name),
          onDismissed: (direction) {
            context
                .read<WatchlistViewModel>()
                .removeFromWatchlist(widget.productId);
            ScaffoldMessenger.of(context)
                .showSnackBar(_unWatchlistSnackBar(product.name));
          },
          child: Container(
            margin: const EdgeInsets.all(2),
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.white),
                color: Colors.white),
            child: Row(
              children: [
                _WatchlistItemImage(
                  imageURL: product.imageURL,
                ),
                _rightColumn(product.name, product.shortDescription,
                    product.price, product.vendor)
              ],
            ),
          ),
        ));
  }
}

class _WatchlistItemImage extends StatelessWidget {
  final String imageURL;

  const _WatchlistItemImage({Key key, this.imageURL}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(4),
        child: Column(
          children: [
            ListItemImage(
              imageURL: imageURL,
            )
          ],
        ));
  }
}

class _WatchlistItemTitle extends StatelessWidget {
  final String title;

  const _WatchlistItemTitle({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(bottom: 4),
        child: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
          textAlign: TextAlign.left,
          softWrap: true,
        ));
  }
}

class _WatchlistItemDescription extends StatelessWidget {
  final String description;

  const _WatchlistItemDescription({Key key, this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text(
        description,
        textAlign: TextAlign.left,
        softWrap: true,
      ),
    );
  }
}

class _WatchlistItemPrice extends StatelessWidget {
  final double price;

  const _WatchlistItemPrice({Key key, this.price}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text('${price.toString()} EGP', textAlign: TextAlign.left),
    );
  }
}
