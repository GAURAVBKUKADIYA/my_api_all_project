import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
class AddEmployed extends StatefulWidget {


  @override
  State<AddEmployed> createState() => _AddEmployedState();
}

class _AddEmployedState extends State<AddEmployed> {


  TextEditingController _name = TextEditingController();

  TextEditingController _sallary = TextEditingController();

  var _gender = "male";
  var _select = "Marketing";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("AddEmployed"),
        ),
      ),
      body: SingleChildScrollView(
    
        child: Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Name",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
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
              Text("Sallary",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              SizedBox(height: 10,),
              TextField(
                controller: _sallary,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20,),
              Divider(height: 0.5,color: Colors.teal,),
              Text("Gendre",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Radio(
                    activeColor: Colors.blue,
                    groupValue: _gender,
                    value: "male",
                    onChanged: (val)
                    {
                      setState(() {
                        _gender=val;
                      });
                    },
                  ),
                  Text("Male",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                  Radio(
                    activeColor: Colors.green,
                    groupValue: _gender,
                    value: "female",
                    onChanged: (val)
                    {
                      setState(() {
                        _gender=val;
                      });
                    },
                  ),
                  Text("Female",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),

                  Radio(
                    activeColor: Colors.red,
                    groupValue: _gender,
                    value: "other",
                    onChanged: (val)
                    {
                      setState(() {
                        _gender=val;
                      });
                    },
                  ),
                  Text("Other",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                ],
              ),
              Divider(height: 5,color: Colors.blue,),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("Department :-",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  DropdownButton(
                    value: _select,
                    onChanged: (val)
                    {
                      setState(() {
                        _select=val;
                      });
                    },
                    items: [
                      DropdownMenuItem(
                        child: Text("Employed"),
                        value: "Employed",
                      ),
                      DropdownMenuItem(
                        child: Text("Marketing"),
                        value: "Marketing",
                      ),
                      DropdownMenuItem(
                        child: Text("Production"),
                        value: "Production",
                      ),
                      DropdownMenuItem(
                        child: Text("Staff"),
                        value: "Staff",
                      ),
                      DropdownMenuItem(
                        child: Text("Delivery"),
                        value: "Delivery",
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20,),
              Center(
                child: ElevatedButton(
                  onPressed: ()async {
                    var name = _name.text.toString();
                    var sallary = _sallary.text.toString();
                    var gender = _gender.toString();
                    var select = _select.toString();
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
                    else if(sallary.length<=0)
                      {
                        Fluttertoast.showToast(
                            msg:"Add Your Sallary" ,
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0
                        );
                      }
                    else
                      {
                        Uri url = Uri.parse("http://picsyapps.com/studentapi/insertEmployeeNormal.php");
                        var response = await http.post(url,body: {
                          "ename":name,
                          "salary":sallary,
                          "department":select,
                          "gender":gender
                        });
                        if(response.statusCode==200)
                        {
                          var body = response.body.toString();
                          var json = jsonDecode(body);
                          var message = json["message"].toString();
                          Fluttertoast.showToast(
                              msg:message ,
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.green,
                              textColor: Colors.white,
                              fontSize: 16.0
                          );
                          _name.text = "";
                          _sallary.text="";
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
