import 'dart:convert';

import 'package:apiproject/resources/UrlHelper.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductUpdate extends StatefulWidget {


  @override
  State<ProductUpdate> createState() => _ProductUpdateState();
}

class _ProductUpdateState extends State<ProductUpdate> {


  getdata()async{
    Uri url = Uri.parse(UrlHelper.GET_SINGLE_UPDATE_PRODUCT);
    var response = await http.get(url);
    if(response.statusCode==200)
      {
        var body = response.body.toString();
        var json = jsonDecode(body);
      }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("ProductUpdate"),
        ),
      ),
    );
  }
}
