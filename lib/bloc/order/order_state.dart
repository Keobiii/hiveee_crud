import 'package:equatable/equatable.dart';
import 'package:hiveee/models/order.dart';
import 'package:hiveee/models/product.dart';
import 'package:hiveee/models/user.dart';

abstract class OrderState extends Equatable {
  @override
  List<Object?> get props => [];
}

class OrderInitial extends OrderState {}

class OrderLoading extends OrderState {}

class OrderSuccess extends OrderState {
  final Order order;

  OrderSuccess(this.order);

  @override
  List<Object?> get props => [order];
}

class OrderFailure extends OrderState {
  final String message;

  OrderFailure(this.message);

  @override
  List<Object?> get props => [message];
}
