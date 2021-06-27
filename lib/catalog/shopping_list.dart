import 'package:bayya/cart/shopping_cart.dart';
import 'package:bayya/cart/shopping_cart_upper_icon.dart';
import 'package:bayya/catalog/catalog.dart';
import 'package:bayya/catalog/shopping_grid_item.dart';
import 'package:bayya/catalog/shopping_list_item.dart';
import 'package:bayya/search/search_page.dart';
import 'package:bayya/side_drawer/side_bar.dart';
import 'package:bayya/watchlist/watchlist.dart';
import 'package:bayya/widget_utilities/tween_animation_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum ListTypeEnum { list, grid }

class ShoppingList extends StatefulWidget {
  @override
  _ShoppingListState createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {
  ListTypeEnum _listTypeEnum = ListTypeEnum.list;
  void initState() {
    super.initState();
    context.read<Catalog>().fetchData();
    context.read<ShoppingCart>().fetchData();
    context.read<Watchlist>().fetchData();
  }

  Future<void> _onRefresh() async {
    await context.read<Catalog>().fetchData();
  }

  Widget _upperSearchIcon() {
    return IconButton(
        icon: Icon(Icons.search),
        onPressed: () {
          Navigator.push(
              context, TweenAnimationRoute().playAnimation(SearchPage()));
        });
  }

  Widget _gridListIcons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          onPressed: () => setState(() {
            _listTypeEnum = ListTypeEnum.grid;
          }),
          icon: Icon(
            Icons.grid_on,
            color:
                _listTypeEnum == ListTypeEnum.grid ? Colors.blue : Colors.black,
          ),
        ),
        IconButton(
            onPressed: () => setState(() {
                  _listTypeEnum = ListTypeEnum.list;
                }),
            icon: Icon(CupertinoIcons.text_alignleft,
                color: _listTypeEnum == ListTypeEnum.list
                    ? Colors.blue
                    : Colors.black))
      ],
    );
  }

  Widget _productsGrid() {
    if (Provider.of<Catalog>(context).productsCatalog.isNotEmpty) {
      return GridView.builder(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        itemCount: Provider.of<Catalog>(context).productsCatalog.keys.length,
        itemBuilder: (context, index) {
          return ShoppingGridItem(
            productId: Provider.of<Catalog>(context)
                .productsCatalog
                .keys
                .elementAt(index),
          );
        },
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
      );
    } else {
      return Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      );
    }
  }

  Widget _productsList() {
    if (Provider.of<Catalog>(context).productsCatalog.isNotEmpty) {
      return ListView.builder(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          itemCount: Provider.of<Catalog>(context).productsCatalog.keys.length,
          itemBuilder: (context, index) {
            return ShoppingListItem(
              productId: Provider.of<Catalog>(context)
                  .productsCatalog
                  .keys
                  .elementAt(index),
            );
          });
    } else {
      return Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Discover',
        ),
        actions: <Widget>[_upperSearchIcon(), ShoppingCartUpperIcon()],
      ),
      drawer: AppSideBar(),
      body: RefreshIndicator(
          onRefresh: _onRefresh,
          child: Stack(
            children: [
              Container(
                margin: EdgeInsets.only(top: 40),
                child: _listTypeEnum == ListTypeEnum.grid
                    ? _productsGrid()
                    : _productsList(),
              ),
              _gridListIcons(),
            ],
          )),
    );
  }
}
