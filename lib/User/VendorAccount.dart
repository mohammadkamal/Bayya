import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class VendorAccount extends StatelessWidget {
  final String email;
  final String displayName;

  VendorAccount(this.email, this.displayName);

  @override
  Widget build(BuildContext context) {
    CollectionReference vendors =
        FirebaseFirestore.instance.collection('vendors');

    Future<void> addVendor() {
      return vendors
          .add({'email': email, 'displayName': displayName})
          .then((value) => print("Vendor Added"))
          .catchError((error) => print("Failed to add vendor: $error"));
    }

    return ListTile(
      onTap: addVendor,
      leading: Icon(Icons.store),
      title: Text("Turn into vendor account"),
    );
  }
}
