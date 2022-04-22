import 'package:flutter/material.dart';

import '../views/catalog/catalog_list_item_view.dart';

class ProductSearchResults extends StatefulWidget {
  final List<String> matchResults;

  const ProductSearchResults({Key key, this.matchResults}) : super(key: key);

  @override
  _ProductSearchResultsState createState() => _ProductSearchResultsState();
}

class _ProductSearchResultsState extends State<ProductSearchResults> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        itemCount: widget.matchResults.length,
        itemBuilder: (context, index) {
          return CatalogListItem(
              productId: widget.matchResults.elementAt(index));
        });
  }
}
