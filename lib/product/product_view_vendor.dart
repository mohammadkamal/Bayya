import 'package:bayya/catalog/catalog.dart';
import 'package:bayya/product/product_card_decoration.dart';
import 'package:bayya/user/vendors_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductViewVendor extends StatefulWidget {
  final String productId;

  const ProductViewVendor({Key key, this.productId}) : super(key: key);
  @override
  _ProductViewVendorState createState() => _ProductViewVendorState();
}

class _ProductViewVendorState extends State<ProductViewVendor> {
  Widget _vendorText() {
    return FutureBuilder(
        future: Provider.of<VendorsList>(context).getVendorNameByUid(
            Provider.of<Catalog>(context)
                .productsCatalog[widget.productId]
                .vendor),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Text(snapshot.data,
                style: TextStyle(fontWeight: FontWeight.bold));
          } else {
            return Text("Vendor isn't provieded");
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 2, top: 2),
      decoration: proudctCardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Sold by:',
            style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
          ),
          _vendorText()
        ],
      ),
    );
  }
}
