import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class Watchlist extends ChangeNotifier {
  CollectionReference watchlist =
      FirebaseFirestore.instance.collection('watchlist');

  List<String> _watchlistList = new List<String>();
  UnmodifiableListView<String> get watchlistList =>
      UnmodifiableListView(_watchlistList);

  void setWatchlisted(String key) {
    _watchlistList.add(key);
    update();
    notifyListeners();
  }

  void unWatchlist(String key) {
    _watchlistList.remove(key);
    update();
    notifyListeners();
  }

  bool getWatchlisted(String key) {
    return _watchlistList.contains(key);
  }

  void update() {
    watchlist
        .doc(FirebaseAuth.instance.currentUser.email)
        .set({"watchArr": _watchlistList});
  }

  Future<void> fetchData() async {
    await watchlist
        .doc(FirebaseAuth.instance.currentUser.email)
        .get()
        .then((value) {
      List.from(value.data()["watchArr"]).forEach((element) {
        _watchlistList.add(element);
      });
    });
    notifyListeners();
  }
}
