import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app1/controllers/order_controller.dart';
import 'package:app1/services/order_service.dart';
import 'package:app1/models/order_model.dart';

class OrdersPage extends StatelessWidget {
  final String boutiqueId;

  const OrdersPage({super.key, required this.boutiqueId});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => OrdersController(
        orderService: OrderService(),
        boutiqueId: boutiqueId,
      )..fetchOrders(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Orders"),
          backgroundColor: const Color(0xFFEFEFEF),
          elevation: 0,
          actions: const [_StatusFilterDropdown()],
        ),
        body: _OrdersList(),
      ),
    );
  }
}

class _StatusFilterDropdown extends StatelessWidget {
  const _StatusFilterDropdown();

  static const List<String> statusFilters = [
    'All',
    'Pending',
    'Processing',
    'Shipped',
    'Delivered',
    'Cancelled'
  ];

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<OrdersController>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: DropdownButton<String>(
        value: controller.selectedStatus,
        items: statusFilters
            .map((status) =>
                DropdownMenuItem(value: status, child: Text(status)))
            .toList(),
        onChanged: (value) {
          if (value != null) controller.setSelectedStatus(value);
        },
      ),
    );
  }
}

class _OrdersList extends StatelessWidget {
  //const _OrdersList();

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<OrdersController>();

    if (controller.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (controller.filteredOrders.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.receipt_long_outlined, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'No orders available',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () => controller.fetchOrders(),
      child: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: controller.filteredOrders.length,
        itemBuilder: (context, index) {
          final order = controller.filteredOrders[index];
          return Card(
            elevation: 2,
            margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            child: ExpansionTile(
              title: Text(
                'Order #${order.id}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Total: \$${order.totalAmount?.toStringAsFixed(2)}'),
                  Text('Status: ${order.status}'),
                  Text(
                    'Placed: ${order.createdAt.toString().substring(0, 10)}',
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Items:',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      ...order.orderItems!.map((item) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    '${item.product?.name ?? 'Unnamed'} x${item.quantity}',
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Text(
                                    '\$${(item.unitPrice! * num.parse(item.quantity.toString())).toStringAsFixed(2)}'),
                              ],
                            ),
                          )),
                      const SizedBox(height: 8),
                      Text(
                        'Customer ID: ${order.userId}',
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
