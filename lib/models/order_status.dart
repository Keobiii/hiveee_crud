enum OrderStatus {
  UK("Unknown", 0),
  OP("Order Place", 1),
  OC("Order Confirmed", 2),
  PR("Processing", 3),
  SH("Shipped", 4),
  IT("In Transit", 5),
  OD("Out for Delivery", 6),
  DV("Delivered", 7),
  CC("Canceled", 8),
  RT("Returned", 9),
  RF("Refunded", 10);

  final String status;
  final int statusId;

  const OrderStatus(this.status, this.statusId);

  static OrderStatus fromStatusId(int statusId) {
    return OrderStatus.values.firstWhere(
      (status) => status.statusId == status,
      orElse: () => OrderStatus.UK,
    );
  }
}
