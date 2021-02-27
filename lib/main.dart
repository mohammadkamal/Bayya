import 'package:Bayya/Cart/ShoppingCart.dart';
import 'package:Bayya/Catalog/Catalog.dart';
import 'package:Bayya/Catalog/ShoppingList.dart';
import 'package:Bayya/Watchlist/Watchlist.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
    ChangeNotifierProvider(create: (context) => Catalog())
  ], child: BayyaApplication()));
}

class BayyaApplication extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  Future<void> _loginAnon() async {
    if (FirebaseAuth.instance.currentUser == null) {
      await FirebaseAuth.instance.signInAnonymously();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print('Error occured');
        }

        if (snapshot.connectionState == ConnectionState.done) {
          _loginAnon();
          context.read<Catalog>().fetchData();
          context.read<ShoppingCart>().fetchData();
          context.read<Watchlist>().fetchData();
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
