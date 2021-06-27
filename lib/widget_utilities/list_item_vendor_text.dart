import 'package:bayya/catalog/catalog.dart';
import 'package:bayya/user/vendors_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListItemVendorText extends StatefulWidget {
  final String productId;

  const ListItemVendorText({Key key, @required this.productId})
      : super(key: key);

  @override
  _ListItemVendorTextState createState() => _ListItemVendorTextState();
}

class _ListItemVendorTextState extends State<ListItemVendorText> {
  Widget _vendorText() {
    return FutureBuilder(
        future: Provider.of<VendorsList>(context).getVendorNameByUid(
            Provider.of<Catalog>(context)
                .productsCatalog[widget.productId]
                .vendor),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Text(snapshot.data,
                softWrap: true, textAlign: TextAlign.left);
          } else {
            return Text("Vendor isn't provieded");
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 4),
      child: _vendorText(),
    );
  }
}
