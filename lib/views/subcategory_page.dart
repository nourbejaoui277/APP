// // subcategories_page.dart
// import 'package:flutter/material.dart';

// class SubcategoryPage extends StatelessWidget {
//   final String subcategoryName;

//   SubcategoryPage({required this.subcategoryName});

//   final List<Map<String, String>> products = [
//     {
//       'name': 'Product 1',
//       'image': 'assets/images/product1.jpg',
//       'price': '\$30'
//     },
//     {
//       'name': 'Product 2',
//       'image': 'assets/images/product2.jpg',
//       'price': '\$40'
//     },
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('$subcategoryName'),
//         backgroundColor: Colors.purple,
//       ),
//       body: GridView.builder(
//         padding: EdgeInsets.all(16),
//         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//           crossAxisSpacing: 16,
//           mainAxisSpacing: 16,
//           childAspectRatio: 0.7,
//         ),
//         itemCount: products.length,
//         itemBuilder: (context, index) {
//           return _buildProductCard(context, products[index]);
//         },
//       ),
//     );
//   }

//   Widget _buildProductCard(BuildContext context, Map<String, String> product) {
//     return Card(
//       elevation: 3,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(15),
//       ),
//       child: Column(
//         children: [
//           Expanded(
//             child: ClipRRect(
//               borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
//               child: Image.asset(
//                 product['image']!,
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Column(
//               children: [
//                 Text(
//                   product['name']!,
//                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                   textAlign: TextAlign.center,
//                 ),
//                 SizedBox(height: 5),
//                 Text(
//                   product['price']!,
//                   style: TextStyle(fontSize: 16, color: Colors.green),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
