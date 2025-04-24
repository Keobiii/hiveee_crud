import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hiveee/bloc/auth/auth_bloc.dart';
import 'package:hiveee/bloc/order/order_bloc.dart';
import 'package:hiveee/bloc/product/product_bloc.dart';
import 'package:hiveee/bloc/user/user.event.dart';
import 'package:hiveee/bloc/user/user_bloc.dart';
import 'package:hiveee/bloc/user/user_state.dart';
import 'package:hiveee/repositories/order_repository.dart';
import 'package:hiveee/repositories/product_repository.dart';
import 'package:hiveee/repositories/user_repository.dart';
import 'package:hiveee/screens/login_screen.dart';
import 'package:hiveee/screens/seller/add_product.dart';
import 'package:hiveee/screens/seller/list_orders.dart';
import 'package:hiveee/screens/seller/update_order.dart';
import 'package:hiveee/screens/seller/update_product_data.dart';
import 'package:hiveee/screens/seller/list_product.dart';
import 'package:hiveee/screens/seller/seller_screen.dart';
import 'package:hiveee/screens/signup_screen.dart';
import 'package:hiveee/screens/admin/update_user_data.dart';
import 'package:hiveee/screens/admin/user_list_screen.dart';
import 'package:hiveee/screens/user/order_list_page.dart';
import 'package:hiveee/screens/user/order_page.dart';
import 'package:hiveee/screens/user/user_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create:
                    (context) => AuthBloc(
                      userRepository: context.read<UserRepository>(),
                    ),
                child: const LoginScreen(),
              ),
        );
      case '/signup':
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create:
                    (context) => AuthBloc(
                      userRepository: context.read<UserRepository>(),
                    ),
                child: const SignUpScreen(),
              ),
        );
      case '/list':
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create:
                    (context) =>
                        UserBloc(userRepository: context.read<UserRepository>())
                          ..add(LoadUsers()),
                child: const UserListScreen(),
              ),
        );

      case '/updateUser':
        // Expecting the Page that passing userId
        final userId = settings.arguments as int;
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create:
                    (context) => UserBloc(
                      userRepository: context.read<UserRepository>(),
                    ),
                child: UpdateUserData(userId: userId),
              ),
        );
      case '/userPage':
        return MaterialPageRoute(
          builder:
              (_) => MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create:
                        (context) => OrderBloc(
                          orderRepository: context.read<OrderRepository>(),
                        ),
                  ),
                  BlocProvider(
                    create:
                        (context) => ProductBloc(
                          productRepository: context.read<ProductRepository>(),
                        ),
                  ),
                ],
                child: const UserScreen(),
              ),
        );
      case '/orderPage':
        return MaterialPageRoute(
          builder:
              (_) => MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create:
                        (context) => UserBloc(
                          userRepository: context.read<UserRepository>(),
                        ),
                  ),
                  BlocProvider(
                    create:
                        (context) => AuthBloc(
                          userRepository: context.read<UserRepository>(),
                        ),
                  ),
                  BlocProvider(
                    create:
                        (context) => OrderBloc(
                          orderRepository: context.read<OrderRepository>(),
                        ),
                  ),
                ],
                child: const OrderPage(),
              ),
        );
      case '/userOrderList':
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create:
                    (context) => OrderBloc(
                      orderRepository: context.read<OrderRepository>(),
                    ),
                child: const OrderListPage(),
              ),
        );
      case '/sellerPage':
        return MaterialPageRoute(
          builder:
              (_) => MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create:
                        (context) => ProductBloc(
                          productRepository: context.read<ProductRepository>(),
                        ),
                  ),
                ],
                child: const SellerScreen(),
              ),
        );
      case '/addProduct':
        return MaterialPageRoute(
          builder:
              (_) => MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create:
                        (context) => ProductBloc(
                          productRepository: context.read<ProductRepository>(),
                        ),
                  ),
                ],
                child: const ProductForm(),
              ),
        );
      case '/listProduct':
        return MaterialPageRoute(
          builder:
              (_) => MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create:
                        (context) => ProductBloc(
                          productRepository: context.read<ProductRepository>(),
                        ),
                  ),
                ],
                child: const ListProduct(),
              ),
        );
      case '/updateProduct':
        // Expecting the Page that passing userId
        final productId = settings.arguments as int;
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create:
                    (context) => ProductBloc(
                      productRepository: context.read<ProductRepository>(),
                    ),
                child: UpdateProductData(productId: productId),
              ),
        );
      case '/listOrder':
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create:
                    (context) => OrderBloc(
                      orderRepository: context.read<OrderRepository>(),
                    ),
                child: const ListOrders(),
              ),
        );
      case '/updateOrder':
        final orderId = settings.arguments as int;
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create:
                    (context) => OrderBloc(
                      orderRepository: context.read<OrderRepository>(),
                    ),
                child: UpdateOrder(orderId: orderId),
              ),
        );
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(title: const Text('No Route'), centerTitle: true),
          body: const Center(
            child: Text(
              'Sorry route not found',
              style: TextStyle(color: Colors.red, fontSize: 18.0),
            ),
          ),
        );
      },
    );
  }
}
