import 'package:bayya/utils/injector.dart';
import 'package:bayya/views/abstract/base_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class WatchlistViewModel extends BaseViewModel {
  final _watchlistRepository = Injector().watchlistRepository;

  final watchlistMap = <String, bool>{};

  Future<void> fetchWatchlist() async {
    if (FirebaseAuth.instance.currentUser != null) {
      await _watchlistRepository.fetchWatchlist().then((value) {
        watchlistMap.clear();
        watchlistMap.addAll(value);
        notifyListeners();
      });
    }
  }

  Future<void> addToWatchlist(String key) async {
    await _watchlistRepository.addProductToWatchlist(key).then((value) {
      watchlistMap.clear();
      watchlistMap.addAll(value);
      notifyListeners();
    });
  }

  Future<void> removeFromWatchlist(String key) async {
    await _watchlistRepository.removeProductFromWatchlist(key).then((value) {
      watchlistMap.clear();
      watchlistMap.addAll(value);
      notifyListeners();
    });
  }

  bool isInWatchlist(String key) {
    return watchlistMap.containsKey(key);
  }
}
