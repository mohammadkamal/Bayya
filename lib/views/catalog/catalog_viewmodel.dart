import '../../models/product.dart';
import '../../utils/injector.dart';
import '../abstract/base_view_model.dart';

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
