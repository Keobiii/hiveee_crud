import 'package:equatable/equatable.dart';
import 'package:hiveee/models/order.dart';
import 'package:hiveee/models/product.dart';
import 'package:hiveee/models/user.dart';

abstract class OrderEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddOrder extends OrderEvent {
  final Order order;

  AddOrder(this.order);

  @override
  List<Object?> get props => [order];
}

class UpdateOrder extends OrderEvent {
  final Order updatedOrder;

  UpdateOrder(this.updatedOrder);

  @override
  List<Object?> get props => [updatedOrder];
}

class DeleteOrder extends OrderEvent {
  final int orderId;

  DeleteOrder(this.orderId);

  @override
  List<Object?> get props => [orderId];
}
