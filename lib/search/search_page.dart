import 'package:bayya/search/product_search_results.dart';
import 'package:bayya/views/catalog/catalog_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<String> _listStr = [];

  void _onSearch(String strValue) {
    setState(() {
      _listStr.clear();

      context.read<CatalogViewModel>().productsMap.forEach((key, value) {
        if (value.name.toLowerCase().contains(strValue.toLowerCase())) {
          _listStr.add(key);
        }
      });
    });
  }

  Widget _searchTextField() {
    return Container(
        alignment: Alignment.topLeft,
        child: TextField(
          textInputAction: TextInputAction.search,
          onChanged: _onSearch,
          onSubmitted: _onSearch,
          decoration: InputDecoration(
              border: InputBorder.none, hintText: 'type something here'),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _searchTextField(),
      ),
      body: ProductSearchResults(matchResults: _listStr),
    );
  }
}
