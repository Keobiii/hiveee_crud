import 'package:equatable/equatable.dart';
import 'package:hiveee/models/product.dart';
import 'package:hiveee/models/user.dart';

abstract class OrderState extends Equatable {
  @override
  List<Object?> get props => [];
}

class OrderInitial extends OrderState {}

class OrderLoading extends OrderState {}

class OrderSuccess extends OrderState {
  final Product product;
  final User user;

  OrderSuccess(this.product, this.user);

  @override
  List<Object?> get props => [product, user];
}

class OrdeFailure extends OrderState {
  final String message;

  OrdeFailure(this.message);

  @override
  List<Object?> get props => [message];
}
