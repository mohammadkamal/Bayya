abstract class CartRepository {
  Future<Map<String, int>> addProductToShoppingCart(String key);
  Future<Map<String, int>> removeProductFromShoppingCart(String key);
  Future<Map<String, int>> fetchShoppingCart();
  Future<Map<String, int>> updateQuantity(String key, int value);
}