import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hiveee/bloc/order/order_event.dart';
import 'package:hiveee/bloc/order/order_state.dart';
import 'package:hiveee/models/order.dart';
import 'package:hiveee/repositories/order_repository.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final OrderRepository orderRepository;

  OrderBloc({required this.orderRepository}) : super(OrderInitial()) {
    on<AddOrder>(_onAddOrder);
    on<UpdateOrder>(_onUpdateOrder);
    on<DeleteOrder>(_onDeleteOrder);
  }

  Future<void> _onAddOrder(AddOrder event, Emitter<OrderState> emit) async {
    emit(OrderLoading());

    try {
      await orderRepository.addOrder(event.order);

      emit(OrderSuccess(event.order));      
    } catch (e) {
      emit(OrderFailure(e.toString()));
    }
  }

  Future<void> _onUpdateOrder(UpdateOrder event, Emitter<OrderState> emit) async {
    emit(OrderLoading());

    try {
      await orderRepository.updateOrder(event.updatedOrder);
      emit(OrderSuccess(event.updatedOrder));
    } catch (e) {
      emit(OrderFailure(e.toString()));
    }
  }

  Future<void> _onDeleteOrder(DeleteOrder event, Emitter<OrderState> emit) async {
    emit(OrderLoading());

    try {
      Order? deletedOrder = await orderRepository.getOrderById(event.orderId);

      await orderRepository.deleteOrder(event.orderId);

      if (deletedOrder != null) {
        emit(OrderSuccess(deletedOrder));
      } else {
        emit(OrderFailure("Product not found"));
      }      

    } catch (e) {
      emit(OrderFailure(e.toString()));
    }
  }

}