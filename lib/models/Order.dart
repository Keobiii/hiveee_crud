import 'package:hive_flutter/adapters.dart';
import 'package:hiveee/models/order_status.dart';

part 'order.g.dart';

@HiveType(typeId: 2)
class Order {
  @HiveField(0)
  int id;

  @HiveField(1)
  int status;

  @HiveField(2)
  DateTime orderedAt;

  Order({required this.id, required this.status, required this.orderedAt});

  // Getter
  OrderStatus get statsId => OrderStatus.fromStatusId(status);

  // Setter
  set statsId(OrderStatus statsId) => status = statsId.statusId;
}
