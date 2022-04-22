import 'package:bayya/repositories/abstract/watchlist_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class WatchlistRepositoryImplementation implements WatchlistRepository {
  CollectionReference get _watchlistCollection =>
      FirebaseFirestore.instance.collection('watchlist');

  @override
  Future<Map<String, bool>> addProductToWatchlist(String key) async {
    var _watchlistMap = await fetchWatchlist();
    _watchlistMap[key] = true;
    _updateWatchlistMap(_watchlistMap);
    return _watchlistMap;
  }

  @override
  Future<Map<String, bool>> fetchWatchlist() async {
    var _watchlistData = <String, bool>{};
    await _watchlistCollection
        .doc(FirebaseAuth.instance.currentUser.uid)
        .get()
        .then((value) => _watchlistData = Map<String, bool>.from(value.data()));

    return _watchlistData;
  }

  @override
  Future<Map<String, bool>> removeProductFromWatchlist(String key) async {
    var _watchlistMap = await fetchWatchlist();
    _watchlistMap.remove(key);
    _updateWatchlistMap(_watchlistMap);
    return _watchlistMap;
  }

  Future<void> _updateWatchlistMap(Map<String, bool> newWatchlistMap) async {
    await _watchlistCollection
        .doc(FirebaseAuth.instance.currentUser.uid)
        .set(newWatchlistMap);
  }
}
