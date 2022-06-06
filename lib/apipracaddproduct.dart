import 'dart:convert';

import 'package:apiproject/resources/UrlHelper.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart'as http;

class apipracaddproduct extends StatefulWidget {


  @override
  State<apipracaddproduct> createState() => _apipracaddproductState();
}

class _apipracaddproductState extends State<apipracaddproduct> {
  TextEditingController _name = TextEditingController();
  TextEditingController _qty = TextEditingController();
  TextEditingController _price = TextEditingController();





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("AddProduct"),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Text("ProductName",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
              SizedBox(height: 10,),
              TextField(
                controller: _name,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),),
                keyboardType: TextInputType.text,
              ),
              SizedBox(height: 10,),
              Text("Quantity",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
              SizedBox(height: 10,),
              TextField(
                controller: _qty,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),),
                keyboardType: TextInputType.text,
              ),
              Text("Price",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
              SizedBox(height: 10,),
              TextField(
                controller: _price,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),),
                keyboardType: TextInputType.text,
              ),
              SizedBox(height: 20,),

              Center(
                child: ElevatedButton(
                  onPressed: ()async{

                    var name=_name.text.toString();
                    var qty = _qty.text.toString();
                    var price = _price.text.toString();

                    if(name.length<=0)
                      {
                        Fluttertoast.showToast(
                            msg:"Add your Name" ,
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0
                        );
                      }
                    else if(qty.length<=0)
                      {
                        Fluttertoast.showToast(
                            msg:"Add your Quantity" ,
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0
                        );
                      }
                    else if(price.length<=0)
                    {
                      Fluttertoast.showToast(
                          msg:"Add your Price" ,
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0
                      );
                    }

                    else{

                      Uri url=Uri.parse(UrlHelper.ADD_PRODUCT_NORMAL);
                      var response = await http.post(url,body: {
                        "pname":name,
                        "qty":qty,
                        "price":price
                      });
                      if(response.statusCode==200)
                      {
                        var body = response.body.toString();
                        var json = jsonDecode(body);
                        var msg=json["message"].toString();
                        Fluttertoast.showToast(
                            msg:msg,
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.green,
                            textColor: Colors.white,
                            fontSize: 16.0
                        );
                        _name.text = "";
                        _qty.text="";
                        _price.text="";
                      }
                      else
                      {
                        Fluttertoast.showToast(
                            msg: "Api Eror",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0
                        );
                      }
                    }

                  },




                  child: Text("Add"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
