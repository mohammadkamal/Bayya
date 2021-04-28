import 'package:bayya/cart/shopping_cart.dart';
import 'package:bayya/catalog/catalog.dart';
import 'package:bayya/catalog/shopping_list.dart';
import 'package:bayya/user/vendors_list.dart';
import 'package:bayya/watchlist/watchlist.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => ShoppingCart()),
    ChangeNotifierProvider(
      create: (context) => Watchlist(),
    ),
    ChangeNotifierProvider(create: (context) => Catalog()),
    ChangeNotifierProvider(create: (context)=>VendorsList())
  ], child: BayyaApplication()));
}

class BayyaApplication extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print('Error occured');
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            title: 'Bayya',
            home: ShoppingList(),
          );
        }

        return MaterialApp(
          title: 'Bayya',
          home: Scaffold(
            appBar: AppBar(
              title: Text('Bayya'),
            ),
            body: Container(
              child: Column(
                children: [
                  Row(
                    children: [Icon(Icons.wifi_off)],
                  ),
                  Row(
                    children: [Text('No internet connection')],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
