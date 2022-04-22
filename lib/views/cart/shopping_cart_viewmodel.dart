import 'package:bayya/utils/injector.dart';
import 'package:bayya/views/abstract/base_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ShoppingCartViewModel extends BaseViewModel {
  final _cartRepository = Injector().cartRepository;

  final shoppingCartMap = <String, int>{};

  Future<void> fetchShoppingCart() async {
    if (FirebaseAuth.instance.currentUser != null) {
      await _cartRepository.fetchShoppingCart().then((value) {
        shoppingCartMap.clear();
        shoppingCartMap.addAll(value);
        notifyListeners();
      });
    }
  }

  Future<void> addToShoppingCart(String key) async {
    await _cartRepository.addProductToShoppingCart(key).then((value) {
      shoppingCartMap.clear();
      shoppingCartMap.addAll(value);
      notifyListeners();
    });
  }

  Future<void> removeFromShoppingCart(String key) async {
    await _cartRepository.removeProductFromShoppingCart(key).then((value) {
      shoppingCartMap.clear();
      shoppingCartMap.addAll(value);
      notifyListeners();
    });
  }

  bool isInShoppingCart(String key) {
    return shoppingCartMap.containsKey(key);
  }

  Future<void> increment(String key) async {
    await _cartRepository
        .updateQuantity(key, shoppingCartMap[key]++)
        .then((value) {
      shoppingCartMap.clear();
      shoppingCartMap.addAll(value);
      notifyListeners();
    });
  }

  Future<void> decrement(String key) async {
    if (shoppingCartMap[key] >= 2) {
      await _cartRepository
          .updateQuantity(key, shoppingCartMap[key]--)
          .then((value) {
        shoppingCartMap.clear();
        shoppingCartMap.addAll(value);
        notifyListeners();
      });
    } else {
      return;
    }
  }

  int getQuantity(String key) {
    return shoppingCartMap[key];
  }
}
