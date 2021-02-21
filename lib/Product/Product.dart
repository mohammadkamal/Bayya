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
  String name, shortDescription, longDescription, vendor;
  double price, ratings;
  int id, quantity;
  Image image;
  ProductCategory category;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'shortDescription': shortDescription,
        'longDescription': longDescription,
        'vendor': vendor,
        'price': price,
        'category': category,
        'image': image,
        'ratings': ratings
      };


  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    shortDescription = json['shortDescription'];
    longDescription = json['longDescription'];
    vendor = json['vendor'];
    price = json['price'];
    category = json['category'];
    image = json['image'];
    ratings = json['ratings'];
  }
}
