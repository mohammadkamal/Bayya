import 'package:flutter/cupertino.dart';

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
      this.category,
      this.image});

  //Fields & Variables
  final String name, shortDescription, longDescription, vendor;
  final double price; //To do: --> remove 'final' keyword
  final int id;
  final Image image;
  //Float ratings; //To do: --> To be added some time later
  int quantity;
  ProductCategory category;
}