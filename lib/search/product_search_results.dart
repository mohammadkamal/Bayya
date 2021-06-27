import 'package:bayya/catalog/shopping_list_item.dart';
import 'package:flutter/material.dart';

class ProductSearchResults extends StatefulWidget {
  final List<String> matchResults;

  const ProductSearchResults({Key key, this.matchResults}) : super(key: key);

  @override
  _ProductSearchResultsState createState() => _ProductSearchResultsState();
}

class _ProductSearchResultsState extends State<ProductSearchResults> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView.builder(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            itemCount: widget.matchResults.length,
            itemBuilder: (context, index) {
              return ShoppingListItem(
                  productId: widget.matchResults.elementAt(index));
            }));
  }
}
