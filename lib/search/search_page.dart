import 'package:bayya/catalog/catalog.dart';
import 'package:bayya/search/product_search_results.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool typing = true;
  final textController = TextEditingController();
  List<String> _listStr = [];

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  Widget _searchTextField() {
    return TextField(
      decoration: InputDecoration(
          border: InputBorder.none, hintText: 'type something here'),
      controller: textController,
    );
  }

  Widget _searchText() {
    return Container(
      alignment: Alignment.topLeft,
      child: _searchTextField(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: typing ? _searchText() : Text('Search'),
        actions: [
          IconButton(
            icon: Icon(typing ? Icons.done : Icons.search),
            onPressed: () {
              setState(() {
                typing = !typing;
                if(_listStr.isNotEmpty)
                {
                  _listStr.clear();
                }
                context.read<Catalog>().productsCatalog.forEach((key, value) {
                  if (value.name
                      .toLowerCase()
                      .contains(this.textController.text.toLowerCase())) {
                    _listStr.add(key);
                  }
                });
              });
            },
          ),
        ],
      ),
      body: ProductSearchResults(matchResults: _listStr),
    );
  }
}
