import 'dart:convert';

import 'package:apiproject/models/Employed.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;

class ModelViewEmployed extends StatefulWidget {


  @override
  State<ModelViewEmployed> createState() => _ModelViewEmployedState();
}

class _ModelViewEmployedState extends State<ModelViewEmployed> {
  List<Employed> data;
  
  getemployed()async
  {
    Uri url = Uri.parse("http://picsyapps.com/studentapi/getEmployee.php");
    var response = await http.get(url);
    if(response.statusCode==200)
      {
        var body = response.body.toString();
        var json = jsonDecode(body);
        setState(() {
          data = json["data"].map<Employed>
            ((obj) => Employed.fromJson(obj)
          ).toList();
        });
      }
  }
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getemployed();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("ModelViewEmployed"),
        ),
      ),
      body:(data!=null) ?ListView.builder(
        itemCount:data.length,
        itemBuilder: (context,index){
          return Container(
            color: Colors.red.shade100,
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text("Id:- "+data[index].eid.toString()),
                Text("Name:- "+data[index].ename.toString()),
                Text(data[index].salary.toString()),
                Text(data[index].gender.toString()),
                Text(data[index].department.toString()),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        onPressed: ()async{},


                        child:Text("Delete")),
                    ElevatedButton(
                        onPressed: ()async{},

                        child:Text("Update"))
                  ],
                )
              ],
            ),
          );
        },
      ):CircularProgressIndicator()
    );
  }
}
