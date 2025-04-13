import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hiveee/models/user.dart';

class UserListScreen extends StatelessWidget {
  const UserListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userBox = Hive.box<User>('users');

    return Scaffold(
      appBar: AppBar(
        title: const Text("Registered Users"),
      ),
      // "ValueListenableBuilder" listens for the changes in the Hive box
      // its reactive package of hive
      body: ValueListenableBuilder(
        valueListenable: userBox.listenable(),
        builder: (context, Box<User> box, _) {
          final users = box.values.toList();

          if (users.isEmpty) {
            return const Center(child: Text("No users found."));
          }

          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/updateUser', arguments: user.id);
                },
                child: Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text(user.firstName[0]),
                    ),
                    title: Text("${user.firstName} ${user.lastName}"),
                    subtitle: Text(user.email),
                    trailing: Text("ID: ${user.id}"),
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
