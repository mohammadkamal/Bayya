import 'package:bayya/cart/shopping_cart.dart';
import 'package:bayya/widget_utilities/add_to_cart_button_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'cloud_firestore_mock.dart';

void main() {
  setupCloudFirestoreMocks();
  setUpAll(() async {
    //WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    await FirebaseAuth.instance.signInWithEmailAndPassword(email: 'admin@bayya.com', password: 'adminbayya');
  });

  testWidgets('MyWidget has a title and message', (tester) async {
    ShoppingCart _cart;
    await tester.pumpWidget(Provider<ShoppingCart>.value(
        value: _cart,
        child: AddToCartButtonList(productId: 'Xbyh4cRqYTCJhsGUjTNv')));
    await _cart.fetchData();

    final labelFinder = find.text('Add to cart');
    final iconFinder = find.byIcon(Icons.add_shopping_cart);

    expect(labelFinder, findsOneWidget);
    expect(iconFinder, findsOneWidget);
  });
}
