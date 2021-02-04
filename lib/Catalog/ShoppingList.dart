import 'package:Bayya/Cart/ShoppingCartUpperIcon.dart';
import 'package:Bayya/Catalog/Catalog.dart';
import 'package:Bayya/Catalog/ShoppingListItem.dart';
import 'package:Bayya/Product/Product.dart';
import 'package:Bayya/Search/SearchPage.dart';
import 'package:Bayya/SideDrawer/SideBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShoppingList extends StatefulWidget {
  @override
  _ShoppingListState createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {
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
      children: Provider.of<Catalog>(context).productsList.isNotEmpty
          ? Provider.of<Catalog>(context).productsList.map((Product product) {
              return ShoppingListItem(product: product);
            }).toList()
          : [],
    );
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
