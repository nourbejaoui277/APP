import 'package:flutter/material.dart';

class RoleSelectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Role'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/clientHome');
              },
              child: Text('I am a Client'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF2F3861), // Use the same color
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/customerHome');
              },
              child: Text('I am a Customer'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF2F3861), // Use the same color
              ),
            ),
          ],
        ),
      ),
    );
  }
}



// import 'package:flutter/material.dart';

// class RoleSelectionPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Select Your Role'),
//         backgroundColor: Color(0xFF2F3861), // Updated color
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Color(0xFF2F3861), // Updated color
//                 padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
//                 textStyle: TextStyle(fontSize: 18),
//               ),
//               onPressed: () {
//                 // Navigate to client-specific page
//                 Navigator.pushNamed(context, '/clientHome');
//               },
//               child: Text('Client'),
//             ),
//             SizedBox(height: 30),
//             ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Color(0xFF2F3861), // Updated color
//                 padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
//                 textStyle: TextStyle(fontSize: 18),
//               ),
//               onPressed: () {
//                 // Navigate to customer-specific page
//                 Navigator.pushNamed(context, '/customerHome');
//               },
//               child: Text('Customer'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
