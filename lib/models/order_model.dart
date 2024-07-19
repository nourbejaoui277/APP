class Order {
  final String id;
  final DateTime date;
  final List<String> items;
  final double totalAmount;
  final String status;

  Order({
    required this.id,
    required this.date,
    required this.items,
    required this.totalAmount,
    required this.status,
  });
}
