import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hiveee/bloc/product/product_bloc.dart';
import 'package:hiveee/bloc/product/product_event.dart';
import 'package:hiveee/models/product.dart';

class ListProduct extends StatefulWidget {
  const ListProduct({super.key});

  @override
  State<ListProduct> createState() => _ListProductState();
}

class _ListProductState extends State<ListProduct> {
  @override
  Widget build(BuildContext context) {
    final productBox = Hive.box<Product>('products');

    return Scaffold(
      appBar: AppBar(title: const Text("Product List")),
      // "ValueListenableBuilder" listens for the changes in the Hive box
      // its reactive package of hive
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
              return Dismissible(
                key: Key(product.productId.toString()),
                direction: DismissDirection.endToStart,
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Icon(Icons.delete, color: Colors.white),
                ),
                onDismissed: (direction) {
                  print("${product.productId} Selected");
                  // context.read<UserBloc>().add(DeleteUser(user.userId));
                  context.read<ProductBloc>().add(
                    DeleteProduct(product.productId),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('${product.name} removed')),
                  );
                },
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/updateProduct',
                      arguments: product.productId,
                    );
                  },
                  child: Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: ListTile(
                      leading: CircleAvatar(child: Image.asset(product.image)),
                      title: Text("${product.name}"),
                      subtitle: Text(product.description),
                      trailing: Column(
                        children: [
                          Text('${product.price}'),
                          Text('${product.quantity}'),
                        ],
                      ),
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
