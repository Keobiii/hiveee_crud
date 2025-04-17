import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hiveee/models/order.dart';
import 'package:hiveee/models/product.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderListPage extends StatefulWidget {
  const OrderListPage({super.key});

  @override
  State<OrderListPage> createState() => _OrderListPageState();
}

class _OrderListPageState extends State<OrderListPage> {
  int? userId;
  late Box<Order> orderBox;
  late Box<Product> productBox;

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
    _initializeBoxes();
  }

  void _initializeBoxes() {
    orderBox = Hive.box<Order>('orders');
    productBox = Hive.box<Product>('products');
  }

  Future<void> _loadUserInfo() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      userId = prefs.getInt('userId');
    });

    print("Logged in userId: $userId");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Orders")),
      body: ValueListenableBuilder(
        valueListenable: orderBox.listenable(),
        builder: (context, Box<Order> box, _) {
          if (userId == null) {
            return const Center(child: Text("User not found."));
          }

          // Filter orders by logged-in userId
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
                orElse: () => Product(productId: -1, name: 'Unknown', categoryId: 0, description: 'Unknown', image: 'assets/images/shoe.png', price: 0, quantity: 0)
              );

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  leading: CircleAvatar(child: Image.asset(product.image)),
                  title: Text(product.name),
                  subtitle: Text("Ordered at: ${order.orderedAt.toLocal()}"),
                  trailing: Text("Order by: $userId"),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
