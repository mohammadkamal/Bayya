import 'package:bayya/cart/shopping_cart.dart';
import 'package:bayya/catalog/catalog.dart';
import 'package:bayya/catalog/shopping_list.dart';
import 'package:bayya/review/reviews_database.dart';
import 'package:bayya/user/customer_database.dart';
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
    ChangeNotifierProvider(create: (context) => CustomerDatabase()),
    ChangeNotifierProvider(create: (context) => ReviewsDatabase()),
    ChangeNotifierProvider(create: (context) => Catalog()),
    ChangeNotifierProvider(create: (context) => VendorsList()),
  ], child: BayyaApplication()));
}

class BayyaApplication extends StatefulWidget {
  @override
  _BayyaApplicationState createState() => _BayyaApplicationState();
}

class _BayyaApplicationState extends State<BayyaApplication> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  AppBarTheme _appBarTheme() {
    return AppBarTheme(
        backwardsCompatibility: false,
        backgroundColor: Colors.white,
        titleTextStyle: TextStyle(color: Colors.black, fontSize: 20),
        actionsIconTheme: IconThemeData(color: Colors.black87),
        iconTheme: IconThemeData(color: Colors.black87),
        centerTitle: true,
        elevation: 0);
  }

  ThemeData _mainTheme() {
    return ThemeData(appBarTheme: _appBarTheme());
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print('Error occured');
          return Container(
            child: Text(snapshot.error),
          );
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            title: 'Bayya',
            theme: _mainTheme(),
            home: ShoppingList(),
          );
        }

        return Container(
          child: CircularProgressIndicator(),
          alignment: Alignment.center,
        );
      },
    );
  }
}
