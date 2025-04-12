import 'package:hive/hive.dart';
import 'package:hiveee/models/user.dart';

class UserHiveService {
  final Box<User> _userBox = Hive.box<User>('users');

  // CREATE
  Future<void> addUser(User user) async {
    await _userBox.put(user.id, user);
  }

  // READ
  List<User> getAllUsers() {
    return _userBox.values.toList();
  }

  // UPDATE
  Future<void> updateUser(int id, User updateUser) async {
    await _userBox.put(id, updateUser);
  }

  // DELETE
  Future<void> deleteUser(int id) async {
    await _userBox.delete(id);
  }

  // Get user by ID
  User? getUserById(int id) {
    return _userBox.get(id);
  }

  // CLEAR ALL Users
  Future<void> clearAllUsers() async {
    await _userBox.clear();
  }
}