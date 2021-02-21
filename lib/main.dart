import 'package:Bayya/Cart/ShoppingCart.dart';
import 'package:Bayya/Catalog/Catalog.dart';
import 'package:Bayya/Catalog/ShoppingList.dart';
import 'package:Bayya/Product/Product.dart';
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
    Product pr1 = new Product(
        id: 0,
        name: 'Blue jeans',
        shortDescription: 'Blue jeans for men',
        longDescription: 'Blue jeans for men available at all sizes',
        category: ProductCategory.clothes,
        price: 50,
        image: Image.asset('assets/blue jeans.jpg'),
        vendor: 'Bayya');
    if(!context.read<Catalog>().productsCatalog.containsValue(pr1))
    {
      context.read<Catalog>().addProduct(pr1);
    }
    context.read<Catalog>().addProduct(Product(
        id: 1,
        name: 'LED TV',
        shortDescription: 'Television with LED screen',
        longDescription: '20-inch monitor with HD quality display',
        category: ProductCategory.elctronics,
        price: 1100,
        image: Image.asset('assets/20-inch-samsung-led-tv.jpg'),
        vendor: 'Bayya'));
    context.read<Catalog>().addProduct(Product(
        id: 2,
        name: 'Chocolate jar',
        shortDescription: 'Jar contatins chocolate mixture',
        longDescription: 'One liter jar filled with chocolate mixture',
        category: ProductCategory.food,
        price: 12,
        image: Image.asset('assets/nutella jar.jpg'),
        vendor: 'Bayya'));

    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print('Error occured');
        }

        if (snapshot.connectionState == ConnectionState.done) {
          _loginAnon();
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
