import 'package:hive/hive.dart';
import 'package:hiveee/models/product.dart';

// this is helper class that helps to talk with the Hive

class ProductRepository {
  static const String boxName = 'products';

  Future<void> addProduct(Product product) async {
    final box = await Hive.openBox<Product>(boxName);
    await box.put(product.id, product);
  }

  Future<Product?> getProductById(int id) async {
    final box = await Hive.openBox<Product>(boxName);
    return box.get(id);
  }

  Future<List<Product>> getAllProducts() async {
    final box = await Hive.openBox<Product>(boxName);
    return box.values.toList();
  }

  Future<void> deleteProduct(int id) async {
    final box = await Hive.openBox<Product>(boxName);
    await box.delete(id);
  }

  Future<void> updateProduct(Product product) async {
    final box = await Hive.openBox<Product>(boxName);
    await box.put(product.id, product);
  }
}
