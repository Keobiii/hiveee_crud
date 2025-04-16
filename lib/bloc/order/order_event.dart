import 'package:equatable/equatable.dart';
import 'package:hiveee/models/order.dart';
import 'package:hiveee/models/product.dart';
import 'package:hiveee/models/user.dart';

abstract class OrderEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddOrder extends OrderEvent {
  final Product product;
  final User user;

  AddOrder(this.product, this.user);

  @override
  List<Object?> get props => [product, user];
}

class UpdateOrder extends OrderEvent {
  final Product updatedOrder;
  final User updatedUser;

  UpdateOrder(this.updatedOrder, this.updatedUser);

  @override
  List<Object?> get props => [updatedOrder, updatedUser];
}

class DeleteOrder extends OrderEvent {
  final int orderId;

  DeleteOrder(this.orderId);

  @override
  List<Object?> get props => [orderId];
}
