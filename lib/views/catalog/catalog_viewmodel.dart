import 'package:bayya/models/product.dart';
import 'package:bayya/utils/injector.dart';
import 'package:bayya/views/abstract/base_view_model.dart';

class CatalogViewModel extends BaseViewModel {
  final _catalogRepository = Injector().catalogRepository;

  final productsMap = <String, Product>{};

  void fetchProducts() {
    _catalogRepository
        .fetchProducts()
        .listen((products) => productsMap.addEntries(products.entries));

    notifyListeners();
  }

  Product getProduct(String id) => productsMap[id];
}
