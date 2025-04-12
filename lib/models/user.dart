import 'package:hive/hive.dart';
import 'package:hiveee/models/user_role.dart';

part 'user.g.dart';

@HiveType(typeId: 0)
class User {
  @HiveField(0)
  int id;

  @HiveField(1)
  int userRole;

  @HiveField(2)
  String email;

  @HiveField(3)
  String firstName;

  @HiveField(4)
  String lastName;

  @HiveField(5)
  String password;

  @HiveField(6)
  DateTime createdAt;

  User({
    required this.id,
    required this.userRole,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.password,
    required this.createdAt,
  });

  // Getter and Setter for role
  UserRole get role => UserRole.fromLevel(userRole);
  set role(UserRole role) => userRole = role.level;
}
