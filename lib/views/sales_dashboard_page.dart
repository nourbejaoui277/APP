import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart'; // Library for charts

class SalesDashboardPage extends StatelessWidget {
  // Sample data for the line chart
  final List<FlSpot> _monthlySalesData = [
    const FlSpot(1, 1000),
    const FlSpot(2, 1500),
    const FlSpot(3, 1300),
    const FlSpot(4, 2000),
    const FlSpot(5, 1800),
    const FlSpot(6, 2500),
    const FlSpot(7, 3000),
    const FlSpot(8, 2800),
    const FlSpot(9, 3200),
    const FlSpot(10, 3500),
    const FlSpot(11, 4000),
    const FlSpot(12, 4500),
  ];

  // Sample data for the pie chart
  final List<PieChartSectionData> _salesDistributionData = [
    PieChartSectionData(
      value: 40,
      color: Colors.blue,
      title: 'Product A',
      radius: 50,
    ),
    PieChartSectionData(
      value: 30,
      color: Colors.green,
      title: 'Product B',
      radius: 50,
    ),
    PieChartSectionData(
      value: 20,
      color: Colors.orange,
      title: 'Product C',
      radius: 50,
    ),
    PieChartSectionData(
      value: 10,
      color: Colors.red,
      title: 'Product D',
      radius: 50,
    ),
  ];

  // Sample data for top products
  final List<Map<String, String>> _topProducts = [
    {'name': 'Product A', 'sales': '\$4,000'},
    {'name': 'Product B', 'sales': '\$3,000'},
    {'name': 'Product C', 'sales': '\$2,000'},
    {'name': 'Product D', 'sales': '\$1,000'},
  ];

  SalesDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sales Dashboard'),
        backgroundColor: const Color(0xFF2F3861),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Total Sales Card
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total Sales',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '\$10,000',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Monthly Sales Chart
            const Text(
              'Monthly Sales',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 200,
              child: LineChart(
                LineChartData(
                  gridData: const FlGridData(show: false),
                  titlesData: const FlTitlesData(show: false),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      spots: _monthlySalesData,
                      isCurved: true,
                      barWidth: 4,
                      belowBarData: BarAreaData(show: false),
                      dotData: const FlDotData(show: false),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Sales Distribution Pie Chart
            const Text(
              'Sales Distribution',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 200,
              child: PieChart(
                PieChartData(
                  sections: _salesDistributionData,
                  centerSpaceRadius: 40,
                  sectionsSpace: 0,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Top Products List
            const Text(
              'Top Products',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _topProducts.length,
              itemBuilder: (context, index) {
                final product = _topProducts[index];
                return Card(
                  elevation: 2,
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blue.withOpacity(0.1),
                      child: Text(
                        '${index + 1}',
                        style: const TextStyle(color: Colors.blue),
                      ),
                    ),
                    title: Text(product['name']!),
                    trailing: Text(
                      product['sales']!,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
