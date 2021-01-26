import 'package:flutter/material.dart';
import 'Product.dart';
import 'ShoppingList.dart';

void main() {
  runApp(MaterialApp(
    title: 'Bayya',
    home: ShoppingList(
      products: <Product>[
        Product(
            id: 0,
            name: 'Blue jeans',
            shortDescription: 'Blue jeans for men',
            longDescription: 'Blue jeans for men available at all sizes',
            category: ProductCategory.clothes,
            price: 50,
            image: Image.asset('assets/blue jeans.jpg'),
            vendor: 'Bayya'),
        Product(
            id: 1,
            name: 'LED TV',
            shortDescription: 'Television with LED screen',
            longDescription: '20-inch monitor with HD quality display',
            category: ProductCategory.elctronics,
            price: 1100,
            image: Image.asset('assets/20-inch-samsung-led-tv.jpg'),
            vendor: 'Bayya'),
        Product(
            id: 2,
            name: 'Chocolate jar',
            shortDescription: 'Jar contatins chocolate mixture',
            longDescription: 'One liter jar filled with chocolate mixture',
            category: ProductCategory.food,
            price: 12,
            image: Image.asset('assets/nutella jar.jpg'),
            vendor: 'Bayya')
      ],
    ),
  ));
}
