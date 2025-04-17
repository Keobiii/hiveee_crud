import 'package:hive_flutter/adapters.dart';
import 'package:hiveee/models/order_status.dart';

part 'order.g.dart';

@HiveType(typeId: 2)
class Order {
  @HiveField(0)
  int orderId;

  @HiveField(1)
  int productId;

  @HiveField(2)
  int userId;

  @HiveField(3)
  int status;

  @HiveField(4)
  DateTime orderedAt;

  Order({
    required this.orderId,
    required this.productId,
    required this.userId,
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

Order myOrder = Order(
  orderId: 123,
  productId: 456, // Example Product ID
  userId: 789, // Example User ID
  status: 1,
  orderedAt: DateTime.now(),
);


Retrieve
var productBox = Hive.box<Product>('productBox');
Product myProduct = productBox.get(myOrder.productId)!;

var userBox = Hive.box<User>('userBox');
User myUser = userBox.get(myOrder.userId)!;


*/