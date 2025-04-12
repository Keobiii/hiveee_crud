import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hiveee/bloc/auth/auth_bloc.dart';
import 'package:hiveee/models/user.dart';
import 'package:hiveee/repositories/user_repository.dart';
import 'package:hiveee/routes/route_generator.dart';
import 'package:hiveee/utils/Palette.dart';
import 'package:hive_flutter/adapters.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Hive
  await Hive.initFlutter();

  // Register Adapter
  Hive.registerAdapter(UserAdapter());

  // Open the box
  await Hive.openBox<User>('users');


  // runApp(const MyApp());

  runApp(
    RepositoryProvider(
      create: (_) => UserRepository(),
      child: BlocProvider(
        create: (context) => AuthBloc(userRepository: context.read<UserRepository>()),
        child: const MyApp(),
      ),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
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
