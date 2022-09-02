import 'package:cupertino_store_app/model/product.dart';

class ProductRepository {
  static const _allProducts = <Product>[
    Product(
      id: 0,
      isFeatured: true,
      category: Category.accessories,
      name: 'Vagabond sack',
      price: 120,
    ),
    Product(
      id: 9,
      isFeatured: true,
      category: Category.home,
      name: 'Gilt desk trio',
      price: 58,
    ),
    Product(
      id: 33,
      isFeatured: true,
      category: Category.clothing,
      name: 'Cerise scallop tee',
      price: 42,
    ),
  ];

  static List<Product> loadProducts(Category category) {
    if (category == Category.all) {
      return _allProducts;
    } else {
      return _allProducts
          .where((product) => product.category == category)
          .toList();
    }
  }
}
