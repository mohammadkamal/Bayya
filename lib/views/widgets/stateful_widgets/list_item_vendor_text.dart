import 'package:bayya/models/vendor_account.dart';
import 'package:flutter/material.dart';

class ListItemVendorText extends StatelessWidget {
  final VendorAccount vendorAccount;

  const ListItemVendorText({Key key, this.vendorAccount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(bottom: 4),
        child: vendorAccount == null
            ? const Text("Vendor isn't provided",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.red))
            : Text(vendorAccount.displayName ?? vendorAccount.email,
                style: const TextStyle(fontWeight: FontWeight.bold)));
  }
}
