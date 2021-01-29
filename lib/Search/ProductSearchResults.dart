import 'package:Bayya/Catalog/ShoppingListItem.dart';
import 'package:Bayya/Product/Product.dart';
import 'package:flutter/material.dart';

class ProductSearchResults extends StatefulWidget {
  final List<Product> matchResults;

  const ProductSearchResults({Key key, this.matchResults}) : super(key: key);
  
  _ProductSearchResultsState createState() => _ProductSearchResultsState();
}

class _ProductSearchResultsState extends State<ProductSearchResults> {

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      child: ListView(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        children: widget.matchResults.isNotEmpty
            ? widget.matchResults.map((Product product) {
                return ShoppingListItem(product: product);
              }).toList()
            : [],
      ),
    );
  }
}
