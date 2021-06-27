import 'dart:collection';
import 'package:bayya/product/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class Catalog extends ChangeNotifier {
  CollectionReference catalogStore =
      FirebaseFirestore.instance.collection('Catalog');

  Map<String, Product> _productsCatalog = new Map<String, Product>();
  UnmodifiableMapView<String, Product> get productsCatalog => UnmodifiableMapView(_productsCatalog);

  Future<void> fetchData() async {
    QuerySnapshot querySnapshot = await catalogStore.get();
    var list = querySnapshot.docs;
    list.forEach((element) {
      _productsCatalog[element.id] = Product.fromJson(element.data());
      notifyListeners();
    });
  }
  
  //For trying
  Future<void> onDataChange()
  async {
    QuerySnapshot querySnapshot = await catalogStore.get();
    querySnapshot.docChanges.forEach((element) { 
    });
  }
}
