import 'package:flutter/material.dart';

import '../widgets/styles/box_decorations.dart';

class ProductViewVendor extends StatefulWidget {
  final String vendorUid;

  const ProductViewVendor({Key key, this.vendorUid}) : super(key: key);
  @override
  _ProductViewVendorState createState() => _ProductViewVendorState();
}

class _ProductViewVendorState extends State<ProductViewVendor> {
  Widget _vendorText() {
    return FutureBuilder(
        future: Future.delayed(const Duration(seconds: 2), () => 'vendor'),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Text(snapshot.data,
                style: const TextStyle(fontWeight: FontWeight.bold));
          } else {
            return const Text("Vendor isn't provieded");
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 2, top: 2),
      decoration: proudctCardDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Sold by:',
            style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
          ),
          _vendorText()
        ],
      ),
    );
  }
}
