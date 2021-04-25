import 'dart:collection';

import 'package:Bayya/User/VendorAccount.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class VendorsList extends ChangeNotifier {
  Map<String, VendorAccount> _vendorsMap = new Map<String, VendorAccount>();
  UnmodifiableMapView<String, VendorAccount> get vendorsMap =>
      UnmodifiableMapView(_vendorsMap);

  CollectionReference vendorDatabase =
      FirebaseFirestore.instance.collection('vendors');

  //void addVendor() {}

  Future<bool> isVendorAccount(String uid) async {
    DocumentSnapshot _snapshot = await vendorDatabase.doc(uid).get();
    return _snapshot.exists;
  }

  Future<String> getVendorNameByUid(String uid) async {
    DocumentSnapshot _snapshot = await vendorDatabase.doc(uid).get();
    VendorAccount _account = VendorAccount.fromJson(_snapshot.data());
    return _account.displayName;
  }

  void updateDisplayName(String uid, String newDisplayName) {
    FirebaseFirestore.instance.runTransaction((transaction) async {
      await vendorDatabase.doc(uid).update({'displayName': newDisplayName});
    });
  }
}
