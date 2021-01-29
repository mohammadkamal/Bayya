import 'package:Bayya/Catalog/Catalog.dart';
import 'package:Bayya/Product/Product.dart';
import 'package:Bayya/Search/ProductSearchResults.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool typing = false;
  final textController = TextEditingController();
  List<Product> _list = new List<Product>();

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  Widget _searchTextField() {
    return TextField(
      decoration: InputDecoration(border: InputBorder.none, hintText: 'type something here'),
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
                if (_list.isNotEmpty) {
                  _list.clear();
                }
                context.read<Catalog>().productsList.forEach((element) {
                  if (element.name.contains(this.textController.text)) {
                    _list.add(element);
                  }
                });
              });
            },
          ),
        ],
      ),
      body: ProductSearchResults(matchResults: _list),
    );
  }
}
