import 'package:equatable/equatable.dart';
import 'package:hiveee/models/product.dart';

abstract class ProductEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddProduct extends ProductEvent {
  final Product product;

  AddProduct(this.product);

  @override
  List<Object?> get props => [product];
}

class UpdateProduct extends ProductEvent {
  final Product updatedProduct;

  UpdateProduct(this.updatedProduct);

  @override
  List<Object?> get props => [updatedProduct];
}

class DeleteProduct extends ProductEvent {
  final int productId;

  DeleteProduct(this.productId);

  @override
  List<Object?> get props => [productId];
}
