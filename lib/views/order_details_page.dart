// views/order_details_page.dart
import 'package:flutter/material.dart';
import 'package:app1/models/order_model.dart';

class OrderDetailsPage extends StatelessWidget {
  final Order order;

  const OrderDetailsPage({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Details'),
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Order ID: ${order.id}', style: TextStyle(fontSize: 20)),
            SizedBox(height: 10),
            Text('Date: ${order.date}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text('Items:', style: TextStyle(fontSize: 16)),
            ...order.items.map((item) => Text('- $item')).toList(),
            SizedBox(height: 10),
            Text('Total Amount: \$${order.totalAmount}',
                style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text('Status: ${order.status}', style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
