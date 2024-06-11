import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


// write the layout of the app page RegisterPage
class RegisterPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _RegisterPageState();
  }


}

class _RegisterPageState extends State<RegisterPage>{

  List<String> list = List<String>.empty(growable: true);
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
list.add("tesst");
list.add("test 2");
debugPrint("list $list");
  }



  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Icon(Icons.arrow_back, color: Colors.yellow,)
        ),
        title: const Center(child: const Text("title",style: TextStyle(color: Colors.red))),
      ),
      body: ListView.builder(
       itemCount: 2,
       itemBuilder: (context, index) {
        return Text(list[index], style: TextStyle(color: Colors.lightGreen),);
       },
       ),
      // body: Column(
      //   children: [
      //     Container(
      //       child: Icon(Icons.add_a_photo_outlined, color: Colors.amber,size: 50,),
            
      //     ),
      //     Row(
      //       children: [
      //         Icon(Icons.abc, color:  Colors.black,size: 50,),
      //         Icon(Icons.ac_unit_outlined, color:  Colors.deepPurpleAccent,size: 50,)
      //       ],
      //     )
      //   ],
      // ),
    );
    
  }
}