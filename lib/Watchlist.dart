import 'Product.dart';

class Watchlist {
  Watchlist._privateConstructor();

  static final Watchlist _instance = Watchlist._privateConstructor();

  static Watchlist get instance => _instance;

  Map<int, Product> watchlistMap = new Map<int, Product>();

  void setWatchlisted(Product product) {
    watchlistMap[product.id] = product;
  }

  void unWatchlist(Product product) {
    watchlistMap.remove(product.id);
  }

  bool getWatchlisted(Product product) {
    return watchlistMap.containsKey(product.id);
  }
}