import 'package:cupertino_store_app/model/product.dart';
import 'package:cupertino_store_app/model/product_repository.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/material.dart';

double _salesTaxRate = 0.11;
double _shippingCostPerItem = 7;

class AppStateModel extends foundation.ChangeNotifier {
  // All the available products.
  List<Product> _availableProducts = [];

  // The currently selected category of products.
  Category _selectedCategory = Category.all;

  // The IDs and quantities of products currently in the cart.
  final _productInCart = <int, int>{};

  Map<int, int> get productInCart {
    return Map.from(_productInCart);
  }

  int get totalCartQuantity {
    return _productInCart.values.fold(0, (accumulator, value) {
      return accumulator + value;
    });
  }

  Category get selectedCategory {
    return _selectedCategory;
  }

  // Totaled prices of the items in the cart.
  double get subtotalCost {
    return _productInCart.keys.map((id) {
      // Extended price for product line
      return getProductById(id).price * _productInCart[id]!;
    }).fold(0, (accumulator, extendedPrice) {
      return accumulator + extendedPrice;
    });
  }

  // Total shipping cost for the items in the cart.
  double get shippingCost {
    return _shippingCostPerItem *
        _productInCart.values.fold(0.0, (accumulator, itemCount) {
          return accumulator + itemCount;
        });
  }

  // Sales tax for the items in the cart
  double get tax {
    return subtotalCost * _salesTaxRate;
  }

  // Total cost to order everything in the cart.
  double get totalCost {
    return subtotalCost + shippingCost + tax;
  }

  // Returns a copy of the list of available products, filtered by category.
  List<Product> getProducts() {
    if (_selectedCategory == Category.all) {
      return List.from(_availableProducts);
    } else {
      return _availableProducts.where((p) {
        return p.category == _selectedCategory;
      }).toList();
    }
  }

  // Search the product catalog
  List<Product> search(String searchTerms) {
    return getProducts().where((product) {
      return product.name.toLowerCase().contains(searchTerms.toLowerCase());
    }).toList();
  }

  // Adds a product to the cart.
  void addProductToCart(int productId) {
    if (!_productInCart.containsKey(productId)) {
      _productInCart[productId] = 1;
    } else {
      _productInCart[productId] = _productInCart[productId]! + 1;
    }

    notifyListeners();
  }

  // Removes an item from the cart.
  void removeItemFromCart(int productId) {
    if (_productInCart.containsKey(productId)) {
      if (_productInCart[productId] == 1) {
        _productInCart.remove(productId);
      } else {
        _productInCart[productId] = _productInCart[productId]! - 1;
      }
    }

    notifyListeners();
  }

  // Returns the Product instance matching the provided id.
  Product getProductById(int id) {
    return _availableProducts.firstWhere((p) => p.id == id);
  }

  // Removes everything from the cart.
  void clearCart() {
    _productInCart.clear();
    notifyListeners();
  }

  // Loads the list of available products from the repo.
  void loadProducts() {
    _availableProducts = ProductRepository.loadProducts(Category.all);
    notifyListeners();
  }

  void setCategory(Category newCategory) {
    _selectedCategory = newCategory;
    notifyListeners();
  }
}
