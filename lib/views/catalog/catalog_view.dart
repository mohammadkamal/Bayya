import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../enums/product_list_type.dart';
import '../../models/product.dart';
import '../../search/search_page.dart';
import '../../side_drawer/side_bar.dart';
import '../widgets/mixed_widgets/shopping_cart_upper_icon.dart';
import '../widgets/styles/tween_animation_route.dart';
import 'catalog_grid_item_view.dart';
import 'catalog_list_item_view.dart';
import 'catalog_viewmodel.dart';

class CatalogView extends StatefulWidget {
  const CatalogView({Key key}) : super(key: key);

  @override
  _CatalogViewState createState() => _CatalogViewState();
}

class _CatalogViewState extends State<CatalogView> {
  ProductListType _listTypeEnum = ProductListType.list;
  CatalogViewModel catalogViewModel;

  @override
  void initState() {
    catalogViewModel = CatalogViewModel();

    catalogViewModel.fetchProducts();
    //context.read<WatchlistViewModel>().fetchWatchlist();
    super.initState();
  }

  Future<void> _onRefresh() async {
    catalogViewModel.fetchProducts();
  }

  Widget _upperSearchIcon() {
    return IconButton(
        icon: const Icon(Icons.search),
        onPressed: () {
          Navigator.push(
              context, TweenAnimationRoute().playAnimation(const SearchPage()));
        });
  }

  Widget _gridListIcons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          onPressed: () => setState(() {
            _listTypeEnum = ProductListType.grid;
          }),
          icon: Icon(
            Icons.grid_on,
            color: _listTypeEnum == ProductListType.grid
                ? Colors.blue
                : Colors.black,
          ),
        ),
        IconButton(
            onPressed: () => setState(() {
                  _listTypeEnum = ProductListType.list;
                }),
            icon: Icon(CupertinoIcons.text_alignleft,
                color: _listTypeEnum == ProductListType.list
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
              title: const Text(
                'Discover',
              ),
              actions: <Widget>[
                _upperSearchIcon(),
                const ShoppingCartUpperIcon()
              ],
            ),
            drawer: const AppSideBar(),
            body: RefreshIndicator(
                onRefresh: _onRefresh,
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 40),
                      child: _listTypeEnum == ProductListType.grid
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
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        itemCount: products.keys.length,
        itemBuilder: (context, index) {
          return CatalogGridItem(
            productId: products.keys.elementAt(index),
            product: products.values.elementAt(index),
          );
        },
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
      );
    } else {
      return Container(
        alignment: Alignment.center,
        child: const CircularProgressIndicator(),
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
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          itemCount: products.keys.length,
          itemBuilder: (context, index) {
            return CatalogListItem(
                productId: products.keys.elementAt(index),
                product: products.values.elementAt(index));
          });
    } else {
      return Container(
        alignment: Alignment.center,
        child: const CircularProgressIndicator(),
      );
    }
  }
}
