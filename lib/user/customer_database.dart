import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CustomerDatabase extends ChangeNotifier {
  CollectionReference customersCollection =
      FirebaseFirestore.instance.collection('customers');

  Future<String> getAccountDisplayName(String uid) async {
    DocumentSnapshot<Map<String, dynamic>> data =
        await customersCollection.doc(uid).get();
    return data.data()['displayName'];
  }

  Future<String> getAccountEmail(String uid) async {
    DocumentSnapshot<Map<String, dynamic>> data =
        await customersCollection.doc(uid).get();
    return data.data()['email'];
  }

  /// To get account display name and email as a map
  Future<Map<String, dynamic>> getAccountNameEmail(String uid) async {
    DocumentSnapshot<Map<String, dynamic>> data =
        await customersCollection.doc(uid).get();
    return data.data();
  }
}
