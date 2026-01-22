// import 'package:flutter/material.dart';
// import 'men_page.dart';
// import 'women_page.dart';
// import 'kids_page.dart';

// class CategoriesPage extends StatelessWidget {
//   final String category;

//   CategoriesPage({
//     super.key,
//     required this.category,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Categories',
//           style: TextStyle(
//             fontSize: 24,
//             fontWeight: FontWeight.bold,
//             color: Colors.white,
//           ),
//         ),
//         backgroundColor: const Color(0xFF2F3861),
//         elevation: 0,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: GridView.builder(
//           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 2,
//             crossAxisSpacing: 16,
//             mainAxisSpacing: 16,
//             childAspectRatio: 1.2,
//           ),
//           itemCount: _categories.length,
//           itemBuilder: (context, index) {
//             return _buildCategoryCard(context, _categories[index]);
//           },
//         ),
//       ),
//     );
//   }

//   final List<Map<String, dynamic>> _categories = [
//     {'name': 'Men', 'icon': Icons.man, 'color': Colors.blue},
//     {'name': 'Women', 'icon': Icons.woman, 'color': Colors.pink},
//     {'name': 'Kids', 'icon': Icons.child_care, 'color': Colors.orange},
//     {'name': 'Accessories', 'icon': Icons.watch, 'color': Colors.purple},
//     {'name': 'Shoes', 'icon': Icons.shopping_bag, 'color': Colors.green},
//     {
//       'name': 'Electronics',
//       'icon': Icons.electrical_services,
//       'color': Colors.red
//     },
//   ];

//   Widget _buildCategoryCard(
//       BuildContext context, Map<String, dynamic> category) {
//     return GestureDetector(
//       onTap: () {
//         _navigateToCategory(context, category['name']);
//       },
//       child: Card(
//         elevation: 5,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(15),
//         ),
//         child: Container(
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//               colors: [
//                 category['color'].withOpacity(0.8),
//                 category['color'].withOpacity(0.4),
//               ],
//             ),
//             borderRadius: BorderRadius.circular(15),
//           ),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(
//                 category['icon'],
//                 size: 50,
//                 color: Colors.white,
//               ),
//               const SizedBox(height: 10),
//               Text(
//                 category['name'],
//                 style: const TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void _navigateToCategory(BuildContext context, String category) {
//     switch (category) {
//       case 'Men':
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => MenPage()),
//         );
//         break;
//       case 'Women':
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => WomenPage()),
//         );
//         break;
//       case 'Kids':
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => KidsPage()),
//         );
//         break;

//       default:
//         break;
//     }
//   }
// }
