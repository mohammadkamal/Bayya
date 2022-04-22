import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class ProductViewModel {
  void onAddToCartTap(
      {bool isInCart,
      String productId,
      @required Function() notSignedIn,
      @required VoidCallback addToCartFunction,
      @required VoidCallback removeFromCartFunction}) {
    if (FirebaseAuth.instance.currentUser != null) {
      if (isInCart) {
        addToCartFunction();
      } else {
        removeFromCartFunction();
      }
    } else {
      notSignedIn();
    }
  }

  void onWatchlistTap(
      {bool isWatchlisted,
      String productId,
      @required Function() notSignedIn,
      @required VoidCallback watchFunction,
      @required VoidCallback unwatchFunction}) {
    if (FirebaseAuth.instance.currentUser != null) {
      if (isWatchlisted) {
        watchFunction();
      } else {
        unwatchFunction();
      }
    } else {
      notSignedIn();
    }
  }
}
