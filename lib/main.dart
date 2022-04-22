import 'package:bayya/user/customer_database.dart';
import 'package:bayya/views/cart/shopping_cart_viewmodel.dart';
import 'package:bayya/views/catalog/catalog_view.dart';
import 'package:bayya/views/catalog/catalog_viewmodel.dart';
import 'package:bayya/views/watchlist/watchlist_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'views/review/reviews_database.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => CatalogViewModel()),
    ChangeNotifierProvider(create: (context) => ShoppingCartViewModel()),
    ChangeNotifierProvider(
      create: (context) => WatchlistViewModel(),
    ),
    ChangeNotifierProvider(create: (context) => CustomerDatabase()),
    ChangeNotifierProvider(create: (context) => ReviewsDatabase()),
  ], child: const BayyaApplication()));
}

class BayyaApplication extends StatefulWidget {
  const BayyaApplication({Key key}) : super(key: key);

  @override
  _BayyaApplicationState createState() => _BayyaApplicationState();
}

class _BayyaApplicationState extends State<BayyaApplication> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  AppBarTheme _appBarTheme() {
    return const AppBarTheme(
        //backwardsCompatibility: false,
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
          //print('Error occured');
          return Text(snapshot.error);
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            title: 'Bayya',
            theme: _mainTheme(),
            home: const CatalogView(),
          );
        }

        return Container(
          child: const CircularProgressIndicator(),
          alignment: Alignment.center,
        );
      },
    );
  }
}
