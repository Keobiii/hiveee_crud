import 'package:hive_flutter/adapters.dart';
import 'package:hiveee/models/order_status.dart';
import 'package:hiveee/models/product.dart';
import 'package:hiveee/models/user.dart';

part 'order.g.dart';

@HiveType(typeId: 2)
class Order {
  @HiveField(0)
  int orderId;

  @HiveField(1)
  Product product;

  @HiveField(2)
  User user;

  @HiveField(3)
  int status;

  @HiveField(4)
  DateTime orderedAt;

  Order({
    required this.orderId,
    required this.product,
    required this.user,
    required this.status,
    required this.orderedAt,
  });

  // Getter
  OrderStatus get statsId => OrderStatus.fromStatusId(status);

  // Setter
  set statsId(OrderStatus statsId) => status = statsId.statusId;
}


/*

Store

void saveOrder(Box<Order> orderBox, Box<User> userBox) {
  // Create a User
  var user = User(
    userId: 1,
    userRole: 0, 
    email: "user@example.com",
    firstName: "John",
    lastName: "Doe",
    password: "securepassword",
    createdAt: DateTime.now(),
  );

  userBox.put(user.userId, user); // Store User in Hive

  // Create an Order linked to the User object
  var order = Order(
    orderId: 1001,
    productId: 500,
    user: user, // Reference the User object directly
    status: 1,
    orderedAt: DateTime.now(),
  );

  orderBox.put(order.orderId, order); // Store Order in Hive
}


Retrieve
void fetchOrder(Box<Order> orderBox) {
  var order = orderBox.get(1001);

  if (order != null) {
    print("Order was placed by: ${order.user.firstName} ${order.user.lastName}");
  }
}


*/