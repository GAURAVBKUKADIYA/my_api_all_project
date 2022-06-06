import 'dart:convert';

import 'package:apiproject/models/Vechicle.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;

class ModelViewVechicle extends StatefulWidget {


  @override
  State<ModelViewVechicle> createState() => _ModelViewVechicleState();
}

class _ModelViewVechicleState extends State<ModelViewVechicle> {
  List<Vehicle> data;


  getvechicle()async
  {
    Uri url = Uri.parse("http://api.citybik.es/v2/networks");
    var response = await http.get(url);
    if(response.statusCode==200)
      {
        var body = response.body.toString();
        var json = jsonDecode(body);
        setState(() {
          data = json["networks"].map<Vehicle>
            ((obj) => Vehicle.fromJson(obj)
          ).toList();
        });
      }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getvechicle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (data!=null)?ListView.builder(
          itemCount:data.length,
          itemBuilder: (context,index){
            return Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
              Text(data[index].href.toString())
                  
                ],
              ),
            );
          }
        ):Center(child: CircularProgressIndicator(),)

    );
  }
}
