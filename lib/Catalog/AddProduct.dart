import 'package:flutter/material.dart';

class AddProduct extends StatefulWidget {
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _productNameCtrl = TextEditingController();
  final TextEditingController _shortDescCtrl = TextEditingController();
  final TextEditingController _longDescCtrl = TextEditingController();

  Widget _productName() {
    return Padding(
      padding: const EdgeInsets.only(right: 10, left: 10),
      child: TextFormField(
        controller: _productNameCtrl,
        decoration: InputDecoration(labelText: 'Enter product name:'),
        validator: (value) {
          if (value.isEmpty) {
            return 'This field is required';
          }
          return null;
        },
      ),
    );
  }

  Widget _image()
  {
    
  }

  Widget _shortDescription()
  {
    return Padding(
      padding: const EdgeInsets.only(right: 10, left: 10),
      child: TextFormField(
        controller: _shortDescCtrl,
        decoration: InputDecoration(labelText: 'Enter short description:'),
        validator: (value) {
          if (value.isEmpty) {
            return 'This field is required';
          }
          return null;
        },
      ),
    );
  }

  Widget _longDescription()
  {
    return Padding(
      padding: const EdgeInsets.only(right: 10, left: 10),
      child: TextFormField(
        controller: _longDescCtrl,
        decoration: InputDecoration(labelText: 'Enter long description:'),
        validator: (value) {
          if (value.isEmpty) {
            return 'This field is required';
          }
          return null;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      title: Text('Add a new product'),
    ));
  }
}
