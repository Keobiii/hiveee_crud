import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hiveee/models/user.dart';

class UserListScreen extends StatelessWidget {
  const UserListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userBox = Hive.box<User>('users');
    final users = userBox.values.toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Registered Users"),
      ),
      body: users.isEmpty
          ? const Center(child: Text("No users found."))
          : ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text(user.firstName[0]),
                    ),
                    title: Text("${user.firstName} ${user.lastName}"),
                    subtitle: Text(user.email),
                    trailing: Text("ID: ${user.id}"),
                  ),
                );
              },
            ),
    );
  }
}
