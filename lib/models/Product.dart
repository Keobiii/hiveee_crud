import 'package:hive/hive.dart';
import 'package:hiveee/models/product_category.dart';

part 'product.g.dart';

@HiveType(typeId: 1)
class Product {
  @HiveField(0)
  int productId;

  @HiveField(1)
  String name;

  @HiveField(2)
  int categoryId;

  @HiveField(3)
  String image;

  @HiveField(4)
  String description;

  @HiveField(5)
  double price;

  @HiveField(6)
  int quantity;

  Product({
    required this.productId,
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
