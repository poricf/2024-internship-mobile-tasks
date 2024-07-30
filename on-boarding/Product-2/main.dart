import 'dart:io';
import 'product.dart';
import 'product_manager.dart';

void main() {
  ProductManager productManager = ProductManager();

  while (true) {
    print('\nECommerce Application Menu:');
    print('1. Add Product');
    print('2. View All Products');
    print('3. View Product');
    print('4. Edit Product');
    print('5. Delete Product');
    print('6. Exit');

    print('\nEnter your choice (1-6): ');
    int? choice = int.tryParse(stdin.readLineSync() ?? '');

    if (choice == null) {
      print('Invalid choice. Please try again.');
      continue;
    }

    switch (choice) {
      case 1:
        print('\nEnter product details:');
        print('Name: ');
        String name = stdin.readLineSync() ?? '';
        print('Description: ');
        String description = stdin.readLineSync() ?? '';
        print('Price: ');
        double? price = double.tryParse(stdin.readLineSync() ?? '');
        if (price != null) {
          Product product = Product(name: name, description: description, price: price);
          productManager.addProduct(product);
        } else {
          print('Invalid price. Product not added.');
        }
        break;
      case 2:
        productManager.viewAllProducts();
        break;
      case 3:
        print('\nEnter product index: ');
        int? index = int.tryParse(stdin.readLineSync() ?? '');
        if (index != null) {
          productManager.viewProduct(index);
        } else {
          print('Invalid index. Please try again.');
        }
        break;
      case 4:
        print('\nEnter product index: ');
        int? index = int.tryParse(stdin.readLineSync() ?? '');
        if (index != null) {
          print('Enter new name (or leave blank to keep the same): ');
          String? newName = stdin.readLineSync();
          print('Enter new description (or leave blank to keep the same): ');
          String? newDescription = stdin.readLineSync();
          print('Enter new price (or leave blank to keep the same): ');
          String? newPriceStr = stdin.readLineSync();
          double? newPrice = newPriceStr != null ? double.tryParse(newPriceStr) : null;
          productManager.editProduct(index, name: newName, description: newDescription, price: newPrice);
        } else {
          print('Invalid index. Please try again.');
        }
        break;
      case 5:
        print('\nEnter product index: ');
        int? index = int.tryParse(stdin.readLineSync() ?? '');
        if (index != null) {
          productManager.deleteProduct(index);
        } else {
          print('Invalid index. Please try again.');
        }
        break;
      case 6:
        print('Exiting eCommerce Application...');
        return;
      default:
        print('Invalid choice. Please try again.');
    }
  }
}