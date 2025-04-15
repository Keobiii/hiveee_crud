import 'package:hive/hive.dart';
import 'package:hiveee/models/user.dart';

// this is helper class that helps to talk with the Hive

class UserRepository {
  static const String boxName = 'users';

  Future<void> addUser(User user) async {
    final box = await Hive.openBox<User>(boxName);
    await box.put(user.userId, user);
  }

  Future<User?> getUserById(int id) async {
    final box = await Hive.openBox<User>(boxName);
    return box.get(id);
  }

  Future<List<User>> getAllUsers() async {
    final box = await Hive.openBox<User>(boxName);
    return box.values.toList();
  }

  Future<void> deleteUser(int id) async {
    final box = await Hive.openBox<User>(boxName);
    await box.delete(id);
  }

  Future<void> updateUser(User user) async {
    final box = await Hive.openBox<User>(boxName);
    await box.put(user.userId, user);
  }

  Future<User?> getUserByNameAndPassword(String email, String password) async {
    final box = await Hive.openBox<User>(boxName);
    try {
      return box.values.firstWhere(
        (user) => user.email == email && user.password == password,
      );
    } catch (_) {
      return null;
    }
  }
}
