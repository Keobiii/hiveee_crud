import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hiveee/bloc/user/user.event.dart';
import 'package:hiveee/bloc/user/user_bloc.dart';
import 'package:hiveee/bloc/user/user_state.dart';
import 'package:hiveee/models/user.dart';

class UserListScreen extends StatelessWidget {
  const UserListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Registered Users")),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UpdateLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is UsersLoaded) {
            final users = state.users;

            print("User ${users}");

            if (users.isEmpty) {
              return const Center(child: Text("No users found."));
            }

            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return Dismissible(
                  key: Key(user.userId.toString()),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Icon(Icons.delete, color: Colors.white),
                  ),
                  onDismissed: (direction) {
                    context.read<UserBloc>().add(DeleteUser(user.userId));
                  },
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/updateUser',
                        arguments: user.userId,
                      );
                    },
                    child: Card(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: ListTile(
                        leading: CircleAvatar(child: Text(user.firstName[0])),
                        title: Text("${user.firstName} ${user.lastName}"),
                        subtitle: Text(user.email),
                        trailing: Text("ID: ${user.userId}"),
                      ),
                    ),
                  ),
                );
              },
            );
          } else if (state is UpdateFailure) {
            return Center(
              child: Text(
                "Error: ${state.message}",
                style: TextStyle(color: Colors.white),
              ),
            );
          }

          return const SizedBox.shrink(); // initial empty state
        },
      ),
    );
  }
}
