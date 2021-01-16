import 'dart:ffi';
import 'package:flutter/material.dart';

class Product {
  //Constructor
  Product(
      {this.name,
      this.shortDescription,
      this.longDescription,
      this.vendor,
      this.price,
      this.category});

  //Fields & Variables
  final String name, shortDescription, longDescription, vendor;
  final double price;
  Float ratings;
  int quantity;
  ProductCategory category;
}

enum ProductCategory { clothes, elctronics, food }

typedef void CartChangedCallback(Product product, bool inCart);

class ShoppingListItem extends StatelessWidget {
  ShoppingListItem({this.product, this.inCart, this.onCartChanged})
      : super(key: ObjectKey(product));

  final Product product;
  final bool inCart;
  final CartChangedCallback onCartChanged;

  Color _getColor(BuildContext context) {
    return inCart ? Colors.black54 : Theme.of(context).primaryColor;
  }

  void _viewProduct(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute<void>(builder: (BuildContext context) {
      return Scaffold(
          appBar: AppBar(
            title: Text(product.name),
          ),
          body: Column(
            children: [titleSection(), descriptionSection(), buttonSection()],
          ));
    }));
  }

  Widget titleSection() {
    return Container(
        padding: const EdgeInsets.all(32),
        child: Row(
          children: [
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    product.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  product.shortDescription,
                  style: TextStyle(color: Colors.grey[500]),
                )
              ],
            ))
          ],
        ));
  }

  Widget descriptionSection() {
    return Container(
      padding: const EdgeInsets.all(32),
      child: Text(
        product.longDescription,
        softWrap: true,
      ),
    );
  }

  Column _buttonColumn(IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon),
        Container(
            margin: const EdgeInsets.only(top: 8),
            child: Text(
              label,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
            ))
      ],
    );
  }

  Widget buttonSection() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buttonColumn(Icons.favorite_border, 'Favourite'),
          _buttonColumn(
              Icons.add_shopping_cart_outlined, 'Add to Shopping Cart')
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        _viewProduct(context);
      },
      leading: CircleAvatar(
        backgroundColor: _getColor(context),
        child: Text(product.name[0]),
      ),
      title: Text(
        product.name,
      ),
      subtitle: Text(product.shortDescription +
          '\n' +
          product.category.toString().split('.').last),
      trailing: Text(product.price.toString() + ' EGP'),
    );
  }
}
