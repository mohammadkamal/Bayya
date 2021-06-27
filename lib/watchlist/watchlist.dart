import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class Watchlist extends ChangeNotifier {
  CollectionReference watchlist =
      FirebaseFirestore.instance.collection('watchlist');

  Map<String, bool> _watchlistMap = new Map<String, bool>();
  UnmodifiableMapView<String, bool> get watchlistMap =>
      UnmodifiableMapView(_watchlistMap);

  void setWatchlisted(String key) {
    _watchlistMap[key] = true;
    update();
    notifyListeners();
  }

  void unWatchlist(String key) {
    _watchlistMap.remove(key);
    update();
    notifyListeners();
  }

  bool getWatchlisted(String key) {
    return _watchlistMap.containsKey(key);
  }

  void update() {
    watchlist.doc(FirebaseAuth.instance.currentUser.email).set(_watchlistMap);
  }

  Future<void> fetchData() async {
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot = await watchlist
        .doc(FirebaseAuth.instance.currentUser.email)
        .get();
    documentSnapshot.data().forEach((key, value) {
      _watchlistMap[key] = value;
      notifyListeners();
    });
  }
}
