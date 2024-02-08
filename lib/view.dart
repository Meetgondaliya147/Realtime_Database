import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:realtime_database/main.dart';

class view extends StatefulWidget {
  const view({super.key});

  @override
  State<view> createState() => _viewState();
}

class _viewState extends State<view> {
  DatabaseReference starCountRef = FirebaseDatabase.instance.ref('demo');
  List id=[];
  List val=[];
  @override
  // void initState() {
  //   // TODO: implement initState
  //   starCountRef.onValue.listen((DatabaseEvent event) {
  //     final data = event.snapshot.value;
  //     Map m=data as Map;
  //     print(m);
  //     id=m.keys.toList();
  //     val=m.values.toList();
  //     print(id);
  //     print(val);
  //
  //   });
  //
  // }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder(stream:starCountRef.onValue, builder: (context, snapshot) {
        if(snapshot.connectionState==ConnectionState.active){
          final data = snapshot.data!.snapshot.value;
          Map m=data as Map;
          val=m.values.toList();
          id=m.keys.toList();

        }
        return ListView.builder(itemCount: val.length,itemBuilder: (context, index) {
          return Card(child: ListTile(
            title: Text("${val[index]['name']}"),
            subtitle: Text("${val[index]['contact']}"),
            trailing: Wrap(children: [
              IconButton(onPressed: () {
                DatabaseReference ref = FirebaseDatabase.instance.ref("demo").child(id[index]);
                ref.remove();
              }, icon: Icon(Icons.delete)),
              IconButton(onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return first(val[index],id[index]);
                },));
              },icon: Icon(Icons.edit)),
            ]),

          ),);
        },);
      },),
    );
  }
}
