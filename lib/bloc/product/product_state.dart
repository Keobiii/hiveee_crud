import 'package:equatable/equatable.dart';
import 'package:hiveee/models/product.dart';

abstract class ProductState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductSuccess extends ProductState {
  final Product product;

  ProductSuccess(this.product);

  @override
  List<Object?> get props => [product];
}

class ProductFailure extends ProductState {
  final String message;

  ProductFailure(this.message);

  @override
  List<Object?> get props => [message];
}
