import 'package:bayya/product/product.dart';
import 'package:bayya/catalog/catalog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditProduct extends StatefulWidget {
  final String productKey;

  const EditProduct({Key key, this.productKey}) : super(key: key);
  @override
  _EditProductState createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  Product _product;

  void initState() {
    super.initState();
    _product = Provider.of<Catalog>(context).productsCatalog[widget.productKey];
  }

  Widget _editProductName()
  {
    return ListTile(
      title: Text(_product.name),
      trailing: Icon(Icons.edit),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_product.name),
      ),
    );
  }
}
