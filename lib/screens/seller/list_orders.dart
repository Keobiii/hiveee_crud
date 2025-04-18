import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hiveee/bloc/order/order_bloc.dart';
import 'package:hiveee/bloc/order/order_event.dart';
import 'package:hiveee/models/order.dart';
import 'package:hiveee/models/order_status.dart';
import 'package:hiveee/models/product.dart';
import 'package:hiveee/models/user.dart';

class ListOrders extends StatefulWidget {
  const ListOrders({super.key});

  @override
  State<ListOrders> createState() => _ListOrdersState();
}

class _ListOrdersState extends State<ListOrders> {
  late Box<Order> orderBox;
  late Box<Product> productBox;
  late Box<User> userBox;

  @override
  void initState() {
    super.initState();
    _initializeBoxes();
  }

  void _initializeBoxes() {
    orderBox = Hive.box<Order>('orders');
    productBox = Hive.box<Product>('products');
    userBox = Hive.box<User>('users');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Orders from Customers")),
      body: ValueListenableBuilder(
        valueListenable: orderBox.listenable(),
        builder: (context, Box<Order> box, _) {
          // 1. Get all users with role == 2
          final userCustomers =
              userBox.values.where((user) => user.userRole == 2).toList();

          // 2. Extract their userIds
          final customerIds = userCustomers.map((u) => u.userId).toSet();

          // 3. Filter orders from those users
          final customerOrders =
              box.values
                  .where((order) => customerIds.contains(order.userId))
                  .toList();

          if (customerOrders.isEmpty) {
            return const Center(child: Text("No orders from customers found."));
          }

          return ListView.builder(
            itemCount: customerOrders.length,
            itemBuilder: (context, index) {
              final order = customerOrders[index];

              final product = productBox.values.firstWhere(
                (p) => p.productId == order.productId,
                orElse:
                    () => Product(
                      productId: -1,
                      name: 'Unknown Product',
                      description: '',
                      categoryId: 0,
                      price: 0,
                      quantity: 0,
                      image: 'assets/placeholder.png',
                    ),
              );

              final user = userBox.values.firstWhere(
                (u) => u.userId == order.userId,
                orElse:
                    () => User(
                      userId: -1,
                      firstName: 'Unknown',
                      lastName: 'Unknown',
                      email: 'unknown@email.com',
                      password: 'unkown',
                      userRole: 0,
                      createdAt: DateTime.now(),
                    ),
              );

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(product.image),
                  ),
                  title: Text("${product.name}"),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Ordered by: ${user.firstName}"),
                      Text("Email: ${user.email}"),
                      Text("Order Status: ${OrderStatus.fromStatusId(order.status).status}"),
                    ],
                  ),
                  trailing: PopupMenuButton<int>(
                    icon: const Icon(Icons.more_vert),
                    itemBuilder: (context) {
                      return OrderStatus.values
                          .where(
                            (status) => status.statusId != order.status,
                          ) // exclude current
                          .map(
                            (status) => PopupMenuItem<int>(
                              value: status.statusId,
                              child: Text(status.status),
                            ),
                          )
                          .toList();
                    },
                    onSelected: (int newStatus) {
                      final updatedOrder = Order(
                        orderId: order.orderId,
                        productId: order.productId,
                        userId: order.userId,
                        status: newStatus,
                        orderedAt: order.orderedAt,
                      );

                      context.read<OrderBloc>().add(UpdateOrder(updatedOrder));

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Order ID: ${order.orderId} Status is Updated to $newStatus'
                          ),
                        )
                      );
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
