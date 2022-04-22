import 'package:bayya/models/product.dart';
import 'package:bayya/repositories/abstract/catalog_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CatalogRepositoryImplementation implements CatalogRepository {
  /*
  @override
  For trying
  Future<void> onDataChange() async {
    QuerySnapshot querySnapshot = await catalogStore.get();
    querySnapshot.docChanges.forEach((element) {});
  }
  */

  @override
  Stream<Map<String, Product>> fetchProducts() {
    var _stream = FirebaseFirestore.instance.collection('Catalog').snapshots();
    var _productsMap = <String, Product>{};

    return _stream.map((snaps) {
      for (var element in snaps.docs) {
        _productsMap[element.id] = Product.fromMap(element.data());
      }
      return _productsMap;
    });
  }
}
