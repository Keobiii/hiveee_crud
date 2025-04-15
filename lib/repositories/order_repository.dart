import 'package:hive/hive.dart';
import 'package:hiveee/models/order.dart';

// this is helper class that helps to talk with the Hive

class OrderRepository {
  static const String boxName = 'orders';

  Future<void> addOrder(Order order) async {
    final box = await Hive.openBox<Order>(boxName);
    await box.put(order.id, order);
  }

  Future<Order?> getOrderById(int id) async {
    final box = await Hive.openBox<Order>(boxName);
    return box.get(id);
  }

  Future<List<Order>> getAllOrders() async {
    final box = await Hive.openBox<Order>(boxName);
    return box.values.toList();
  }

  Future<void> deleteOrder(int id) async {
    final box = await Hive.openBox<Order>(boxName);
    await box.delete(id);
  }

  Future<void> updateOrder(Order order) async {
    final box = await Hive.openBox<Order>(boxName);
    await box.put(order.id, order);
  }
}
