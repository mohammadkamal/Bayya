import 'package:bayya/models/product.dart';

abstract class CatalogRepository {
  Stream<Map<String, Product>> fetchProducts();
}