import 'dart:convert';

import '../enums/product_category.dart';
import '../utils/enum_string.dart';
import 'vendor_account.dart';

class Product {
  //Constructor
  Product(
      {this.name,
      this.shortDescription,
      this.longDescription,
      this.vendor,
      this.price,
      this.category,
      this.imageURL,
      this.dateTimeAddition,
      this.quantity});

  //Fields & Variables
  String name;
  String shortDescription;
  String longDescription;
  VendorAccount vendor;
  String imageURL;
  DateTime dateTimeAddition;
  double price;
  int quantity;
  ProductCategory category;

  Product copyWith(
      String name,
      String shortDescription,
      String longDescription,
      String vendor,
      String imageURL,
      DateTime dateTimeAddition,
      double price,
      int quantity,
      ProductCategory category) {
    return Product(
      category: category ?? this.category,
      quantity: quantity ?? this.quantity,
      dateTimeAddition: dateTimeAddition ?? this.dateTimeAddition,
      imageURL: imageURL ?? this.imageURL,
      price: price ?? this.price,
      shortDescription: shortDescription ?? this.shortDescription,
      longDescription: longDescription ?? this.longDescription,
      vendor: vendor ?? this.vendor,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'category': EnumString.convertToString(category),
      'quantity': quantity,
      'dateTimeAddition': dateTimeAddition.toIso8601String(),
      'imageURL': imageURL,
      'price': price,
      'shortDescription': shortDescription,
      'longDescription': longDescription,
      'vendor': vendor.toMap(),
      'name': name
    }..removeWhere((key, value) => key == null || value == null);
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
        category: map['category'] == null
            ? null
            : EnumString.convertFromString(
                ProductCategory.values, map['category']),
        quantity: map['quantity'],
        dateTimeAddition: map['dateTimeAddition'] == null
            ? null
            : (map['dateTimeAddition']).toDate(),
        imageURL: map['imageURL'],
        price: map['price'],
        shortDescription: map['shortDescription'],
        longDescription: map['longDescription'],
        vendor:
            map['vendor'] == null ? null : VendorAccount.fromMap(map['vendor']),
        name: map['name']);
  }

  factory Product.fromJson(String json) => Product.fromMap(jsonDecode(json));

  String toJson() => jsonEncode(toMap());

  @override
  String toString() {
    return 'Product(name: $name, shortDescription: $shortDescription, longDescription: $longDescription, vendor: $vendor, imageURL: $imageURL, dateTimeAddition: $dateTimeAddition, price: $price, quantity: $quantity, category: $category)';
  }
}
