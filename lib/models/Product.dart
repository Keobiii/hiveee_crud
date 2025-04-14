import 'package:hiveee/models/product_category.dart';

class Product {
  int id;
  String name;
  int categoryId;
  String image;
  String description;
  double price;
  int quantity;

  Product({
    required this.id,
    required this.name,
    required this.categoryId,
    required this.description,
    required this.image,
    required this.price,
    required this.quantity,
  });

  // Getter
  ProductCategory get catId => ProductCategory.fromCategoryId(categoryId);

  // Setter
  set catId(ProductCategory catId) => categoryId = catId.categoryId;
}
