abstract class WatchlistRepository {
  Future<Map<String, bool>> addProductToWatchlist(String key);
  Future<Map<String, bool>> removeProductFromWatchlist(String key);
  Future<Map<String, bool>> fetchWatchlist();
}
