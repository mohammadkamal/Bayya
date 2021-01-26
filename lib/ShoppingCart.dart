import 'Product.dart';

class ShoppingCart {
  ShoppingCart._privateConstructor();

  static final ShoppingCart _instance = ShoppingCart._privateConstructor();

  static ShoppingCart get instance => _instance;

  Map<int, Product> shoppingCartMap = new Map<int, Product>();

  void addToShoppingCart(Product product) {
    shoppingCartMap[product.id] = product;
  }

  void removeFromShoppingCart(Product product) {
    shoppingCartMap.remove(product.id);
  }

  bool isInShoppingCart(Product product) {
    return shoppingCartMap.containsKey(product.id);
  }
}