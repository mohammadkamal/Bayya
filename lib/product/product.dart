import 'package:json_annotation/json_annotation.dart';

enum ProductCategory { clothes, elctronics, food }

@JsonSerializable()
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
  String name, shortDescription, longDescription, vendor, imageURL;
  DateTime dateTimeAddition;
  double price;
  int quantity;
  ProductCategory category;

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);

  String productCategoryToString() {
    String temp = "";
    switch (category) {
      case ProductCategory.clothes:
        temp = "Clothes";
        break;
      case ProductCategory.elctronics:
        temp = "Elctronics";
        break;
      case ProductCategory.food:
        temp = "Food";
        break;
      default:
        temp = "None";
        break;
    }
    return temp;
  }
}

ProductCategory productCategoryFromString(String str) {
  ProductCategory temp;
  switch (str) {
    case "Clothes":
      temp = ProductCategory.clothes;
      break;
    case "Elctronics":
      temp = ProductCategory.elctronics;
      break;
    case "Food":
      temp = ProductCategory.food;
      break;
    default:
      break;
  }
  return temp;
}

Product _$ProductFromJson(Map<String, dynamic> json) {
  return Product(
      name: json['name'],
      shortDescription: json['shortDescription'],
      longDescription: json['longDescription'],
      vendor: json['vendor'],
      price: json['price'],
      category: productCategoryFromString(json['category']),
      imageURL: json['imageURL'],
      dateTimeAddition: json['dateTimeAddition'].toDate(),
      quantity: json['quantity']);
}

Map<String, dynamic> _$ProductToJson(Product product) => <String, dynamic>{
      'name': product.name,
      'shortDescription': product.shortDescription,
      'longDescription': product.longDescription,
      'vendor': product.vendor,
      'price': product.price,
      'category': product.productCategoryToString(),
      'imageURL': product.imageURL,
      'dateTimeAddition': product.dateTimeAddition,
      'quantity': product.quantity
    };
