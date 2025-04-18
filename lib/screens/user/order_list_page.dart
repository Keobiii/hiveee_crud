import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hiveee/bloc/order/order_bloc.dart';
import 'package:hiveee/bloc/order/order_event.dart';
import 'package:hiveee/models/order.dart';
import 'package:hiveee/models/order_status.dart';
import 'package:hiveee/models/product.dart';
import 'package:hiveee/models/user.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderListPage extends StatefulWidget {
  const OrderListPage({super.key});

  @override
  State<OrderListPage> createState() => _OrderListPageState();
}

class _OrderListPageState extends State<OrderListPage> {
  int? userId;
  User? currentUser;

  late Box<Order> orderBox;
  late Box<Product> productBox;
  late Box<User> userBox;

  @override
  void initState() {
    super.initState();
    _initializeBoxes();
    _loadUserInfo();
  }

  void _initializeBoxes() {
    orderBox = Hive.box<Order>('orders');
    productBox = Hive.box<Product>('products');
    userBox = Hive.box<User>('users');
  }

  Future<void> _loadUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    final id = prefs.getInt('userId');

    if (id != null) {
      setState(() {
        userId = id;
        currentUser = userBox.values.firstWhere(
          (user) => user.userId == id,
          orElse: () => User(userId: -1, firstName: 'Unknown', lastName: 'Unknown', password: 'unknown', email: 'unknown@email.com', userRole: 0, createdAt: DateTime.now()),
        );
      });

      print('Current user: ${currentUser?.firstName}, Email: ${currentUser?.email}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Orders"),
        bottom: currentUser != null
            ? PreferredSize(
                preferredSize: const Size.fromHeight(40),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Welcome, ${currentUser!.firstName} (${currentUser!.email})',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              )
            : null,
      ),
      body: ValueListenableBuilder(
        valueListenable: orderBox.listenable(),
        builder: (context, Box<Order> box, _) {
          if (userId == null) {
            return const Center(child: CircularProgressIndicator());
          }

          final userOrders = box.values.where((order) => order.userId == userId).toList();

          if (userOrders.isEmpty) {
            return const Center(child: Text("No orders found."));
          }

          return ListView.builder(
            itemCount: userOrders.length,
            itemBuilder: (context, index) {
              final order = userOrders[index];
              final product = productBox.values.firstWhere(
                (p) => p.productId == order.productId,
                orElse: () => Product(
                  productId: -1,
                  name: 'Unknown Product',
                  description: '',
                  categoryId: 0,
                  price: 0,
                  quantity: 0,
                  image: 'assets/placeholder.png',
                ),
              );

              return Dismissible(
                key: Key(order.orderId.toString()),
                direction: DismissDirection.endToStart,
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Icon(Icons.delete, color: Colors.white,),
                ),
                onDismissed: (direction) {
                  // print("Deleting ${order.productId} : ${product.name}");
                  context.read<OrderBloc>().add(DeleteOrder(order.orderId));
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        '${order.orderId} : ${product.name} removed',
                      ),
                    )
                  );
                },
                child: Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    leading: CircleAvatar(child: Image.asset(product.image)),
                    title: Text(product.name),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Ordered at: ${DateFormat('MMM d, y').format(order.orderedAt)}"),
                        Text("Order Status: ${OrderStatus.fromStatusId(order.status).status}")
                      ],
                    ),
                    trailing: Text('Qty: 1'),
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
