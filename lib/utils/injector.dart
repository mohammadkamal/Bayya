import 'package:bayya/repositories/abstract/cart_repository.dart';
import 'package:bayya/repositories/abstract/catalog_repository.dart';
import 'package:bayya/repositories/abstract/watchlist_repository.dart';
import 'package:bayya/repositories/implementation/cart_repository_implementation.dart';
import 'package:bayya/repositories/implementation/catalog_repository_implementation.dart';
import 'package:bayya/repositories/implementation/watchlist_repository_implementation.dart';

class Injector {
  static final _singleton = Injector._internal();

  factory Injector() => _singleton;

  Injector._internal();

  static final _flyweightMap = <String, dynamic>{};

  CatalogRepository get catalogRepository {
    var catalogRepository = _flyweightMap['catalogRepository'];
    if (catalogRepository == null) {
      catalogRepository = CatalogRepositoryImplementation();
      _flyweightMap.addAll({'catalogRepository': catalogRepository});
    }
    return catalogRepository;
  }

  CartRepository get cartRepository {
    var cartRepository = _flyweightMap['cartRepository'];
    if (cartRepository == null) {
      cartRepository = CartRepositoryImplementation();
      _flyweightMap.addAll({'cartRepository': cartRepository});
    }
    return cartRepository;
  }

  WatchlistRepository get watchlistRepository {
    var watchlistRepository = _flyweightMap['watchlistRepository'];
    if (watchlistRepository == null) {
      watchlistRepository = WatchlistRepositoryImplementation();
      _flyweightMap.addAll({'watchlistRepository': watchlistRepository});
    }
    return watchlistRepository;
  }

  void dispose() {
    _flyweightMap.clear();
  }
}
