import 'package:hive/hive.dart';
import 'package:hiveee/models/user_role.dart';

// It converts the User object to and from a binary format, so Hive can save it to disk. We dont ever write or edit this file manually.
part 'user.g.dart';
// after initializiting run ths "flutter packages pub run build_runner build"

//@HiveType and @HiveField is for the serialization in Hive
// typeId is a unique ID to identify this model in Hive
// Structure of User and its fields like id, name, email, and password, its annotate with @HiveField()
@HiveType(typeId: 0)
class User {
  @HiveField(0)
  int userId;

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
    required this.userId,
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
