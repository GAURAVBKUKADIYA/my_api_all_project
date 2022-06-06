import 'dart:convert';

import 'package:apiproject/apipracViewproduct.dart';
import 'package:apiproject/resources/UrlHelper.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart'as http;

class apiPracUpdateProduct extends StatefulWidget {

  var updateid="";

  apiPracUpdateProduct({this.updateid});


  @override
  State<apiPracUpdateProduct> createState() => _apiPracUpdateProductState();
}

class _apiPracUpdateProductState extends State<apiPracUpdateProduct> {

  TextEditingController _name = TextEditingController();
  TextEditingController _qty = TextEditingController();
  TextEditingController _price = TextEditingController();


  getdata()async{
    Uri url = Uri.parse(UrlHelper.GET_SINGLE_PRODUCT);
    var response = await http.post(url,body: {"pid":widget.updateid});
    if(response.statusCode==200)
      {
        var json = jsonDecode(response.body.toString());
        if(json["status"]== "true")
          {
            setState(() {
              _name.text=json["data"]["pname"].toString();
              _qty.text=json["data"]["qty"].toString();
              _price.text=json["data"]["price"].toString();
            });
          }
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
          child: Text("Update Product"),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("ProductNmae",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
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
              SizedBox(height: 10,),
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

                    var name = _name.text.toString();
                    var qty = _qty.text.toString();
                    var price = _price.text.toString();

                    Uri url = Uri.parse(UrlHelper.GET_SINGLE_UPDATE_PRODUCT);
                    var response = await http.post(url,body: {
                      "pname":name,
                      "qty":qty,
                      "price":price,
                      "pid":widget.updateid
                    });
                    if(response.statusCode==200)
                      {
                        var body = response.body.toString();
                        var json = jsonDecode(body);
                        if(json["status"]=="true")
                          {
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context)=>apipracViewproduct())
                            );
                            Fluttertoast.showToast(
                                msg:"Sucsees Update" ,
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.green,
                                textColor: Colors.white,
                                fontSize: 16.0
                            );
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
