import 'package:bayya/cart/shopping_cart.dart';
import 'package:bayya/cart/shopping_cart_upper_icon.dart';
import 'package:bayya/catalog/catalog.dart';
import 'package:bayya/catalog/shopping_list_item.dart';
import 'package:bayya/search/search_page.dart';
import 'package:bayya/side_drawer/side_bar.dart';
import 'package:bayya/watchlist/watchlist.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShoppingList extends StatefulWidget {
  @override
  _ShoppingListState createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {

  void initState()
  {
    super.initState();
    context.read<Catalog>().fetchData();
    context.read<ShoppingCart>().fetchData();
    context.read<Watchlist>().fetchData();
  }

  Widget _upperSearchIcon(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.search, color: Colors.white),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => SearchPage()));
        });
  }

  Widget _productsList() {
    return ListView(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        children: Provider.of<Catalog>(context).productsCatalog.isNotEmpty
            ? Provider.of<Catalog>(context).productsCatalog.keys.map((e) {
                return ShoppingListItem(productId: e);
              }).toList()
            : [LinearProgressIndicator()]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Bayya Shopping List',
          ),
          actions: <Widget>[_upperSearchIcon(context), ShoppingCartUpperIcon()],
        ),
        drawer: AppSideBar(),
        body: Container(color: Colors.grey, child: _productsList()));
  }
}
