// lib/pages/search_results_page.dart
import 'package:flutter/material.dart';
import 'package:app1/models/order_model.dart';

class SearchResultsPage extends StatelessWidget {
  final List<Product> results;

  const SearchResultsPage({Key? key, required this.results}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Results'),
        backgroundColor: const Color(0xFF2196F3),
      ),
      body: results.isEmpty
          ? Center(
              child: Text(
                'No products found',
                style: TextStyle(fontSize: 18, color: Colors.grey[600]),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: results.length,
              itemBuilder: (context, index) {
                final product = results[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 4,
                  child: ListTile(
                    leading: const SizedBox(
                      width: 56,
                      height: 56,
                      child: Icon(Icons.image_not_supported),
                    ),
                    title: Text(product.name ?? 'Unnamed Product'),
                    subtitle: Text(
                      product.price != null
                          ? 'TND ${product.price!.toStringAsFixed(2)}'
                          : 'Price unavailable',
                    ),
                    onTap: () {
                      // TODO: Navigate to product detail page
                    },
                  ),
                );
              },
            ),
    );
  }
}
