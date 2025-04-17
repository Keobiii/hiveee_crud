import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hiveee/bloc/order/order_bloc.dart';
import 'package:hiveee/bloc/order/order_event.dart';
import 'package:hiveee/models/order.dart';
import 'package:hiveee/models/product.dart';
import 'package:hiveee/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  int? userId;
  int? userRole;

  late Box<Product> productBox;
  late Box<Order> orderBox;

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
    _initializeHiveBoxes();
  }

  void _initializeHiveBoxes() {
    productBox = Hive.box<Product>('products');
    orderBox = Hive.box<Order>('orders');
  }

  Future<void> _loadUserInfo() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      userId = prefs.getInt('userId');
      userRole = prefs.getInt('userRole');
    });

    print('User ID: $userId');
    print('User Role: $userRole');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("List of Products")),
      body: ValueListenableBuilder(
        valueListenable: productBox.listenable(),
        builder: (context, Box<Product> box, _) {
          final products = box.values.toList();

          if (products.isEmpty) {
            return const Center(child: Text("No products found."));
          }

          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return GestureDetector(
                onTap: () {
                  // You now have access to orderBox, userId, userRole
                  print('Tapped product: ${product.name}');
                  print('User ID: $userId');
                  print('User Role: $userRole');
                  print('Total Orders: ${orderBox.length}');

                  final order = Order(
                    orderId:
                        orderBox.isEmpty ? 1 : orderBox.values.last.orderId + 1,
                    productId: product.productId,
                    userId: userId ?? 0,
                    status: 1,
                    orderedAt: DateTime.now(),
                  );

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Order Added successfully')),
                  );

                  context.read<OrderBloc>().add(AddOrder(order));
                  Navigator.of(context).pop();
                },
                child: Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(child: Image.asset(product.image)),
                    title: Text(product.name),
                    subtitle: Text(product.description),
                    trailing: Column(
                      children: [
                        Text('${product.price}'),
                        Text('${product.quantity}'),
                      ],
                    ),
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
