import 'dart:developer';

import 'package:bayya/models/product.dart';
import 'package:bayya/search/search_page.dart';
import 'package:bayya/side_drawer/side_bar.dart';
import 'package:bayya/views/widgets/mixed_widgets/shopping_cart_upper_icon.dart';
import 'package:bayya/views/widgets/styles/tween_animation_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'catalog_grid_item_view.dart';
import 'catalog_list_item_view.dart';
import 'catalog_viewmodel.dart';

enum ListTypeEnum { List, Grid }

class CatalogView extends StatefulWidget {
  @override
  _CatalogViewState createState() => _CatalogViewState();
}

class _CatalogViewState extends State<CatalogView> {
  ListTypeEnum _listTypeEnum = ListTypeEnum.List;
  CatalogViewModel catalogViewModel;

  void initState() {
    catalogViewModel = CatalogViewModel();
    catalogViewModel.addListener(() {
      log('listener');
    });
    catalogViewModel.fetchProducts();
    //context.read<WatchlistViewModel>().fetchWatchlist();
    super.initState();
  }

  Future<void> _onRefresh() async {
    catalogViewModel.fetchProducts();
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
            _listTypeEnum = ListTypeEnum.Grid;
          }),
          icon: Icon(
            Icons.grid_on,
            color:
                _listTypeEnum == ListTypeEnum.Grid ? Colors.blue : Colors.black,
          ),
        ),
        IconButton(
            onPressed: () => setState(() {
                  _listTypeEnum = ListTypeEnum.List;
                }),
            icon: Icon(CupertinoIcons.text_alignleft,
                color: _listTypeEnum == ListTypeEnum.List
                    ? Colors.blue
                    : Colors.black))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
        value: catalogViewModel,
        builder: (buildContext, childWidget) => Scaffold(
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
                      child: _listTypeEnum == ListTypeEnum.Grid
                          ? _ProductsGridBuilder(
                              products: catalogViewModel.productsMap,
                            )
                          : _ProductsListBuilder(
                              products: catalogViewModel.productsMap,
                            ),
                    ),
                    _gridListIcons(),
                  ],
                ))));
  }
}

class _ProductsGridBuilder extends StatelessWidget {
  final Map<String, Product> products;

  const _ProductsGridBuilder({Key key, this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (products.isNotEmpty) {
      return GridView.builder(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        itemCount: products.keys.length,
        itemBuilder: (context, index) {
          return CatalogGridItem(
            productId: products.keys.elementAt(index),
            product: products.values.elementAt(index),
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
}

class _ProductsListBuilder extends StatelessWidget {
  final Map<String, Product> products;

  const _ProductsListBuilder({Key key, this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (products.isNotEmpty) {
      return ListView.builder(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          itemCount: products.keys.length,
          itemBuilder: (context, index) {
            return CatalogListItem(
                productId: products.keys.elementAt(index),
                product: products.values.elementAt(index));
          });
    } else {
      return Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      );
    }
  }
}
