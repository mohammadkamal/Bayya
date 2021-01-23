import 'dart:ffi';

enum ProductCategory { clothes, elctronics, food }

class Product {
  //Constructor
  Product(
      {this.id,
      this.name,
      this.shortDescription,
      this.longDescription,
      this.vendor,
      this.price,
      this.category});

  //Fields & Variables
  final String name, shortDescription, longDescription, vendor;
  final double price;
  final int id;
  Float ratings;
  int quantity;
  ProductCategory category;
}