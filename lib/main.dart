import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:realtime_database/view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(

  );
  runApp(MaterialApp(home: first(),));
}
class first extends StatefulWidget {
  Map? val;
  String? id;
  first([this.val, this.id]);


  @override
  State<first> createState() => _firstState();
}

class _firstState extends State<first> {
  TextEditingController name=TextEditingController();
  TextEditingController contact=TextEditingController();
  TextEditingController t1=TextEditingController();
  TextEditingController t2=TextEditingController();
  TextEditingController t3=TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.id!=null){
      name.text=widget.val!['name'];
      contact.text=widget.val!['contact'];
      t1.text=widget.val!['marks']['sub1'];
      t2.text=widget.val!['marks']['sub2'];
      t3.text=widget.val!['marks']['sub3'];
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(children: [
        TextField(controller: name,),
        TextField(controller: contact,),
        TextField(controller: t1,),
        TextField(controller: t2,),
        TextField(controller: t3,),
        ElevatedButton(onPressed: () async {
          if(widget.id!=null){
            DatabaseReference ref = FirebaseDatabase.instance.ref("demo").child(widget.id!);
            await ref.update({
              "name": "${name.text}",
              "contact": "${contact.text}",
              "marks": {
                "sub1": t1.text,
                "sub2": t2.text,
                "sub3": t3.text,
              }
            });
          }else{
            DatabaseReference ref = FirebaseDatabase.instance.ref("demo").push();
            await ref.set({
              "name": "${name.text}",
              "contact": "${contact.text}",
              "marks": {
                "sub1": t1.text,
                "sub2": t2.text,
                "sub3": t3.text,
              }
            });
          }
        }, child: Text("Submit")),
        ElevatedButton(onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return view();
          },));
        }, child: Text("View")),
      ]),
    );
  }
}
