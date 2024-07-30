import 'product.dart';

class ProductManager {
  List<Product> _products = [];

  void addProduct(Product product) {
    _products.add(product);
    print('Added product: $product');
  }

  void viewAllProducts() {
    if (_products.isEmpty) {
      print('No products available.');
    } else {
      print('Products:');
      for (var product in _products) {
        print('- ${product.name} (${product.description}, \$${product.price})');
      }
    }
  }

  void viewProduct(int index) {
    if (index >= 0 && index < _products.length) {
      Product product = _products[index];
      print('Product Details:');
      print('Name: ${product.name}');
      print('Description: ${product.description}');
      print('Price: \$${product.price}');
    } else {
      print('Invalid product index.');
    }
  }

  void editProduct(int index, {String? name, String? description, double? price}) {
    if (index >= 0 && index < _products.length) {
      Product product = _products[index];
      product.name = name ?? product.name;
      product.description = description ?? product.description;
      product.price = price ?? product.price;
      print('Updated product: $product');
    } else {
      print('Invalid product index.');
    }
  }

  void deleteProduct(int index) {
    if (index >= 0 && index < _products.length) {
      Product product = _products.removeAt(index);
      print('Deleted product: $product');
    } else {
      print('Invalid product index.');
    }
  }
}