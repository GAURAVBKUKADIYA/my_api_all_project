import 'dart:convert';

import 'package:apiproject/ViewProduct.dart';
import 'package:apiproject/resources/UrlHelper.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UpdateYourProduct extends StatefulWidget {
  var updatepid = "";

  UpdateYourProduct({this.updatepid});

  @override
  State<UpdateYourProduct> createState() => _UpdateYourProductState();
}

class _UpdateYourProductState extends State<UpdateYourProduct> {
  TextEditingController _name = TextEditingController();
  TextEditingController _qty = TextEditingController();
  TextEditingController _price = TextEditingController();

  getdata() async {
    Uri url = Uri.parse(UrlHelper.GET_SINGLE_PRODUCT);
    var response = await http.post(url, body: {"pid": widget.updatepid});
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body.toString());
      if (json["status"] == "true") {
        setState(() {
          _name.text = json["data"]["pname"].toString();
          _qty.text = json["data"]["qty"].toString();
          _price.text = json["data"]["price"].toString();
        });
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
    //updatedata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("UpdateYourProduct"),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "ProductName",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: _name,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                keyboardType: TextInputType.text,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Qty",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: _qty,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
              Text(
                "Price",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: _price,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                keyboardType: TextInputType.text,
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    var name = _name.text.toString();
                    var qty = _qty.text.toString();
                    var price = _price.text.toString();

                    Uri url = Uri.parse(UrlHelper.GET_SINGLE_UPDATE_PRODUCT);
                    var response = await http.post(url,body: {
                      "pname":name,
                      "qty":qty,
                      "price":price,
                      "pid":widget.updatepid
                    });
                    if (response.statusCode == 200) {

                      var body = response.body.toString();
                      var json = jsonDecode(body);
                    if(json["status"]=="true")
                      {
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => ViewProduct()));
                      }
                    }


                  },
                  child: Text("Update"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
