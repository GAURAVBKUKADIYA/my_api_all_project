import 'dart:convert';

import 'package:apiproject/models/Products.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ModelViewProduct extends StatefulWidget {
  @override
  State<ModelViewProduct> createState() => _ModelViewProductState();
}

class _ModelViewProductState extends State<ModelViewProduct> {
  List<Products> data;

  getproduct() async
  {
    Uri url = Uri.parse("http://picsyapps.com/studentapi/getProducts.php");
    var response= await http.get(url);
    if(response.statusCode==200)
    {
      var body = response.body.toString();
      var json =jsonDecode(body);
      print(json);
      setState(() {
        data = json["data"].map<Products>((obj) => Products.fromJson(obj)).toList();
      });
    }
    else
    {
      print("API Error");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getproduct();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("ModelViewProduct"),
        ),
      ),
      body: (data!=null)?ListView.builder(
        itemCount: data.length,
        itemBuilder: (context,index)
        {
          return ListTile(
            title: Text(data[index].pname.toString()),
            subtitle: Text(data[index].qty.toString()),
            trailing: Text("Rs."+data[index].price.toString()),
          );
        },
      ):CircularProgressIndicator(),
    );
  }
}
