import 'package:cloud_firestore/cloud_firestore.dart';

import '../enums/product_category.dart';
import '../utils/enum_string.dart';

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
      this.imageURL,
      this.timeAdded,
      this.quantity});

  //Fields & Variables
  String id;
  String name;
  String shortDescription;
  String longDescription;
  DocumentReference vendor;
  String imageURL;
  DateTime timeAdded;
  double price;
  int quantity;
  ProductCategory category;

  Product copyWith(
      {String id,
      String name,
      String shortDescription,
      String longDescription,
      String vendor,
      String imageURL,
      DateTime timeAdded,
      double price,
      int quantity,
      ProductCategory category}) {
    return Product(
      id: id ?? this.id,
      category: category ?? this.category,
      quantity: quantity ?? this.quantity,
      timeAdded: timeAdded ?? this.timeAdded,
      imageURL: imageURL ?? this.imageURL,
      price: price ?? this.price,
      shortDescription: shortDescription ?? this.shortDescription,
      longDescription: longDescription ?? this.longDescription,
      vendor: vendor ?? this.vendor,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category': EnumString.convertToString(category),
      'quantity': quantity,
      'dateTimeAddition': Timestamp.fromDate(timeAdded),
      'imageURL': imageURL,
      'price': price,
      'shortDescription': shortDescription,
      'longDescription': longDescription,
      'vendor': vendor,
      'name': name
    }..removeWhere((key, value) => key == null || value == null);
  }

  factory Product.fromJson(Map<String, dynamic> map) {
    return Product(
        category: map['category'] == null
            ? null
            : EnumString.convertFromString(
                ProductCategory.values, map['category']),
        quantity: map['quantity'],
        timeAdded: map['dateTimeAddition'] == null
            ? null
            : (map['dateTimeAddition']).toDate(),
        imageURL: map['imageURL'],
        price: map['price'],
        shortDescription: map['shortDescription'],
        longDescription: map['longDescription'],
        vendor: map['vendor'],
        name: map['name']);
  }

  @override
  String toString() {
    return 'Product(id: $id, name: $name, shortDescription: $shortDescription, longDescription: $longDescription, vendor: $vendor, imageURL: $imageURL, timeAdded: $timeAdded, price: $price, quantity: $quantity, category: $category)';
  }
}
