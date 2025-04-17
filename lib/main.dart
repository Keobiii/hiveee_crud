import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hiveee/bloc/auth/auth_bloc.dart';
import 'package:hiveee/bloc/product/product_bloc.dart';
import 'package:hiveee/bloc/user/user_bloc.dart';
import 'package:hiveee/models/order.dart';
import 'package:hiveee/models/product.dart';
import 'package:hiveee/models/user.dart';
import 'package:hiveee/repositories/order_repository.dart';
import 'package:hiveee/repositories/product_repository.dart';
import 'package:hiveee/repositories/user_repository.dart';
import 'package:hiveee/routes/route_generator.dart';
import 'package:hiveee/utils/Palette.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();

  // Register Adapter
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(ProductAdapter());
  Hive.registerAdapter(OrderAdapter());

  // Open the box
  await Hive.openBox<User>('users');
  await Hive.openBox<Product>('products');
  await Hive.openBox<Order>('orders');

  // runApp(const MyApp());

  runApp(
    MultiBlocProvider(
      providers: [
        RepositoryProvider(create: (_) => UserRepository()),
        RepositoryProvider(create: (_) => ProductRepository()),
        RepositoryProvider(create: (_) => OrderRepository()),
        BlocProvider(
          create:
              (context) =>
                  AuthBloc(userRepository: context.read<UserRepository>()),
        ),
        BlocProvider(
          create:
              (context) =>
                  UserBloc(userRepository: context.read<UserRepository>()),
        ),
        BlocProvider(
          create:
              (context) => ProductBloc(
                productRepository: context.read<ProductRepository>(),
              ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hive + BLoc',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Pallete.backgroundColor,
      ),
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
