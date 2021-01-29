import 'dart:collection';
import 'package:Bayya/Product/Product.dart';
import 'package:flutter/foundation.dart';

class Watchlist extends ChangeNotifier {
  Map<int, Product> _watchlistMap = new Map<int, Product>();

  UnmodifiableMapView<int, Product> get watchlistMap =>
      UnmodifiableMapView(_watchlistMap);

  void setWatchlisted(Product product) {
    _watchlistMap[product.id] = product;
    notifyListeners();
  }

  void unWatchlist(Product product) {
    _watchlistMap.remove(product.id);
    notifyListeners();
  }

  bool getWatchlisted(Product product) {
    return _watchlistMap.containsKey(product.id);
  }
}
